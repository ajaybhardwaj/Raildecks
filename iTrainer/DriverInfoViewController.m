//
//  DriverInfoViewController.m
//  iTrainer
//
//  Created by Ajay Bhardwaj on 02/07/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import "DriverInfoViewController.h"

@interface DriverInfoViewController ()

@end

@implementation DriverInfoViewController
@synthesize popController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//********************************************* For Checking Internet Connectivity ********************************************************//

- (bool) connectedToWiFi
{
	Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	bool result = false;
	if (internetStatus == ReachableViaWiFi || internetStatus == ReachableViaWWAN)
	{
	    result = true;
	}
	return result;
}


//***************************************** Method To Move To Major Components View COntroller **********************************************//


- (void) moveToMajorComponentsViewController {
    
    MajorComponentsViewController *obj = [[MajorComponentsViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
}


//********************************************* Method To Move To Manual View COntroller **************************************************//

- (void) moveToManualViewController {
    
    ManualViewController *obj = [[ManualViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
}



//********************************************** Method To Check Valid Email Entry ********************************************************//

- (BOOL) NSStringIsValidEmail:(NSString *)checkString {
    
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL result = [emailTest evaluateWithObject:checkString];
    return result;
}


//*********************************************** For Moving Back To Previous View ********************************************************//

- (void) moveBackToPreviousView {
    
    [self.navigationController popViewControllerAnimated:YES];
}


//********************************************************* For Dismissing Keypad *********************************************************//

- (void) dismissKeypad {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    CGPoint pos = self.view.center;
    pos.y = 385;
    self.view.center = pos;
    [UIView commitAnimations];
    [nameField resignFirstResponder];
    [companyField resignFirstResponder];
    [cityField resignFirstResponder];
    [stateField resignFirstResponder];
    [emailField resignFirstResponder];
    [mobileField resignFirstResponder];
}



//*************************************************** For Uploading Driver Image To Server ************************************************//

- (void) uploadDriverImageToServer {
    
    [loadingIndicator startAnimating];
    
    NSData *imageData = UIImageJPEGRepresentation(driverImage, 90);
    NSString *urlString = @"http://54.200.182.176/api/uploads/upload.php";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    imageUploadReturnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"image returned string is %@",imageUploadReturnString);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}


//*************************************************** For Uploading Driver Info To Server *************************************************//

- (void) uploadDriverInfoToServer {
    
    
    NSString *urlString;
    if (driverImage==nil) {
        urlString = [NSString stringWithFormat:@"http://54.200.182.176/api/signup.php?ed=%@&tid=%@&nm=%@&cmp=%@&cty=%@&eid=%@&pr=%@&mn=%@&imgp=dummy.jpg",dateField.text,delegate.TRAINERID,nameField.text,companyField.text,cityField.text,emailField.text,stateField.text,mobileField.text];
    }
    else {
        [self uploadDriverImageToServer];
        urlString = [NSString stringWithFormat:@"http://54.200.182.176/api/signup.php?ed=%@&tid=%@&nm=%@&cmp=%@&cty=%@&eid=%@&pr=%@&mn=%@&imgp=%@",dateField.text,delegate.TRAINERID,nameField.text,companyField.text,cityField.text,emailField.text,stateField.text,mobileField.text,imageUploadReturnString];
    }
    
    urlString = [urlString  stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
    
    
    NSLog(@"%@",urlString);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];        
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",responseString);
    
    if ([responseString isEqualToString:@"11"]) {
        
        [loadingIndicator stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"E-Mail already exists. Please try another one." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else if ([responseString isEqualToString:@"0"]) {
        
        [loadingIndicator stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Some network problem, please try later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else {
        
        [loadingIndicator stopAnimating];
        //[delegate deleteAllData];
        delegate.DRIVERID = [responseString intValue];
        delegate.DRIVERNAME = nameField.text;
        delegate.DRIVERCOMPANY = companyField.text;
        delegate.DRIVERCITY = cityField.text;
        delegate.DRIVERPROVIANCE = stateField.text;
        delegate.DRIVEREMAIL = emailField.text;
        delegate.DRIVERMOBILE = mobileField.text;
        
        [delegate insertNewDriverDetails];
    
        PreModuleViewController *obj = [[PreModuleViewController alloc] init];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    
}



//********************************************** For Moving To Introduction View COntroller ***********************************************//

- (void) moveToPreModuleView {
    
    [nameField resignFirstResponder];
    [companyField resignFirstResponder];
    [cityField resignFirstResponder];
    [emailField resignFirstResponder];
    [stateField resignFirstResponder];
    [mobileField resignFirstResponder];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    CGPoint pos = self.view.center;
    pos.y = 385;
    self.view.center = pos;
    [UIView commitAnimations];
    
    UIAlertView *alert;
    
    NSCharacterSet *set1 = [NSCharacterSet characterSetWithCharactersInString:@"0123456789<>,.?/:;}{[]|)(*&^!@#$%+=-_"];
//    NSCharacterSet *set2 = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ<>,.?/:;}{[]|)(*&^!@#$%+=-_"];
    NSCharacterSet *set2 = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ<>,.?/:;}{[]|)(*&^!@#$%=_"];

    
    if ([nameField.text length] == 0) {        
        alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"Name field cannot be empty." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    else if ([nameField.text rangeOfCharacterFromSet:set1].location != NSNotFound) {
        alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"Invalid name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([companyField.text length] == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"Company field cannot be empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    else if ([cityField.text length] == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"City field cannot be empty." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    else if ([cityField.text rangeOfCharacterFromSet:set1].location != NSNotFound) {
        alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"Invalid city name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([stateField.text length] == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"State field cannot be empty." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    else if ([stateField.text rangeOfCharacterFromSet:set1].location != NSNotFound) {
        alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"Invalid state name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([emailField.text length] == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"Email field cannot be empty." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    else if (![self NSStringIsValidEmail:emailField.text]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"Invalid email id." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([mobileField.text length] == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"Mobile field cannot be empty." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
//    else if ([mobileField.text length] != 10) {
//        alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"Mobile number should be 10 digit long." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
//        [alert show];
//    }
    else if ([mobileField.text rangeOfCharacterFromSet:set2].location != NSNotFound) {
        alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"Invalid mobile number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
    
        if ([self connectedToWiFi]) {
            [loadingIndicator startAnimating];
            [self performSelectorInBackground:@selector(uploadDriverInfoToServer) withObject:nil];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"No internet connectivity. Please try later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}


//********************************************** For Showing Action Sheet For Picture Taking **********************************************//


- (void) showDriverPictureActionSheet {
    
    takePictureActionSheet = [[UIActionSheet alloc] initWithTitle:@"Take Picture via" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Library",@"Cancel", nil];
    takePictureActionSheet.destructiveButtonIndex = 2;
    takePictureActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [takePictureActionSheet showInView:self.view.window];
}


# pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet==takePictureActionSheet) {
        ipc = [[UIImagePickerController alloc] init];
        ipc.delegate = self;
        if (buttonIndex==0) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentModalViewController:ipc animated:YES];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Camera is not available" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
            }
            
        }
        else if (buttonIndex==1) {
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:ipc];
            self.popController = popover;
            [self.popController presentPopoverFromRect:CGRectMake(280, 50, 500, 10) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        
    }
}



# pragma mark - UIImagePickerControllerDelegate Methods

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    driverImage = [[UIImage alloc] init];
    driverImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [ipc dismissModalViewControllerAnimated:YES];
    [ipc.view removeFromSuperview];
	ipc = nil;
    [self.popController dismissPopoverAnimated:YES];
    self.popController = nil;
}



# pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField==companyField || textField==cityField || textField==emailField || textField==emailField || textField==stateField || textField==mobileField) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        CGPoint pos = self.view.center;
        pos.y = 385;
        self.view.center = pos;
        [UIView commitAnimations];
    }
    [textField resignFirstResponder];
    return YES;
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField==dateField) {
        return NO;
    }
    else if (textField==companyField || textField==cityField || textField==emailField || textField==stateField) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        CGPoint pos = self.view.center;
        pos.y = 150;
        self.view.center = pos;
        [UIView commitAnimations];
        return YES;
    }
    else if (textField==mobileField) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        CGPoint pos = self.view.center;
        pos.y = 50;
        self.view.center = pos;
        [UIView commitAnimations];
        return YES;
    }
    else {
        return YES;
    }
}




# pragma mark - View Lifecycle Methods

- (void)viewDidLoad
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    delegate = (iTrainerAppDelegate*)[UIApplication sharedApplication].delegate;

    
    topHeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 124)];
    [topHeaderImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TopBanner.png",delegate.resourceFolderPath]]];
    [self.view addSubview:topHeaderImageView];
    topHeaderImageView.userInteractionEnabled = YES;
    
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(100, 92, 116, 29);
    [backButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/BackButton.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/BackButton_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(moveBackToPreviousView) forControlEvents:UIControlEventTouchUpInside];
    [topHeaderImageView addSubview:backButton];
    
    /*
    nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(800, 92, 116, 29);
    [nextButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/NextButton.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [nextButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/NextButton_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    //[nextButton addTarget:self action:@selector(moveToMenuViewController) forControlEvents:UIControlEventTouchUpInside];
    [topHeaderImageView addSubview:nextButton];
    */
    
    startLabel = [[UILabel alloc] initWithFrame:CGRectMake(350, 80, 300, 50)];
    startLabel.backgroundColor = [UIColor clearColor];
    startLabel.textAlignment = UITextAlignmentCenter;
    startLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
    startLabel.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    startLabel.text = [NSString stringWithFormat:@"START"];
    [self.view addSubview:startLabel];
    
    
    bodyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 124, 1024, 644)];
    [bodyImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Body.png",delegate.resourceFolderPath]]];
    [self.view addSubview:bodyImageView];
    bodyImageView.userInteractionEnabled = YES;
    
    welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 135, 290, 50)];
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.text = [NSString stringWithFormat:@"DRIVER INFORMATION"];
    [self.view addSubview:welcomeLabel];
    
    usermanualButton = [UIButton buttonWithType:UIButtonTypeCustom];
    usermanualButton.frame = CGRectMake(200, 615, 119, 16);
    [usermanualButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/UserManual.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [usermanualButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/UserManual_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    [usermanualButton addTarget:self action:@selector(moveToManualViewController) forControlEvents:UIControlEventTouchUpInside];
    [bodyImageView addSubview:usermanualButton];
    
    majorcomponentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    majorcomponentButton.frame = CGRectMake(700, 615, 193, 16);
    [majorcomponentButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/MajorComponents2.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [majorcomponentButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/MajorComponents2_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    [majorcomponentButton addTarget:self action:@selector(moveToMajorComponentsViewController) forControlEvents:UIControlEventTouchUpInside];
    [bodyImageView addSubview:majorcomponentButton];
    
    
    dateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 839, 58)];
    [dateImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/DriverInfoDate.png",delegate.resourceFolderPath]]];
    [bodyImageView addSubview:dateImageView];
    dateImageView.userInteractionEnabled = YES;
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy"];
    NSString *dateString = [formatter stringFromDate:today];
    
    dateField = [[UITextField alloc] initWithFrame:CGRectMake(185, 0, 655, 58)];
    dateField.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
    dateField.textAlignment = UITextAlignmentLeft;
    dateField.autocorrectionType = UITextAutocorrectionTypeNo;
    dateField.clearButtonMode = UITextFieldViewModeWhileEditing;
    dateField.borderStyle = UITextBorderStyleNone;
    dateField.backgroundColor = [UIColor clearColor];
    dateField.delegate = self;
    dateField.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    dateField.text = dateString;
    [dateField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    dateField.keyboardType = UIKeyboardTypeDefault;
    [dateImageView addSubview:dateField];
    
    nameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 160, 839, 58)];
    [nameImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/DriverInfoName.png",delegate.resourceFolderPath]]];
    [bodyImageView addSubview:nameImageView];
    nameImageView.userInteractionEnabled = YES;
    
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(185, 0, 655, 58)];
    nameField.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
    nameField.textAlignment = UITextAlignmentLeft;
    nameField.autocorrectionType = UITextAutocorrectionTypeNo;
    nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameField.borderStyle = UITextBorderStyleNone;
    nameField.backgroundColor = [UIColor clearColor];
    nameField.delegate = self;
    nameField.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    [nameField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    nameField.keyboardType = UIKeyboardTypeDefault;
    [nameImageView addSubview:nameField];
    
    companyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 220, 839, 58)];
    [companyImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/DriverInfoCompany.png",delegate.resourceFolderPath]]];
    [bodyImageView addSubview:companyImageView];
    companyImageView.userInteractionEnabled = YES;
    
    companyField = [[UITextField alloc] initWithFrame:CGRectMake(185, 0, 655, 58)];
    companyField.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
    companyField.textAlignment = UITextAlignmentLeft;
    companyField.autocorrectionType = UITextAutocorrectionTypeNo;
    companyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    companyField.borderStyle = UITextBorderStyleNone;
    companyField.backgroundColor = [UIColor clearColor];
    companyField.delegate = self;
    companyField.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    [companyField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    companyField.keyboardType = UIKeyboardTypeDefault;
    [companyImageView addSubview:companyField];
    
    cityImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 280, 508, 58)];
    [cityImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/DriverInfoCity.png",delegate.resourceFolderPath]]];
    [bodyImageView addSubview:cityImageView];
    cityImageView.userInteractionEnabled = YES;
    
    cityField = [[UITextField alloc] initWithFrame:CGRectMake(185, 0, 320, 58)];
    cityField.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
    cityField.textAlignment = UITextAlignmentLeft;
    cityField.autocorrectionType = UITextAutocorrectionTypeNo;
    cityField.clearButtonMode = UITextFieldViewModeWhileEditing;
    cityField.borderStyle = UITextBorderStyleNone;
    cityField.backgroundColor = [UIColor clearColor];
    cityField.delegate = self;
    cityField.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    [cityField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    cityField.keyboardType = UIKeyboardTypeDefault;
    [cityImageView addSubview:cityField];
    
    stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(608, 280, 331, 58)];
    [stateImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/DriverInfoState.png",delegate.resourceFolderPath]]];
    [bodyImageView addSubview:stateImageView];
    stateImageView.userInteractionEnabled = YES;
    
    stateField = [[UITextField alloc] initWithFrame:CGRectMake(185, 0, 145, 58)];
    stateField.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
    stateField.textAlignment = UITextAlignmentLeft;
    stateField.autocorrectionType = UITextAutocorrectionTypeNo;
    stateField.clearButtonMode = UITextFieldViewModeWhileEditing;
    stateField.borderStyle = UITextBorderStyleNone;
    stateField.backgroundColor = [UIColor clearColor];
    stateField.delegate = self;
    stateField.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    [stateField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    stateField.keyboardType = UIKeyboardTypeDefault;
    [stateImageView addSubview:stateField];
    
    
    emailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 340, 839, 58)];
    [emailImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/DriverInfoEmail.png",delegate.resourceFolderPath]]];
    [bodyImageView addSubview:emailImageView];
    emailImageView.userInteractionEnabled = YES;
    
    emailField = [[UITextField alloc] initWithFrame:CGRectMake(185, 0, 655, 58)];
    emailField.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
    emailField.textAlignment = UITextAlignmentLeft;
    emailField.autocorrectionType = UITextAutocorrectionTypeNo;
    emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailField.borderStyle = UITextBorderStyleNone;
    emailField.backgroundColor = [UIColor clearColor];
    emailField.delegate = self;
    emailField.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    [emailField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    emailField.keyboardType = UIKeyboardTypeEmailAddress;
    [emailImageView addSubview:emailField];
    
    
    mobileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 400, 839, 58)];
    [mobileImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/DriverInfoMobile.png",delegate.resourceFolderPath]]];
    [bodyImageView addSubview:mobileImageView];
    mobileImageView.userInteractionEnabled = YES;
    
    mobileField = [[UITextField alloc] initWithFrame:CGRectMake(185, 0, 655, 58)];
    mobileField.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
    mobileField.textAlignment = UITextAlignmentLeft;
    mobileField.autocorrectionType = UITextAutocorrectionTypeNo;
    mobileField.clearButtonMode = UITextFieldViewModeWhileEditing;
    mobileField.borderStyle = UITextBorderStyleNone;
    mobileField.backgroundColor = [UIColor clearColor];
    mobileField.delegate = self;
    mobileField.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    [mobileField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    mobileField.keyboardType = UIKeyboardTypeNumberPad;
    [mobileImageView addSubview:mobileField];
    
    
    takePictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    takePictureButton.frame = CGRectMake(150, 620, 369, 79);
    [takePictureButton addTarget:self action:@selector(showDriverPictureActionSheet) forControlEvents:UIControlEventTouchUpInside];
    [takePictureButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TakePicture.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [takePictureButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TakePicture_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    
    [self.view addSubview:takePictureButton];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(580, 620, 300, 79);
    [submitButton addTarget:self action:@selector(moveToPreModuleView) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Submit.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Submit_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    
    [self.view addSubview:submitButton];
    
    
    removeKeypadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    removeKeypadButton.frame = CGRectMake(0, 0, 1024, 768);
    [removeKeypadButton addTarget:self action:@selector(dismissKeypad) forControlEvents:UIControlEventTouchUpInside];
    [bodyImageView addSubview:removeKeypadButton];
    [bodyImageView sendSubviewToBack:removeKeypadButton];
    
    
    loadingIndicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(500,450,45,45)];
	loadingIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
    loadingIndicator.transform = CGAffineTransformMakeScale(2.0, 2.0);
	[self.view addSubview:loadingIndicator];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

//******************************************************* Method For Hiding Status Bar ***********************************************************//

- (BOOL) prefersStatusBarHidden {
    
    return YES;
}

@end

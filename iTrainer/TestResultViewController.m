//
//  TestResultViewController.m
//  iTrainer
//
//  Created by Ajay Bhardwaj on 20/07/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import "TestResultViewController.h"

@interface TestResultViewController ()

@end

@implementation TestResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
- (void) moveToOptionsView {
    
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}


- (void) moveToModuleView {
    
    delegate.ISCOMINGBACKFROMQUESTIONAIREVIEW = YES;
    delegate.MODULEID = 1;
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:4] animated:YES];
}
*/


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


/*----------------------- For Checking Trainer Password -------------------------*/

- (void) checkTrainerPasswordValidity {
    
    NSString *urlString = [NSString stringWithFormat:@"http://54.200.182.176/api/signin.php?tid=%@&pwd=%@",delegate.TRAINERUSERNAME,trainerPasswordField.text];
    
    urlString = [urlString  stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];        
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    if ([responseString isEqualToString:@"null"]) {
        
        [loadingIndicator stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Trainer password doesn't match" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    else {
        
        [loadingIndicator stopAnimating];
        
        ScoresViewController *obj = [[ScoresViewController alloc] init];
        [self.navigationController pushViewController:obj animated:YES];
    }
}


/*---------------- For Checking Password Should Not Be Blank --------------------*/

- (void) checkPasswordField {
    
    if ([trainerPasswordField.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Trainer password field cannot be empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [loadingIndicator startAnimating];
        [trainerPasswordField resignFirstResponder];
        [self performSelectorInBackground:@selector(checkTrainerPasswordValidity) withObject:nil];
    }
}


# pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}



# pragma mark - View Lifecycle Methods

- (void)viewDidLoad
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;    
    delegate = (iTrainerAppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.QUESTIONSSLIDESCOUNT = [delegate retrieveTotalQuestionSlidesCount];

    topHeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 124)];
    [topHeaderImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TopBanner.png",delegate.resourceFolderPath]]];
    [self.view addSubview:topHeaderImageView];
    topHeaderImageView.userInteractionEnabled = YES;
    
    /*
     backButton = [UIButton buttonWithType:UIButtonTypeCustom];
     backButton.frame = CGRectMake(100, 92, 116, 29);
     [backButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/BackButton.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
     [backButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/BackButton_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
     [backButton addTarget:self action:@selector(moveBackToPreviousView) forControlEvents:UIControlEventTouchUpInside];
     [topHeaderImageView addSubview:backButton];
     
     nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
     nextButton.frame = CGRectMake(800, 92, 116, 29);
     [nextButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/NextButton.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
     [nextButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/NextButton_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
     [nextButton addTarget:self action:@selector(moveToMenuViewController) forControlEvents:UIControlEventTouchUpInside];
     [topHeaderImageView addSubview:nextButton];
     */
    
    loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(350, 80, 300, 50)];
    loginLabel.backgroundColor = [UIColor clearColor];
    loginLabel.textAlignment = UITextAlignmentCenter;
    loginLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
    loginLabel.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    loginLabel.text = @"COMPLETE";
    [self.view addSubview:loginLabel];
    
    
    bodyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 124, 1024, 644)];
    [bodyImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Body.png",delegate.resourceFolderPath]]];
    [self.view addSubview:bodyImageView];
    bodyImageView.userInteractionEnabled = YES;
    
    welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 135, 720, 50)];
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.text = @"TRAINING COMPLETE";
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

        
    contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(400, 120, 750, 400)];
    contentImageView.userInteractionEnabled = YES;
    [bodyImageView addSubview:contentImageView];
    
    contentBackgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 850, 600)];
    contentBackgroundScrollView.backgroundColor = [UIColor clearColor];
    contentBackgroundScrollView.contentSize = CGSizeMake(560, 600);
    contentBackgroundScrollView.showsVerticalScrollIndicator = YES;
    contentBackgroundScrollView.showsHorizontalScrollIndicator = NO;
    [contentImageView addSubview:contentBackgroundScrollView];
    
    successLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 540, 300)];
    successLabel1.text = [NSString stringWithFormat:@"TRAINING COMPLETE\nCONGRATULATIONS %@ YOU HAVE COMPLETED THE RAILDECK DRIVER TRAINING PROGRAM.\n\nHAND THE TABLET BACK TO YOUR TRAINER",delegate.DRIVERNAME];
    successLabel1.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    successLabel1.backgroundColor = [UIColor clearColor];
    successLabel1.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
    successLabel1.numberOfLines = 0;
    [successLabel1 sizeToFit];
    [contentBackgroundScrollView addSubview:successLabel1];
    
    
    passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 120, 300, 100)];
    [passwordImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TrainerPassword.png",delegate.resourceFolderPath]]];
    [bodyImageView addSubview:passwordImageView];
    passwordImageView.userInteractionEnabled = YES;
    
    trainerPasswordField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 290, 40)];
    trainerPasswordField.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
    trainerPasswordField.textAlignment = UITextAlignmentLeft;
    trainerPasswordField.autocorrectionType = UITextAutocorrectionTypeNo;
    trainerPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    trainerPasswordField.borderStyle = UITextBorderStyleNone;
    trainerPasswordField.backgroundColor = [UIColor clearColor];
    trainerPasswordField.delegate = self;
    trainerPasswordField.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    trainerPasswordField.secureTextEntry = YES;
    [trainerPasswordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    trainerPasswordField.text = delegate.TRAINERPASSWORD;
    [passwordImageView addSubview:trainerPasswordField];
    
    
    scoreTestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scoreTestButton.frame = CGRectMake(50, 400, 300, 74);
    [scoreTestButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/ScoreTest_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [scoreTestButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/ScoreTest_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    [scoreTestButton addTarget:self action:@selector(checkPasswordField) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scoreTestButton];
    
    loadingIndicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(500,550,45,45)];
	loadingIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
    loadingIndicator.transform = CGAffineTransformMakeScale(2.0, 2.0);
	[self.view addSubview:loadingIndicator];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void) viewWillAppear:(BOOL)animated {
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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


//
//  iTrainerViewController.m
//  iTrainer
//
//  Created by Ajay Bhardwaj on 01/07/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import "iTrainerViewController.h"

@interface iTrainerViewController ()

@end

@implementation iTrainerViewController




- (NSDate *)dateWithOutTime:(NSDate *)datDate {
    
    if(datDate == nil ) {
        datDate = [NSDate date];
    }
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:datDate];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
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


//******************************************** Method To Get App Version Number From Plist **************************************************//

- (void) getAppVersionNo {
    
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentPath = [paths objectAtIndex:0];
//    NSString *plistPath = [documentPath stringByAppendingPathComponent:@"versioncontrol.plist"];
//    
//    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
//        plistPath = [[NSBundle mainBundle] pathForResource:@"versioncontrol" ofType:@"plist"];
//    }
//    
//    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
//    NSString *errorDesc = nil;
//    NSPropertyListFormat format;
//    
//    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
//    if (!temp) {
//        NSLog(@"Error reading plist: %@, format: %d",errorDesc,format);
//    }
//    
//    delegate.LASTUPDATEDLOCALVERSION = [temp objectForKey:@"version"];
    
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


//********************************************* Method To Create Folder In Document Directory *********************************************//

- (void) createNewImageFolder {
    
    NSString *path;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Image-New"];
    path = [NSHomeDirectory() stringByAppendingString:@"/Library/Image-New/"];
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])    //Does directory already exist?
    {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:path
                                       withIntermediateDirectories:NO
                                                        attributes:nil
                                                             error:&error])
        {
            NSLog(@"Create directory error: %@", error);
        }
    }
}


//********************************************* Method To Download Images From Server *****************************************************//

- (void) downloadRemoteServerImages {
    
    //[self createNewImageFolder];
    
    delegate.isSyncingImages = @"2";
    
    for (int i=0; i<delegate.imagesSyncArray.count; i++) {
        
        NSString *imageUrl = [NSString stringWithFormat:@"http://54.200.182.176/api/assets/images/%@",[delegate.imagesSyncArray objectAtIndex:i]];
        
        imageUrl = [imageUrl  stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        imageUrl = [imageUrl stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
        imageUrl = [imageUrl stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
        imageUrl = [imageUrl stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
        
        NSLog(@"%@",imageUrl);
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *result = [UIImage imageWithData:data];
        
        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Library/Images/"];
        
        [UIImageJPEGRepresentation(result, 1.0) writeToFile:[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", [delegate.imagesSyncArray objectAtIndex:i]]] options:NSAtomicWrite error:nil];
    }
    
    
}

//********************************************* Method To Download Images From Server *****************************************************//

- (void) downloadRemoteServerAudios {
    
    //[self createNewImageFolder];
    
    for (int i=0; i<delegate.audioSyncArray.count; i++) {
        
        NSString *audioUrl = [NSString stringWithFormat:@"http://54.200.182.176/api/assets/audio/%@",[delegate.audioSyncArray objectAtIndex:i]];
        
        audioUrl = [audioUrl  stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        audioUrl = [audioUrl stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
        audioUrl = [audioUrl stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
        audioUrl = [audioUrl stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
        
        
        NSLog(@"audio url is --- %@",audioUrl);
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:audioUrl]];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Library/Audios/"];
        
        [data writeToFile:[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[delegate.audioSyncArray objectAtIndex:i]]] atomically:YES];
        //[UIImageJPEGRepresentation(result, 1.0) writeToFile:[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", [delegate.imagesSyncArray objectAtIndex:i]]] options:NSAtomicWrite error:nil];
    }
    
    delegate.isSyncingAudio = @"2";
}



//************************************************** Method To Get NSDocument Directory Url ***********************************************//

- (NSURL *) getDocumentDirectoryUrl {
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



//************************************************** Method To Remove Update Checking Alert ***********************************************//

- (void) removeUpdateCheckingAlert {
    
    [updateCheckIndicator stopAnimating];
    [updateCheckAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thanks for waiting." message:@"Your app is up-to-date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    
}


//***************************************************** For Checking Sync Status **********************************************************//

- (void) timerToCheckSyncStatus {
    
    NSLog(@"checking loop");
    
    if ([delegate.isSyncingPreModule isEqualToString:@"2"]) {
        delegate.isSyncingPreModule = @"0";
        delegate.isSyncingQuestionaire = @"1";
        [self htmlQuestionaireDataLoading];
        downloadingStatusLabel.text = @"Downloading Module Questionaire";
    }
    else if ([delegate.isSyncingQuestionaire isEqualToString:@"2"]) {
        delegate.isSyncingQuestionaire = @"0";
        delegate.isSyncingSlides = @"1";
        [self htmlSlidesDataLoading];
        downloadingStatusLabel.text = @"Downloading Module Slides";
    }
    else if ([delegate.isSyncingSlides isEqualToString:@"2"]) {
        delegate.isSyncingSlides = @"0";
        delegate.isSyncingAudio = @"1";
        [self htmlAudioDataLoading];
        downloadingStatusLabel.text = @"Downloading Audio Files";
    }
    else if ([delegate.isSyncingAudio isEqualToString:@"2"]) {
        delegate.isSyncingAudio = @"0";
        delegate.isSyncingImages = @"1";
        [self htmlImagesDataLoading];
        downloadingStatusLabel.text = @"Downloading Images";
    }
    else if ([delegate.isSyncingImages isEqualToString:@"2"]) {
        delegate.isSyncingImages = @"0";
        [downloadingDataIndicator stopAnimating];
        [syncStatusTimer invalidate];
        [showDownloadingStatusAlert dismissWithClickedButtonIndex:0 animated:YES];
        
        [delegate syncLastUpdateTable];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations..!!" message:@"Content updated successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
//        NSError *error;
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
//        NSString *documentsDirectory = [paths objectAtIndex:0]; //2
//        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"versioncontrol.plist"]; //3
//        
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        
//        if (![fileManager fileExistsAtPath: path]) //4
//        {
//            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"versioncontrol" ofType:@"plist"]; //5
//            
//            [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
//            
//            NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
//            
//            //here add elements to data file and write data to file
//            [data setObject:delegate.LASTUPDATEDSERVERVERSION forKey:@"version"];
//            
//            [data writeToFile: path atomically:YES];
//        }
        
        [delegate syncLastUpdateTable];
        [delegate retrieveLastUpdateLocalDate];
        
        
        NSArray *excludeUrl = [[NSArray alloc] initWithObjects:@"Audios",@"Images",@"Videos",@"iTrainer_DB.sqlite", nil];
        
        for (int i=0; i<excludeUrl.count; i++) {
            NSString *documentDirectoryUrl = [[NSHomeDirectory() stringByAppendingString:@"/Library/"] stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@/",[excludeUrl objectAtIndex:i]]];
            
            
            NSURL *url = [NSURL fileURLWithPath:documentDirectoryUrl];
            assert([[NSFileManager defaultManager] fileExistsAtPath:documentDirectoryUrl]);
            
            NSError *error = nil;
            BOOL success = [url setResourceValue: [NSNumber numberWithBool: YES]
                                          forKey: NSURLIsExcludedFromBackupKey error: &error];
            if(!success){
                NSLog(@"Error excluding %@ from backup %@", [url lastPathComponent], error);
            }
            else {
                NSLog(@"Excluded");
            }
        }
    }
}




//********************************************************* For Dismissing Keypad *********************************************************//

- (void) dismissKeypad {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    CGPoint pos = self.view.center;
    pos.y = 385;
    self.view.center = pos;
    [UIView commitAnimations];
    [traineridField resignFirstResponder];
    [passwordField resignFirstResponder];
}


//*********************************************** For Trianer Credentials Validation ******************************************************//

- (void) checkTrainerCredentials {
    
    delegate.TRAINERPASSWORD = passwordField.text;
    
    NSString *urlString = [NSString stringWithFormat:@"http://54.200.182.176/api/signin.php?tid=%@&pwd=%@",traineridField.text,passwordField.text];
    
    urlString = [urlString  stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    if ([responseString isEqualToString:@"null"]) {
        
        [loadingIndicatorForSplash stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"User credentials are not correct" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
        
    }
    else {
        
        NSArray *results = [responseString JSONValue];
        
        for (int i=0; i<results.count; i++) {
            NSDictionary *dict = [results objectAtIndex:i];
            
            delegate.TRAINERID = [dict objectForKey:@"id"];
            delegate.TRAINERUSERNAME = [dict objectForKey:@"trainerid"];
        }
        
        [loadingIndicatorForSplash stopAnimating];
        
        TrainingMenuViewController *obj = [[TrainingMenuViewController alloc] init];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    
}




//*********************************************** For Moving To Menu View Controller ******************************************************//

- (void) moveToMenuViewController {
    
    [traineridField resignFirstResponder];
    [passwordField resignFirstResponder];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    CGPoint pos = self.view.center;
    pos.y = 385;
    self.view.center = pos;
    [UIView commitAnimations];
    
    UIAlertView *alert;
    
    if ([traineridField.text length] == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Trainer ID field cannot be empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    else if ([passwordField.text length] == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Password field cannot be empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
        
    }
    else {
        if ([self connectedToWiFi]) {
            [loadingIndicatorForSplash startAnimating];
            [self performSelector:@selector(checkTrainerCredentials) withObject:nil afterDelay:0.5];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"No internet connectivity. Please try later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}



//********************************************* For Removing Splash Screen Components *****************************************************//

- (void) removeSplashComponents {
    
    headingLabel.hidden = YES;
    [loadingIndicatorForSplash stopAnimating];
    
    traineridField = [[UITextField alloc] initWithFrame:CGRectMake(520, 250, 420, 45)];
    traineridField.placeholder = @"TRAINER ID";
    traineridField.font = [UIFont fontWithName:@"Courier" size:25];
    traineridField.textAlignment = UITextAlignmentLeft;
    traineridField.autocorrectionType = UITextAutocorrectionTypeNo;
    traineridField.clearButtonMode = UITextFieldViewModeWhileEditing;
    traineridField.borderStyle = UITextBorderStyleRoundedRect;
    traineridField.backgroundColor = [UIColor colorWithRed:201.0/256.0 green:216.0/256.0 blue:237.0/256.0 alpha:1.0];
    traineridField.delegate = self;
    traineridField.textColor = [UIColor blackColor];
    [traineridField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    traineridField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:traineridField];
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(520, 320, 420, 45)];
    passwordField.placeholder = @"PASSWORD";
    passwordField.font = [UIFont fontWithName:@"Courier" size:25];
    passwordField.textAlignment = UITextAlignmentLeft;
    passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    passwordField.backgroundColor = [UIColor colorWithRed:201.0/256.0 green:216.0/256.0 blue:237.0/256.0 alpha:1.0];
    passwordField.delegate = self;
    passwordField.textColor = [UIColor blackColor];
    passwordField.secureTextEntry = YES;
    [passwordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.view addSubview:passwordField];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(520, 390, 420, 45);
    [submitButton setBackgroundColor:[UIColor colorWithRed:201.0/256.0 green:216.0/256.0 blue:237.0/256.0 alpha:1.0]];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont fontWithName:@"Courier-Bold" size:25.0];
    submitButton.titleLabel.textColor = [UIColor whiteColor];
    submitButton.layer.shadowOffset = CGSizeMake(10,10);
    submitButton.layer.shadowOpacity = 0.7f;
    [submitButton addTarget:self action:@selector(moveToMenuViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}




//loading of data from server by specifing the URL.....
- (void) htmlToCheckLastUpdate {
	
    [adta setData:[NSData dataWithBytes:NULL length:0]];
	NSURL *url=[[NSURL alloc]initWithString:@"http://54.200.182.176/api/settings.php"];
	NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
	con=[[NSURLConnection alloc]initWithRequest:request delegate:self];
	
}



//loading of data from server by specifing the URL.....
- (void) htmlImagesDataLoading {
	
    if ([delegate.ISSERVERIMAGESUPDATED isEqualToString:@"1"]) {
        
        [adta setData:[NSData dataWithBytes:NULL length:0]];
        [delegate.imagesSyncArray removeAllObjects];
        delegate.imagesSyncArray = [[NSMutableArray alloc] init];
        delegate.isSyncingPreModule = @"0";
        delegate.isSyncingQuestionaire = @"0";
        delegate.isSyncingSlides = @"0";
        delegate.isSyncingAudio = @"0";
        delegate.isSyncingImages = @"1";
        
        NSURL *url=[[NSURL alloc]initWithString:@"http://54.200.182.176/api/getimagenames.php"];
        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
        con=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    else {
        delegate.isSyncingImages = @"2";
    }
}


//loading of data from server by specifing the URL.....
- (void) htmlPreModulesDataLoading {
	
    if ([delegate.ISSERVERPREMODULEUPDATED isEqualToString:@"1"]) {
        
        [adta setData:[NSData dataWithBytes:NULL length:0]];
        [delegate.premoduleSyncArray removeAllObjects];
        delegate.premoduleSyncArray = [[NSMutableArray alloc] init];
        delegate.isSyncingPreModule = @"1";
        delegate.isSyncingQuestionaire = @"0";
        delegate.isSyncingSlides = @"0";
        delegate.isSyncingAudio = @"0";
        delegate.isSyncingImages = @"0";
        
        NSURL *url=[[NSURL alloc]initWithString:@"http://54.200.182.176/api/premoduledata.php"];
        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
        con=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    else {
        delegate.isSyncingPreModule = @"2";
    }
}


//loading of data from server by specifing the URL.....
- (void) htmlSlidesDataLoading {
	
    if ([delegate.ISSERVERSLIDESUPDATED isEqualToString:@"1"]) {
        
        [adta setData:[NSData dataWithBytes:NULL length:0]];
        [delegate.slidesSyncArray removeAllObjects];
        delegate.slidesSyncArray = [[NSMutableArray alloc] init];
        delegate.isSyncingPreModule = @"0";
        delegate.isSyncingQuestionaire = @"0";
        delegate.isSyncingSlides = @"1";
        delegate.isSyncingAudio = @"0";
        delegate.isSyncingImages = @"0";
        
        NSURL *url=[[NSURL alloc]initWithString:@"http://54.200.182.176/api/slidesdata.php"];
        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
        con=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    else {
        delegate.isSyncingSlides = @"2";
    }
	
}


//loading of data from server by specifing the URL.....
- (void) htmlQuestionaireDataLoading{
	
    if ([delegate.ISSERVERQUIZUPDATED isEqualToString:@"1"]) {
        
        [adta setData:[NSData dataWithBytes:NULL length:0]];
        [delegate.questionaireSyncArray removeAllObjects];
        delegate.questionaireSyncArray = [[NSMutableArray alloc] init];
        delegate.isSyncingPreModule = @"0";
        delegate.isSyncingQuestionaire = @"1";
        delegate.isSyncingSlides = @"0";
        delegate.isSyncingAudio = @"0";
        delegate.isSyncingImages = @"0";
        
        NSURL *url=[[NSURL alloc]initWithString:@"http://54.200.182.176/api/questionairedata.php"];
        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
        con=[[NSURLConnection alloc]initWithRequest:request delegate:self];
	}
    else {
        delegate.isSyncingQuestionaire = @"2";
    }
}


//loading of data from server by specifing the URL.....
- (void) htmlAudioDataLoading{
	
    if ([delegate.ISSERVERAUDIOUPDATED isEqualToString:@"1"]) {
        
        [adta setData:[NSData dataWithBytes:NULL length:0]];
        [delegate.audioSyncArray removeAllObjects];
        delegate.audioSyncArray = [[NSMutableArray alloc] init];
        delegate.isSyncingPreModule = @"0";
        delegate.isSyncingQuestionaire = @"0";
        delegate.isSyncingSlides = @"0";
        delegate.isSyncingAudio = @"1";
        delegate.isSyncingImages = @"0";
        
        NSURL *url=[[NSURL alloc]initWithString:@"http://54.200.182.176/api/getaudionames.php"];
        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
        con=[[NSURLConnection alloc]initWithRequest:request delegate:self];
	}
    else {
        delegate.isSyncingAudio = @"2";
    }
}


# pragma mark - NSURLConnectionDelegate Methods

//action to be performed after recieving data....
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
	[adta appendData:data];
}


- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSLog(@"received response");
}

//action to be performed loading of data....
- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    
	TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:adta];
    
	NSArray *elements  = [xpathParser search:@"//td"]; // get the page title
	
    NSLog(@"elements count %d",elements.count);
    
    
    
    if (delegate.isCheckingLastUpdate) {
        
        for (int i=0; i<elements.count/6; i++) {
            
            delegate.isCheckingLastUpdate = NO;
            
            TFHppleElement *element1 = [elements objectAtIndex:(i)];
            delegate.LASTUPDATEDSERVERVERSION = [element1 content];
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyy-MM-dd"];
//            delegate.LASTUPDATEDSERVERDATE = [formatter dateFromString:dateString];
            
            TFHppleElement *element2 = [elements objectAtIndex:(i+1)];
            NSString *value = [element2 content];
            delegate.SERVERMODULECOUNT = [value intValue];
            
            TFHppleElement *element3 = [elements objectAtIndex:(i+2)];
            delegate.ISSERVERSLIDESUPDATED = [element3 content];
            
            TFHppleElement *element4 = [elements objectAtIndex:(i+3)];
            delegate.ISSERVERPREMODULEUPDATED = [element4 content];
            
            TFHppleElement *element5 = [elements objectAtIndex:(i+4)];
            delegate.ISSERVERQUIZUPDATED = [element5 content];
            
            TFHppleElement *element6 = [elements objectAtIndex:(i+5)];
            delegate.ISSERVERIMAGESUPDATED = [element6 content];
            
            TFHppleElement *element7 = [elements objectAtIndex:(i+6)];
            delegate.ISSERVERAUDIOUPDATED = [element7 content];
            
//            NSLog(@"Local %@ - Server %@",delegate.LASTUPDATEDLOCALDATE,delegate.LASTUPDATEDSERVERDATE);
//            logLabel.text = [NSString stringWithFormat:@"\n%@\nLocal Date:%@ ------- Server Date:%@",logLabel.text,delegate.LASTUPDATEDLOCALDATE,delegate.LASTUPDATEDSERVERDATE];
//            
//            delegate.LASTUPDATEDLOCALDATE = [self dateWithOutTime:delegate.LASTUPDATEDLOCALDATE];
//            delegate.LASTUPDATEDSERVERDATE = [self dateWithOutTime:delegate.LASTUPDATEDSERVERDATE];
//            
//            NSLog(@"Local %@ - Server %@",delegate.LASTUPDATEDLOCALDATE,delegate.LASTUPDATEDSERVERDATE);
//            logLabel.text = [NSString stringWithFormat:@"\n%@\nLocal Date:%@ ------- Server Date:%@ Trimmed",logLabel.text,delegate.LASTUPDATEDLOCALDATE,delegate.LASTUPDATEDSERVERDATE];
            
            
            
            /*
             if ([delegate.LASTUPDATEDLOCALDATE compare:delegate.LASTUPDATEDSERVERDATE] == NSOrderedAscending) {
             
             [updateCheckIndicator stopAnimating];
             [updateCheckAlert dismissWithClickedButtonIndex:0 animated:NO];
             
             confirmSyncAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Updated content is available. Tap on sync button to update your app." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancel",@"Sync", nil];
             [confirmSyncAlert show];
             }
             else if ([delegate.LASTUPDATEDLOCALDATE compare:delegate.LASTUPDATEDSERVERDATE] == NSOrderedSame) {
             
             [self performSelector:@selector(removeUpdateCheckingAlert) withObject:nil afterDelay:0.5];
             }
             */
            
//            if ([delegate.LASTUPDATEDLOCALDATE compare:delegate.LASTUPDATEDSERVERDATE] == NSOrderedSame) {
//                
//                [self performSelector:@selector(removeUpdateCheckingAlert) withObject:nil afterDelay:0.5];
//                
//                //logLabel.text = [NSString stringWithFormat:@"\n%@\nSame Dates ---- Removing Alert",logLabel.text];
//                //logLabel.text = [NSString stringWithFormat:@"\n%@\nShowing Thanking Alert",logLabel.text];
//                
//            }

            if (![delegate.LASTUPDATEDSERVERVERSION isEqualToString:delegate.LASTUPDATEDLOCALVERSION]) {
                
                //logLabel.text = [NSString stringWithFormat:@"\n%@\nDifferent Dates ---- Showing New Alert",logLabel.text];
                //logLabel.text = [NSString stringWithFormat:@"\n%@\nShowing New Content Sync ALert",logLabel.text];
                
                [updateCheckIndicator stopAnimating];
                [updateCheckAlert dismissWithClickedButtonIndex:0 animated:YES];
                
                confirmSyncAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Updated content is available. Tap on sync button to update your app." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Sync", nil];
                [confirmSyncAlert show];
            }
            else {
                
                [self performSelector:@selector(removeUpdateCheckingAlert) withObject:nil afterDelay:0.5];
            }
        }
    }
    
    if ([delegate.isSyncingPreModule isEqualToString:@"1"]) {
        
        for (int i=0;i<elements.count/9;i++) {
            
            TFHppleElement *element1 = [elements objectAtIndex:(i*9)];
            NSString *s1 = [[element1 content] stringByEncodingHTMLEntities];
            [delegate.premoduleSyncArray addObject:s1];
            
            TFHppleElement *element2 = [elements objectAtIndex:(i*9)+1];
            [delegate.premoduleSyncArray addObject:[element2 content]];
            
            TFHppleElement *element3 = [elements objectAtIndex:(i*9)+2];
            [delegate.premoduleSyncArray addObject:[element3 content]];
            
            
            TFHppleElement *element4 = [elements objectAtIndex:(i*9)+3];
            [delegate.premoduleSyncArray addObject:[element4 content]];
            
            
            TFHppleElement *element5 = [elements objectAtIndex:(i*9)+4];
            [delegate.premoduleSyncArray addObject:[element5 content]];
            
            
            TFHppleElement *element6 = [elements objectAtIndex:(i*9)+5];
            [delegate.premoduleSyncArray addObject:[element6 content]];
            
            
            TFHppleElement *element7 = [elements objectAtIndex:(i*9)+6];
            [delegate.premoduleSyncArray addObject:[element7 content]];
            
            
            TFHppleElement *element8 = [elements objectAtIndex:(i*9)+7];
            [delegate.premoduleSyncArray addObject:[element8 content]];
            
            
            TFHppleElement *element9 = [elements objectAtIndex:(i*9)+8];
            [delegate.premoduleSyncArray addObject:[element9 content]];
            
        }
        
        [delegate syncPremoduleDataTable];
	}
    
    
    if ([delegate.isSyncingImages isEqualToString:@"1"]) {
        
        for (int i=0;i<elements.count;i++) {
            
            TFHppleElement *element1 = [elements objectAtIndex:(i)];
            [delegate.imagesSyncArray addObject:[element1 content]];
            
        }
        
        [self downloadRemoteServerImages];
	}
    
    
    if ([delegate.isSyncingAudio isEqualToString:@"1"]) {
        
        for (int i=0;i<elements.count;i++) {
            
            TFHppleElement *element1 = [elements objectAtIndex:(i)];
            [delegate.audioSyncArray addObject:[element1 content]];
            
        }
        
        [self downloadRemoteServerAudios];
	}
    
    
    if ([delegate.isSyncingQuestionaire isEqualToString:@"1"]) {
        
        for (int i=0;i<elements.count/10;i++) {
            
            NSLog(@"entry no. %d",i+1);
            
            TFHppleElement *element1 = [elements objectAtIndex:(i*10)];
            NSLog(@"1 - %@",[elements objectAtIndex:(i*10)]);
            [delegate.questionaireSyncArray addObject:[element1 content]];
            
            
            TFHppleElement *element2 = [elements objectAtIndex:(i*10)+1];
            [delegate.questionaireSyncArray addObject:[element2 content]];
            
            
            TFHppleElement *element3 = [elements objectAtIndex:(i*10)+2];
            [delegate.questionaireSyncArray addObject:[element3 content]];
            
            
            TFHppleElement *element4 = [elements objectAtIndex:(i*10)+3];
            [delegate.questionaireSyncArray addObject:[element4 content]];
            
            
            TFHppleElement *element5 = [elements objectAtIndex:(i*10)+4];
            [delegate.questionaireSyncArray addObject:[element5 content]];
            
            
            TFHppleElement *element6 = [elements objectAtIndex:(i*10)+5];
            [delegate.questionaireSyncArray addObject:[element6 content]];
            
            
            TFHppleElement *element7 = [elements objectAtIndex:(i*10)+6];
            [delegate.questionaireSyncArray addObject:[element7 content]];
            
            
            TFHppleElement *element8 = [elements objectAtIndex:(i*10)+7];
            [delegate.questionaireSyncArray addObject:[element8 content]];
            
            
            TFHppleElement *element9 = [elements objectAtIndex:(i*10)+8];
            [delegate.questionaireSyncArray addObject:[element9 content]];
            
            
            TFHppleElement *element10 = [elements objectAtIndex:(i*10)+9];
            [delegate.questionaireSyncArray addObject:[element10 content]];
            
        }
        
        [delegate syncQuestionaireDataTable];
	}
    
    if ([delegate.isSyncingSlides isEqualToString:@"1"]) {
        
        for (int i=0;i<elements.count/10;i++) {
            
            
            
            TFHppleElement *element1 = [elements objectAtIndex:(i*10)];
            NSString *s1 = [[element1 content] stringByEncodingHTMLEntities];
            [delegate.slidesSyncArray addObject:s1];
            
            
            TFHppleElement *element2 = [elements objectAtIndex:(i*10)+1];
            [delegate.slidesSyncArray addObject:[element2 content]];
            
            
            TFHppleElement *element3 = [elements objectAtIndex:(i*10)+2];
            [delegate.slidesSyncArray addObject:[element3 content]];
            
            
            TFHppleElement *element4 = [elements objectAtIndex:(i*10)+3];
            [delegate.slidesSyncArray addObject:[element4 content]];
            
            
            TFHppleElement *element5 = [elements objectAtIndex:(i*10)+4];
            [delegate.slidesSyncArray addObject:[element5 content]];
            
            
            TFHppleElement *element6 = [elements objectAtIndex:(i*10)+5];
            [delegate.slidesSyncArray addObject:[element6 content]];
            
            
            TFHppleElement *element7 = [elements objectAtIndex:(i*10)+6];
            [delegate.slidesSyncArray addObject:[element7 content]];
            
            
            TFHppleElement *element8 = [elements objectAtIndex:(i*10)+7];
            [delegate.slidesSyncArray addObject:[element8 content]];
            
            
            TFHppleElement *element9 = [elements objectAtIndex:(i*10)+8];
            [delegate.slidesSyncArray addObject:[element9 content]];
            
            
            TFHppleElement *element10 = [elements objectAtIndex:(i*10)+9];
            [delegate.slidesSyncArray addObject:[element10 content]];
            
            
            NSLog(@"elemnt is %d",i+1);
        }
        
        [delegate syncSlidesDataTable];
	}
    
	[con cancel];
	con=nil;
	
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	[con cancel];
	con=nil;
}





# pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField==traineridField || textField==passwordField) {
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
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    CGPoint pos = self.view.center;
    pos.y = 100;
    self.view.center = pos;
    [UIView commitAnimations];
    
    return YES;
}



# pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView==confirmSyncAlert) {
        if (buttonIndex==0) {
            
            syncStatusTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerToCheckSyncStatus) userInfo:nil repeats:YES];
            [delegate syncModulesCountTable];
            [self htmlPreModulesDataLoading];
            
            showDownloadingStatusAlert = [[UIAlertView alloc] initWithTitle:@"Please Wait..!!" message:@"\n" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            
            downloadingStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 265, 50)];
            downloadingStatusLabel.text = @"Downloading Introduction Slides";
            downloadingStatusLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:16.0];
            downloadingStatusLabel.textAlignment = NSTextAlignmentCenter;
            downloadingStatusLabel.textColor = [UIColor blackColor];
            downloadingStatusLabel.backgroundColor = [UIColor clearColor];
            [showDownloadingStatusAlert addSubview:downloadingStatusLabel];
            [showDownloadingStatusAlert setValue:downloadingStatusLabel forKey:@"accessoryView"];
            
            downloadingDataIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            downloadingDataIndicator.frame = CGRectMake(140, 110, 0, 0);
            [downloadingDataIndicator startAnimating];
            [showDownloadingStatusAlert addSubview:downloadingDataIndicator];
            
            [showDownloadingStatusAlert show];
        }
    }
}



# pragma mark - View Lifecycle Methods

- (void)viewDidLoad
{
    
    delegate = (iTrainerAppDelegate*)[UIApplication sharedApplication].delegate;
    [self.navigationController setNavigationBarHidden:YES];
    
    adta = [[NSMutableData alloc] init];
    
    topHeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 124)];
    [topHeaderImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TopBanner.png",delegate.resourceFolderPath]]];
    [self.view addSubview:topHeaderImageView];
    topHeaderImageView.userInteractionEnabled = YES;
    
    /*
     nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
     nextButton.frame = CGRectMake(800, 92, 116, 29);
     [nextButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/NextButton.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
     [nextButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/NextButton_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
     [nextButton addTarget:self action:@selector(moveToMenuViewController) forControlEvents:UIControlEventTouchUpInside];
     [topHeaderImageView addSubview:nextButton];
     */
    
    loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(445, 80, 120, 50)];
    loginLabel.backgroundColor = [UIColor clearColor];
    loginLabel.textAlignment = UITextAlignmentCenter;
    loginLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
    loginLabel.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    loginLabel.text = [NSString stringWithFormat:@"LOGIN"];
    [self.view addSubview:loginLabel];
    
    
    bodyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 124, 1024, 644)];
    [bodyImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Body.png",delegate.resourceFolderPath]]];
    [self.view addSubview:bodyImageView];
    bodyImageView.userInteractionEnabled = YES;
    
    welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 135, 120, 50)];
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.text = [NSString stringWithFormat:@"Welcome"];
    [self.view addSubview:welcomeLabel];
    
    
    logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(380, 280, 280, 167)];
    logoImageView.image = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/RDLoginLogo.png",delegate.resourceFolderPath]];
    [self.view addSubview:logoImageView];
    
    usernameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(210, 500, 612, 50)];
    [usernameImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TrainerIDLogin.png",delegate.resourceFolderPath]]];
    [self.view addSubview:usernameImageView];
    usernameImageView.userInteractionEnabled = YES;
    
    traineridField = [[UITextField alloc] initWithFrame:CGRectMake(180, 0, 430, 50)];
    traineridField.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
    traineridField.textAlignment = UITextAlignmentLeft;
    traineridField.autocorrectionType = UITextAutocorrectionTypeNo;
    traineridField.clearButtonMode = UITextFieldViewModeWhileEditing;
    traineridField.borderStyle = UITextBorderStyleNone;
    traineridField.backgroundColor = [UIColor clearColor];
    traineridField.delegate = self;
    traineridField.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    [traineridField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    traineridField.keyboardType = UIKeyboardTypeDefault;
    [usernameImageView addSubview:traineridField];
    
    passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(210, 560, 612, 50)];
    [passwordImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/PasswordLogin.png",delegate.resourceFolderPath]]];
    [self.view addSubview:passwordImageView];
    passwordImageView.userInteractionEnabled = YES;
    
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(180, 0, 430, 50)];
    passwordField.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
    passwordField.textAlignment = UITextAlignmentLeft;
    passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.borderStyle = UITextBorderStyleNone;
    passwordField.backgroundColor = [UIColor clearColor];
    passwordField.delegate = self;
    passwordField.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    passwordField.secureTextEntry = YES;
    [passwordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [passwordImageView addSubview:passwordField];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(420, 640, 200, 59);
    [submitButton addTarget:self action:@selector(moveToMenuViewController) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Submit.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Submit_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    
    [self.view addSubview:submitButton];
    
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
    
    removeKeypadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    removeKeypadButton.frame = CGRectMake(0, 0, 1024, 768);
    [removeKeypadButton addTarget:self action:@selector(dismissKeypad) forControlEvents:UIControlEventTouchUpInside];
    [bodyImageView addSubview:removeKeypadButton];
    [bodyImageView sendSubviewToBack:removeKeypadButton];
    
    
    loadingIndicatorForSplash=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(500,550,45,45)];
	loadingIndicatorForSplash.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
    loadingIndicatorForSplash.transform = CGAffineTransformMakeScale(2.0, 2.0);
	[self.view addSubview:loadingIndicatorForSplash];
    
    /*
    logLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 900, 400)];
    logLabel.backgroundColor = [UIColor blackColor];
    logLabel.textAlignment = UITextAlignmentLeft;
    logLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0];
    logLabel.textColor = [UIColor whiteColor];
    logLabel.numberOfLines = 0;
    logLabel.text = [NSString stringWithFormat:@"LOGS\n"];
    [self.view addSubview:logLabel];
    */
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void) viewWillAppear:(BOOL)animated {
    
    if ([self connectedToWiFi]) {
        
        [self getAppVersionNo];
        
        updateCheckAlert = [[UIAlertView alloc] initWithTitle:@"\n" message:@"Please wait....Checking for updates..!!" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [updateCheckAlert show];
        
        updateCheckIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        updateCheckIndicator.frame = CGRectMake(140, 40, 0, 0);
        [updateCheckAlert setValue:updateCheckIndicator forKey:@"accessoryView"];
        [updateCheckIndicator startAnimating];
        
        [self htmlToCheckLastUpdate];
        
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        return YES;
    }
    else {
        return NO;
    }
}

//******************************************************* Method For Hiding Status Bar ***********************************************************//

- (BOOL) prefersStatusBarHidden {
    
    return YES;
}

@end

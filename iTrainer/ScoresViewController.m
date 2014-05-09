//
//  ScoresViewController.m
//  iTrainer
//
//  Created by Ajay Bhardwaj on 13/08/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import "ScoresViewController.h"

@interface ScoresViewController ()

@end

@implementation ScoresViewController

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


//********************************************** For Repeating Failed Modules *************************************************************//

- (void) moveToModuleView {
    
    delegate.ISCOMINGBACKFROMQUESTIONAIREVIEW = YES;
    delegate.MODULEID = 1;
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:4] animated:YES];
}



//********************************************** For Submiting Score To Server In Background **********************************************//

- (void) submitScoreToServerInBackground {
    
    self.view.window.userInteractionEnabled = NO;
    
    for (int i=0; i<delegate.TESTRESULTARRAY.count/2; i++) {
        
        NSString *urlString;
        
        if (i==delegate.TESTRESULTARRAY.count/2 - 1) {
            urlString = [NSString stringWithFormat:@"http://54.200.182.176/api/submitscore.php?driverid=%d&moduleid=%@&iscompleted=%@&score=%@&trainerid=%@",delegate.DRIVERID,[delegate.TESTRESULTARRAY objectAtIndex:(i*2)],@"1",[delegate.TESTRESULTARRAY objectAtIndex:(i*2)+1],delegate.TRAINERUSERNAME];
        }
        else {
            urlString = [NSString stringWithFormat:@"http://54.200.182.176/api/submitscore.php?driverid=%d&moduleid=%@&iscompleted=%@&score=%@",delegate.DRIVERID,[delegate.TESTRESULTARRAY objectAtIndex:(i*2)],@"1",[delegate.TESTRESULTARRAY objectAtIndex:(i*2)+1]];
        }
        urlString = [urlString  stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        urlString = [urlString stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
        urlString = [urlString stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
        urlString = [urlString stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
        
        
        NSLog(@"%@",urlString);
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *responseString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        NSLog(@"response is %@",responseString);
        
        if (i==delegate.TESTRESULTARRAY.count/2 - 1) {
            
            submitResultsButton.userInteractionEnabled = YES;
            [loadingIndicator stopAnimating];
            
            if ([responseString isEqualToString:@"Inserted"]) {
                scoreSubmissionAlert = [[UIAlertView alloc] initWithTitle:@"Congratulations..!!" message:@"Your score has been successfully submitted." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [scoreSubmissionAlert show];
                
                [delegate updateDriverScoreSyncStatus];
                
                self.view.window.userInteractionEnabled = YES;
                
            }
            else if ([responseString isEqualToString:@"Updated"]) {
                scoreSubmissionAlert = [[UIAlertView alloc] initWithTitle:@"Congratulations..!!" message:@"Your score has been successfully updated." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [scoreSubmissionAlert show];
                
                [delegate updateDriverScoreSyncStatus];
                
                self.view.window.userInteractionEnabled = YES;
            }
            else {
                scoreSubmissionAlert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"Some network problem, please try later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [scoreSubmissionAlert show];
                
                self.view.window.userInteractionEnabled = YES;
            }
        }
    }
    
}



//***************************************** For Starting Loading Indicator While Uploading Score ******************************************//

- (void) startLoadingWhileSubmittingScore {
    
    if ([self connectedToWiFi]) {
        submitResultsButton.userInteractionEnabled = NO;
        [loadingIndicator startAnimating];
        [self performSelector:@selector(submitScoreToServerInBackground) withObject:nil afterDelay:0.5];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry..!!" message:@"No internet connectivity. Please try later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}



# pragma mark - UIAlertViewDelegate Methods 

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView==scoreSubmissionAlert) {
        if (buttonIndex==0) {
            [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        }
    }
}



# pragma mark - View Lifecycle Methods

- (void)viewDidLoad
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    delegate = (iTrainerAppDelegate*)[UIApplication sharedApplication].delegate;
    
    unfinishedModulesCount = [delegate getModuleStatusRepeatingModulesOption];
    
    [delegate retrieveTestResultData];
    
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
    loginLabel.text = @"RESULTS";
    [self.view addSubview:loginLabel];
    
    
    bodyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 124, 1024, 644)];
    [bodyImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Body.png",delegate.resourceFolderPath]]];
    [self.view addSubview:bodyImageView];
    bodyImageView.userInteractionEnabled = YES;
    
    welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 135, 720, 50)];
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.text = @"TEST RESULTS";
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
    
    
    int yAxisForLabel = 10;
    
    for (int i=0; i<delegate.TESTRESULTARRAY.count/2; i++) {
        
        UILabel *moduleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, yAxisForLabel, 170, 30)];
        moduleLabel.text = [NSString stringWithFormat:@"Module %@",[delegate.TESTRESULTARRAY objectAtIndex:(i*2)]];
        moduleLabel.textAlignment = UITextAlignmentLeft;
        moduleLabel.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
        moduleLabel.backgroundColor = [UIColor clearColor];
        moduleLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
        moduleLabel.numberOfLines = 0;
        [contentBackgroundScrollView addSubview:moduleLabel];
        
        UILabel *dashLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, yAxisForLabel, 100, 30)];
        dashLabel.text = @"----";
        dashLabel.textAlignment = UITextAlignmentLeft;
        dashLabel.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
        dashLabel.backgroundColor = [UIColor clearColor];
        dashLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
        [contentBackgroundScrollView addSubview:dashLabel];
        
        
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(350, yAxisForLabel, 140, 30)];
        scoreLabel.text = [NSString stringWithFormat:@"%@%%",[delegate.TESTRESULTARRAY objectAtIndex:(i*2)+1]];
        scoreLabel.textAlignment = UITextAlignmentRight;
        scoreLabel.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
        scoreLabel.backgroundColor = [UIColor clearColor];
        scoreLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
        scoreLabel.numberOfLines = 0;
        [contentBackgroundScrollView addSubview:scoreLabel];
        
        
        yAxisForLabel = yAxisForLabel + 40;
        
    }
    
    
    submitResultsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitResultsButton.frame = CGRectMake(50, 250, 379, 75);
    [submitResultsButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/SubmitResults.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [submitResultsButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/SubmitResults_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    [submitResultsButton addTarget:self action:@selector(startLoadingWhileSubmittingScore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitResultsButton];
    
    if (unfinishedModulesCount !=0 ) {
        
        repeatModulesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        repeatModulesButton.frame = CGRectMake(50, 250, 379, 75);
        [repeatModulesButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/RepeatModules.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [repeatModulesButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/RepeatModules_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
        [repeatModulesButton addTarget:self action:@selector(moveToModuleView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:repeatModulesButton];
    }
    else {
        submitResultsButton.frame = CGRectMake(50, 300, 379, 75);
    }
    
    
    loadingIndicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(500,550,45,45)];
	loadingIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
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

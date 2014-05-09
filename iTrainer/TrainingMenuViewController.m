//
//  TrainingMenuViewController.m
//  iTrainer
//
//  Created by Ajay Bhardwaj on 02/07/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import "TrainingMenuViewController.h"

@interface TrainingMenuViewController ()

@end

@implementation TrainingMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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


//*********************************************** For Moving Back To Login View ***********************************************************//

- (void) moveBackToPreviousView {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//********************************************** For Moving To Driver Info View COntroller ************************************************//

- (void) moveToDriverInfoView {
    
    DriverInfoViewController *obj = [[DriverInfoViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
    
}


//*********************************************** For Moving To Driver History/List View COntroller ***************************************//

- (void) moveToDriverHistoryView {
    
    DriversListViewController *obj = [[DriversListViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
    
}



# pragma mark - View Lifecycle Methods

- (void)viewDidLoad
{
    delegate = (iTrainerAppDelegate*)[UIApplication sharedApplication].delegate;
    
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
    //[nextButton addTarget:self action:@selector(moveToMenuViewController) forControlEvents:UIControlEventTouchUpInside];
    [topHeaderImageView addSubview:nextButton];
    */
    
    startLabel = [[UILabel alloc] initWithFrame:CGRectMake(445, 80, 120, 50)];
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
    
    welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 135, 120, 50)];
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.text = [NSString stringWithFormat:@"Welcome"];
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
    

    trainNewDriverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    trainNewDriverButton.frame = CGRectMake(140, 150, 718, 103);
    [trainNewDriverButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TrainNewDriver.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [trainNewDriverButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TrainNewDriver_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    [trainNewDriverButton addTarget:self action:@selector(moveToDriverInfoView) forControlEvents:UIControlEventTouchUpInside];
    [bodyImageView addSubview:trainNewDriverButton];
    
    driverHistoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    driverHistoryButton.frame = CGRectMake(140, 280, 718, 103);
    [driverHistoryButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/DriverHistory.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [driverHistoryButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/DriverHistory_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    [driverHistoryButton addTarget:self action:@selector(moveToDriverHistoryView) forControlEvents:UIControlEventTouchUpInside];
    [bodyImageView addSubview:driverHistoryButton];
    
    /*
    testSummaryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    testSummaryButton.frame = CGRectMake(140, 400, 718, 103);
    [testSummaryButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TestSummary.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [testSummaryButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TestSummary_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    //[testSummaryButton addTarget:self action:@selector(moveToMenuViewController) forControlEvents:UIControlEventTouchUpInside];
    [bodyImageView addSubview:testSummaryButton];
    */
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewWillAppear:(BOOL)animated {
    
    self.navigationItem.hidesBackButton = YES;
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

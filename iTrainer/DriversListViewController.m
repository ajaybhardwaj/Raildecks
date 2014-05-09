//
//  DriversListViewController.m
//  iTrainer
//
//  Created by Ajay Bhardwaj on 13/08/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import "DriversListViewController.h"

@interface DriversListViewController ()

@end

@implementation DriversListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//*********************************************** For Moving Back To Login View ***********************************************************//

- (void) moveBackToPreviousView {
    
    [self.navigationController popViewControllerAnimated:YES];
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



# pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    delegate.DRIVERID = [[delegate.DRIVERSDETAILSARRAY objectAtIndex:(indexPath.row*4)] intValue];
    delegate.DRIVERNAME = [delegate.DRIVERSDETAILSARRAY objectAtIndex:(indexPath.row*4)+1];
    AttemptedDriversScoreViewController *obj = [[AttemptedDriversScoreViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70.0;
}


# pragma mark - UITableViewDatasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return delegate.DRIVERSDETAILSARRAY.count/4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    
    scoreSyncButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scoreSyncButton.frame = CGRectMake(595, 10, 30, 30);
    [cell.contentView addSubview:scoreSyncButton];
    scoreSyncButton.userInteractionEnabled = NO;
    if ([[delegate.DRIVERSDETAILSARRAY objectAtIndex:(indexPath.row*4)+3] isEqualToString:@"1"]) {
        [scoreSyncButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/checkedicon.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    }
    else {
        [scoreSyncButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/uncheckedicon.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    }
    
    scoreSyncLabel = [[UILabel alloc] initWithFrame:CGRectMake(560, 48, 100, 15)];
    scoreSyncLabel.backgroundColor = [UIColor clearColor];
    scoreSyncLabel.textAlignment = UITextAlignmentCenter;
    scoreSyncLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:14.0];
    scoreSyncLabel.textColor = [UIColor darkGrayColor];
    scoreSyncLabel.text = @"Score Synced";
    [cell.contentView addSubview:scoreSyncLabel];
    
    cell.textLabel.text = [delegate.DRIVERSDETAILSARRAY objectAtIndex:(indexPath.row*4)+1];
    cell.detailTextLabel.text = [delegate.DRIVERSDETAILSARRAY objectAtIndex:(indexPath.row*4)+2];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25.0];
    cell.textLabel.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}



# pragma mark - View Lifecycle Methods

- (void)viewDidLoad
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = NO;
    delegate = (iTrainerAppDelegate*)[UIApplication sharedApplication].delegate;
    
    [delegate retrieveDriversList];
    
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
     [nextButton addTarget:self action:@selector(moveToMenuViewController) forControlEvents:UIControlEventTouchUpInside];
     [topHeaderImageView addSubview:nextButton];
     */
    
    loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(350, 80, 300, 50)];
    loginLabel.backgroundColor = [UIColor clearColor];
    loginLabel.textAlignment = UITextAlignmentCenter;
    loginLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
    loginLabel.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    loginLabel.text = @"DRIVERS";
    [self.view addSubview:loginLabel];
    
    
    bodyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 124, 1024, 644)];
    [bodyImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Body.png",delegate.resourceFolderPath]]];
    [self.view addSubview:bodyImageView];
    bodyImageView.userInteractionEnabled = YES;
    
    welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 135, 720, 50)];
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
    welcomeLabel.textColor = [UIColor whiteColor];
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
    
    
    
    contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 120, 850, 400)];
    contentImageView.userInteractionEnabled = YES;
    [bodyImageView addSubview:contentImageView];

    
    driversListTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 0, 760, 400) style:UITableViewStylePlain];
    driversListTableView.delegate = self;
    driversListTableView.dataSource = self;
    [contentImageView addSubview:driversListTableView];
    driversListTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    driversListTableView.separatorColor = [UIColor lightGrayColor];
    driversListTableView.backgroundView = nil;
    driversListTableView.backgroundColor = [UIColor clearColor];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    
    if (delegate.ISCOMINGBACKFROMATTEMPTEDDRIVERSSCOREVIEW) {
        delegate.ISCOMINGBACKFROMATTEMPTEDDRIVERSSCOREVIEW = NO;
        
        [delegate retrieveDriversList];
        [driversListTableView reloadData];
    }
    
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

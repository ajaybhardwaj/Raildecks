//
//  ManualViewController.m
//  iTrainer
//
//  Created by Ajay Bhardwaj on 03/06/13.
//  Copyright (c) 2013 ajay@sabnetworks.com. All rights reserved.
//

#import "ManualViewController.h"

@interface ManualViewController ()

@end

@implementation ManualViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//*********************************************** For Moving Back To Previous View ********************************************************//

- (void) moveBackToPreviousView {
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - View lifecycle

-(void)viewDidLoad {
    
    delegate = (iTrainerAppDelegate*)[UIApplication sharedApplication].delegate;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *topHeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 124)];
    [topHeaderImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TopBanner.png",delegate.resourceFolderPath]]];
    [self.view addSubview:topHeaderImageView];
    topHeaderImageView.userInteractionEnabled = YES;
    
    UILabel *loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(350, 80, 300, 50)];
    loginLabel.backgroundColor = [UIColor clearColor];
    loginLabel.textAlignment = UITextAlignmentCenter;
    loginLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
    loginLabel.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    loginLabel.text = [NSString stringWithFormat:@"USER MANUAL"];
    [self.view addSubview:loginLabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(100, 92, 116, 29);
    [backButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/BackButton.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/BackButton_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(moveBackToPreviousView) forControlEvents:UIControlEventTouchUpInside];
    [topHeaderImageView addSubview:backButton];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"usermanual" ofType:@"pdf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
    UIWebView *contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 130, 1024, 640)];
    //[contentWebView setBackgroundColor:[UIColor colorWithRed:38.0/256.0 green:63.0/256.0 blue:100.0/256.0 alpha:1.0]];
    [contentWebView setOpaque:YES];
    [contentWebView setScalesPageToFit:YES];
    [self.view addSubview:contentWebView];
    [contentWebView loadRequest:request];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//******************************************************* Method For Hiding Status Bar ***********************************************************//

- (BOOL) prefersStatusBarHidden {
    
    return YES;
}

@end

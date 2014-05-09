//
//  AttemptedDriversScoreViewController.h
//  iTrainer
//
//  Created by Ajay Bhardwaj on 14/08/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "iTrainerAppDelegate.h"
#import "ModulesViewController.h"
#import "Reachability.h"
#import "ManualViewController.h"
#import "MajorComponentsViewController.h"

@interface AttemptedDriversScoreViewController : UIViewController {
    
    iTrainerAppDelegate *delegate;
    
    UIImageView *topHeaderImageView,*bodyImageView;
    UILabel *welcomeLabel,*loginLabel;
    UIButton *usermanualButton,*majorcomponentButton,*backButton;
    
    
    UIImageView *contentImageView;
    UIScrollView *contentBackgroundScrollView;
    
    UILabel *testResultLabel;
    UIButton *repeatModulesButton,*submitResultsButton;
    
    int unfinishedModulesCount;
    UIAlertView *scoreSubmissionAlert;
    UIActivityIndicatorView *loadingIndicator;
}

@end

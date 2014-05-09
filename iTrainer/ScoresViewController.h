//
//  ScoresViewController.h
//  iTrainer
//
//  Created by Ajay Bhardwaj on 13/08/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "iTrainerAppDelegate.h"
#import "Reachability.h"
#import "ManualViewController.h"
#import "MajorComponentsViewController.h"

@interface ScoresViewController : UIViewController <UIAlertViewDelegate> {
    
    iTrainerAppDelegate *delegate;
    
    
    UIImageView *topHeaderImageView,*bodyImageView;
    UILabel *welcomeLabel,*loginLabel;
    UIButton *usermanualButton,*majorcomponentButton;
    
    UIImageView *contentImageView;
    UIScrollView *contentBackgroundScrollView;
    
    UIButton *repeatModulesButton,*submitResultsButton;
    
    int unfinishedModulesCount;
    UIAlertView *scoreSubmissionAlert;
    UIActivityIndicatorView *loadingIndicator;
    
}

@end

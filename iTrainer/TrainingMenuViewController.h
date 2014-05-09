//
//  TrainingMenuViewController.h
//  iTrainer
//
//  Created by Ajay Bhardwaj on 02/07/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DriverInfoViewController.h"
#import "DriversListViewController.h"
#import "iTrainerAppDelegate.h"
#import "ManualViewController.h"
#import "MajorComponentsViewController.h"

@interface TrainingMenuViewController : UIViewController {
    
    iTrainerAppDelegate *delegate;
    
    UIImageView *topHeaderImageView,*bodyImageView,*usernameImageView,*passwordImageView;
    UILabel *welcomeLabel,*startLabel;
    UIButton *backButton,*nextButton,*usermanualButton,*majorcomponentButton;
    
    UIButton *trainNewDriverButton,*driverHistoryButton,*testSummaryButton;
}

@end

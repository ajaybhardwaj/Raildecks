//
//  DriversListViewController.h
//  iTrainer
//
//  Created by Ajay Bhardwaj on 13/08/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iTrainerAppDelegate.h"
#import "AttemptedDriversScoreViewController.h"
#import "ManualViewController.h"
#import "MajorComponentsViewController.h"

@interface DriversListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    
    iTrainerAppDelegate *delegate;
    
    UIImageView *topHeaderImageView,*bodyImageView;
    UILabel *welcomeLabel,*loginLabel;
    UIButton *usermanualButton,*majorcomponentButton,*backButton;
    
    UIImageView *contentImageView;
    UIScrollView *contentBackgroundScrollView;
    
    UITableView *driversListTableView;
    
    UIButton *scoreSyncButton;
    UILabel *scoreSyncLabel;

}

@end

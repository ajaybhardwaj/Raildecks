//
//  TestResultViewController.h
//  iTrainer
//
//  Created by Ajay Bhardwaj on 20/07/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iTrainerAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "ScoresViewController.h"
#import "ManualViewController.h"
#import "MajorComponentsViewController.h"

@interface TestResultViewController : UIViewController <UITextFieldDelegate> {
    
    iTrainerAppDelegate *delegate;
    
    UIImageView *topHeaderImageView,*bodyImageView,*passwordImageView;
    UILabel *welcomeLabel,*loginLabel;
    UIButton *usermanualButton,*majorcomponentButton;
    
    UIImageView *contentImageView;
    UIScrollView *contentBackgroundScrollView;
    
    UILabel *successLabel1,*successLabel2,*successLabel3;
    UIButton *scoreTestButton;
    UITextField *trainerPasswordField;
    UIActivityIndicatorView *loadingIndicator;
}

@end

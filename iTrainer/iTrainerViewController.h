//
//  iTrainerViewController.h
//  iTrainer
//
//  Created by Ajay Bhardwaj on 01/07/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TrainingMenuViewController.h"
#import "JSON.h"
#import "iTrainerAppDelegate.h"
#import "JSON.h"

#import "TFHppleElement.h"
#import "TFHpple.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "MWFeedParser.h"
#import "NSString+HTML.h"

#import "ManualViewController.h"
#import "MajorComponentsViewController.h"

@interface iTrainerViewController : UIViewController <UITextFieldDelegate,UIAlertViewDelegate> {
    
    iTrainerAppDelegate *delegate;
    
    UIImageView *topHeaderImageView,*bodyImageView,*usernameImageView,*passwordImageView;
    UILabel *welcomeLabel,*loginLabel;
    UIButton *removeKeypadButton,*nextButton,*usermanualButton,*majorcomponentButton;
    
    
    UIImageView *logoImageView,*lineDivideImageView;
    UIActivityIndicatorView *loadingIndicatorForSplash;
    UILabel *headingLabel,*informationLabel;
    UITextField *traineridField,*passwordField;
    UIButton *submitButton;
    
    NSMutableData *adta;
	NSURLConnection *con;
    
    NSTimer *syncStatusTimer;
    
    UIAlertView *updateCheckAlert,*confirmSyncAlert,*showDownloadingStatusAlert;
    UIActivityIndicatorView *updateCheckIndicator,*downloadingDataIndicator;
    
    UILabel *downloadingStatusLabel;
    
    UILabel *logLabel;
}


@end

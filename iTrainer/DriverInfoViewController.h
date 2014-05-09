//
//  DriverInfoViewController.h
//  iTrainer
//
//  Created by Ajay Bhardwaj on 02/07/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreModuleViewController.h"
#import "iTrainerAppDelegate.h"
#import "Reachability.h"
#import "ManualViewController.h"
#import "MajorComponentsViewController.h"

@interface DriverInfoViewController : UIViewController <UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    
    iTrainerAppDelegate *delegate;
    
    
    UIImageView *topHeaderImageView,*bodyImageView,*usernameImageView,*passwordImageView;
    UILabel *welcomeLabel,*startLabel;
    UIButton *removeKeypadButton,*backButton,*nextButton,*usermanualButton,*majorcomponentButton;
    UIImageView *dateImageView,*nameImageView,*companyImageView,*cityImageView,*emailImageView,*stateImageView,*mobileImageView;
    
    
    UIButton *takePictureButton,*submitButton;
    UITextField *dateField,*nameField,*companyField,*cityField,*emailField,*mobileField,*stateField;
    UIActionSheet *takePictureActionSheet;
    
    UIImagePickerController *ipc;
    UIPopoverController *popController;
    
    UIImage *driverImage;
    NSString *imageUploadReturnString;
        
    UIActivityIndicatorView *loadingIndicator;
}
@property (nonatomic, retain) UIPopoverController *popController;

@end

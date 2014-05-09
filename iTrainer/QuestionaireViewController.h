//
//  QuestionaireViewController.h
//  iTrainer
//
//  Created by Ajay Bhardwaj on 13/07/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iTrainerAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "TestResultViewController.h"
#import "ManualViewController.h"
#import "MajorComponentsViewController.h"

@interface QuestionaireViewController : UIViewController {
    
    iTrainerAppDelegate *delegate;
    
    UIImageView *topHeaderImageView,*bodyImageView,*passwordImageView;
    UILabel *welcomeLabel,*loginLabel;
    UIButton *nextButton,*usermanualButton,*majorcomponentButton,*backButton;
    
    
    UIImageView *logoImageView,*contentImageView,*bulletImageView;
    UIScrollView *contentBackgroundScrollView;
    UIButton *forwardButton;
    
    UILabel *headingLabel,*questionLabel,*radioLabel1,*radioLabel2,*radioLabel3,*radioLabel4,*radioLabel5;
    
    UIButton *radioButton1,*radioButton2,*radioButton3,*radioButton4,*radioButton5;
    
    int questionsSlideCount;
    
    BOOL isOptionSelected;
    int randomQuestionNumber;
    NSMutableArray *questionsIdArray;
    BOOL isFindNewRandomNumber;
    NSTimer *findNewRandomNumberTimer;
    
    NSString *answerValue,*selectedAnswerValue;
    
    float questionsAttemptedCount, correctAnswerCount;
    
    UIActivityIndicatorView *loadingIndicator;
}

- (void) moveToNextQuestionOrModule;

@end

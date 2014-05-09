//
//  PreModuleViewController.h
//  iTrainer
//
//  Created by Ajay Bhardwaj on 11/07/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iTrainerAppDelegate.h"
#import "ModulesViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MWFeedParser.h"
#import "NSString+HTML.h"
#import "ManualViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MajorComponentsViewController.h"

@interface PreModuleViewController : UIViewController <UIWebViewDelegate,AVAudioPlayerDelegate> {
    
    iTrainerAppDelegate *delegate;
    
    UIImageView *topHeaderImageView,*bodyImageView,*passwordImageView;
    UILabel *welcomeLabel,*loginLabel;
    UIButton *removeKeypadButton,*nextButton,*usermanualButton,*majorcomponentButton,*backButton,*closeButton;
    
    UIImageView *elementImageView1,*elementImageView2,*elementImageView3,*fullScreenImageView;
    
    UIButton *playerOverlayButton1,*playerOverlayButton2,*playerOverlayButton3;
    UIWebView *moviePlayer1,*moviePlayer2,*moviePlayer3;
    
    UIButton *audioPlayerButton1,*audioPlayerButton2,*audioPlayerButton3;
    AVAudioPlayer *audioPlayer1,*audioPlayer2,*audioPlayer3;
    float audioProgressBarValue1,audioProgressBarValue2,audioProgressBarValue3;
    UIProgressView *audioProgressBar1,*audioProgressBar2,*audioProgressBar3;
    NSTimer *audioProgressBarTimer1,*audioProgressBarTimer2,*audioProgressBarTimer3;
    BOOL isFirstAudioPlayer,isSecondAudioPlayer,isThirdAudioPlayer;
    
    UIWebView *contentWebView;
    UIButton *forwardButton,*previousButton,*startButton;
    
    int slideCount,contentIndex;
}

@end

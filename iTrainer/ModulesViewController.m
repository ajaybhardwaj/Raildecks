//
//  ModulesViewController.m
//  iTrainer
//
//  Created by Ajay Bhardwaj on 11/07/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import "ModulesViewController.h"

@interface ModulesViewController ()

@end

@implementation ModulesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//***************************************** Method To Move To Major Components View COntroller **********************************************//


- (void) moveToMajorComponentsViewController {
    
    [audioPlayer1 stop];
    [audioPlayer2 stop];
    [audioPlayer3 stop];
    
    [moviePlayer1 stopLoading];
    [moviePlayer2 stopLoading];
    [moviePlayer3 stopLoading];
    
    MajorComponentsViewController *obj = [[MajorComponentsViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
}


//********************************************* Method To Move To Manual View COntroller **************************************************//

- (void) moveToManualViewController {
    
    [audioPlayer1 stop];
    [audioPlayer2 stop];
    [audioPlayer3 stop];
    
    [moviePlayer1 stopLoading];
    [moviePlayer2 stopLoading];
    [moviePlayer3 stopLoading];
    
    ManualViewController *obj = [[ManualViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
}


//*********************************************** For Moving Back To Previous View ********************************************************//

- (void) moveBackToPreviousView {
    
    [audioPlayer1 stop];
    [audioPlayer2 stop];
    [audioPlayer3 stop];
    
    [moviePlayer1 stopLoading];
    [moviePlayer2 stopLoading];
    [moviePlayer3 stopLoading];
    
    [self.navigationController popViewControllerAnimated:YES];
}


//*********************************************** For Moving To Test Result View **********************************************************//

- (void) moveToTestResultView {
    
    TestResultViewController *obj = [[TestResultViewController alloc] init];
    [self.navigationController pushViewController:obj animated:NO];
}


//************************************************* For Moving To Questionaire View *******************************************************//

- (void) moveToQuestionaireView {
    
    QuestionaireViewController *obj = [[QuestionaireViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
}


//*********************************************** For Handling Review Module Button *******************************************************//

- (void) reviewModuleAction {
    
    welcomeLabel.text = @"";
    slidesCount = -1;
    forwardButton.hidden = NO;
    reviewModuleButton.hidden = YES;
    takeTestButton.hidden = YES;
    [self handleForwardButtonAction];
    previousButton.hidden = YES;
}



//************************************************* For Handling Forward Button Action ****************************************************//

- (void) handleForwardButtonAction {
    
    slidesCount = slidesCount + 1;
        
    [moviePlayer1 stopLoading];
    [moviePlayer2 stopLoading];
    [moviePlayer3 stopLoading];
    playerOverlayButton1.hidden = YES;
    playerOverlayButton2.hidden = YES;
    playerOverlayButton3.hidden = YES;
    
    [audioPlayer1 stop];
    [audioPlayer2 stop];
    [audioPlayer3 stop];
    
    audioProgressBar1.progress = 0.0;
    audioProgressBar2.progress = 0.0;
    audioProgressBar3.progress = 0.0;
    
    audioProgressBarValue1 = 0.0;
    audioProgressBarValue2 = 0.0;
    audioProgressBarValue3 = 0.0;
    
    isFirstAudioPlayer = NO;
    isSecondAudioPlayer = NO;
    isThirdAudioPlayer = NO;
    
    [audioPlayerButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [audioPlayerButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [audioPlayerButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    
    NSLog(@"%d",slidesCount);
    NSLog(@"%d",delegate.MODULESLIDESCOUNT);
    
    if (slidesCount==delegate.MODULESLIDESCOUNT) {
        
        welcomeLabel.text = @"COMPLETE";

        [moviePlayer1 stopLoading];
        [moviePlayer2 stopLoading];
        [moviePlayer3 stopLoading];
        
        [moviePlayer1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[delegate.MODULESDATAARRAY objectAtIndex:((slidesCount-1)*8)+1]]]];
        
        NSString *str = @"";//[NSString stringWithFormat:@"%@",[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)]];
        [contentWebView loadHTMLString:str baseURL:[NSURL URLWithString:@"http://website.com"]];
        
        slidesCount = 0;
        
        reviewModuleButton.hidden = NO;
        takeTestButton.hidden = NO;
        
        forwardButton.hidden = YES;
        previousButton.hidden = YES;
        
        elementImageView1.hidden = YES;
        elementImageView2.hidden = YES;
        elementImageView3.hidden = YES;
        
        moviePlayer1.hidden = YES;
        moviePlayer2.hidden = YES;
        moviePlayer3.hidden = YES;
        
        audioPlayerButton1.hidden = YES;
        audioPlayerButton2.hidden = YES;
        audioPlayerButton3.hidden = YES;
        
        audioProgressBar1.hidden = YES;
        audioProgressBar2.hidden = YES;
        audioProgressBar3.hidden = YES;
                
    }
    else {
        
        welcomeLabel.text = [NSString stringWithFormat:@"%@",[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+4]];
        
        previousButton.hidden = NO;
        NSString *str = [[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)] stringByDecodingHTMLEntities];;
        [contentWebView loadHTMLString:str baseURL:[NSURL URLWithString:@"http://website.com"]];
        
        if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TA"]) {
            
            elementImageView1.hidden = YES;
            
            moviePlayer1.hidden = YES;
            playerOverlayButton1.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                audioProgressBar1.hidden = YES;
                audioPlayerButton1.hidden = YES;
            }
            else {
                audioProgressBar1.hidden = NO;
                audioPlayerButton1.hidden = NO;
                
                audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]] error:nil];
                audioPlayer1.delegate = self;
                [audioPlayer1 prepareToPlay];
            }
        }
        
        
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TV"]) {
            
            elementImageView1.hidden = YES;
            
            audioProgressBar1.hidden = YES;
            audioPlayerButton1.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                moviePlayer1.hidden = YES;
                playerOverlayButton1.hidden = YES;
            }
            else {
                moviePlayer1.hidden = NO;
                playerOverlayButton1.hidden = NO;
                
                // iframe
                NSString *url = [delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1];
                NSString* embedHTML = [NSString stringWithFormat:@"\
                                       <iframe width=\"230\" height=\"120\" src=\"%@\" frameborder=\"1\" allowfullscreen></iframe>\
                                       ",url];
                
                NSLog(@"embeded url %@",embedHTML);
                
                NSString* html = [NSString stringWithFormat:embedHTML, url, 230, 120];
                
                [moviePlayer1 loadHTMLString:html baseURL:nil];
                
                //[moviePlayer1 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]]];
            }
        }
        
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TI"]) {
            
            moviePlayer1.hidden = YES;
            playerOverlayButton1.hidden = YES;
            
            audioProgressBar1.hidden = YES;
            audioPlayerButton1.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                elementImageView1.hidden = YES;
            }
            else {
                elementImageView1.hidden = NO;
                elementImageView1.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]];
            }
        }
        else {
            
            elementImageView1.hidden = YES;
            
            audioProgressBar1.hidden = YES;
            audioPlayerButton1.hidden = YES;
            
            moviePlayer1.hidden = YES;
            playerOverlayButton1.hidden = YES;
            
        }
        
        
        
        if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TA"]) {
            
            elementImageView2.hidden = YES;
            
            moviePlayer2.hidden = YES;
            playerOverlayButton2.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                audioProgressBar2.hidden = YES;
                audioPlayerButton2.hidden = YES;
            }
            else {
                audioProgressBar2.hidden = NO;
                audioPlayerButton2.hidden = NO;
                
                audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]] error:nil];
                audioPlayer2.delegate = self;
                [audioPlayer2 prepareToPlay];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TV"]) {
            
            elementImageView2.hidden = YES;
            
            audioProgressBar2.hidden = YES;
            audioPlayerButton2.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                moviePlayer2.hidden = YES;
                playerOverlayButton2.hidden = YES;
            }
            else {
                moviePlayer2.hidden = NO;
                playerOverlayButton2.hidden = NO;
                
                //[moviePlayer2 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]]];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TI"]) {
            
            moviePlayer2.hidden = YES;
            playerOverlayButton2.hidden = YES;
            
            audioProgressBar2.hidden = YES;
            audioPlayerButton2.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                elementImageView2.hidden = YES;
            }
            else {
                elementImageView2.hidden = NO;
                elementImageView2.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]];
            }
        }
        else {
            
            elementImageView2.hidden = YES;
            
            audioProgressBar2.hidden = YES;
            audioPlayerButton2.hidden = YES;
            
            moviePlayer2.hidden = YES;
            playerOverlayButton2.hidden = YES;
            
        }
        
        
        
        if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TA"]) {
            
            elementImageView3.hidden = YES;
            
            moviePlayer3.hidden = YES;
            playerOverlayButton3.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                audioProgressBar3.hidden = YES;
                audioPlayerButton3.hidden = YES;
            }
            else {
                audioProgressBar3.hidden = NO;
                audioPlayerButton3.hidden = NO;
                
                audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]] error:nil];
                audioPlayer3.delegate = self;
                [audioPlayer3 prepareToPlay];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TV"]) {
            
            elementImageView3.hidden = YES;
            
            audioProgressBar3.hidden = YES;
            audioPlayerButton3.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                moviePlayer3.hidden = YES;
                playerOverlayButton3.hidden = YES;
            }
            else {
                moviePlayer3.hidden = NO;
                playerOverlayButton3.hidden = NO;
                
                //[moviePlayer3 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]]];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TI"]) {
            
            moviePlayer3.hidden = YES;
            playerOverlayButton3.hidden = YES;
            
            audioProgressBar3.hidden = YES;
            audioPlayerButton3.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                elementImageView3.hidden = YES;
            }
            else {
                elementImageView3.hidden = NO;
                elementImageView3.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]];
            }
        }
        else {
            
            elementImageView3.hidden = YES;
            
            audioProgressBar3.hidden = YES;
            audioPlayerButton3.hidden = YES;
            
            moviePlayer3.hidden = YES;
            playerOverlayButton3.hidden = YES;
            
        }
        
    }
}



//*********************************************** For Handling Previous Button Action *****************************************************//

- (void) handlePreviousButtonAction {
    
    slidesCount = slidesCount - 1;
    
    
    welcomeLabel.text = [NSString stringWithFormat:@"%@",[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+4]];
    
    [moviePlayer1 stopLoading];
    [moviePlayer2 stopLoading];
    [moviePlayer3 stopLoading];
    playerOverlayButton1.hidden = YES;
    playerOverlayButton2.hidden = YES;
    playerOverlayButton3.hidden = YES;
    
    [audioPlayer1 stop];
    [audioPlayer2 stop];
    [audioPlayer3 stop];
    
    audioProgressBar1.progress = 0.0;
    audioProgressBar2.progress = 0.0;
    audioProgressBar3.progress = 0.0;
    
    audioProgressBarValue1 = 0.0;
    audioProgressBarValue2 = 0.0;
    audioProgressBarValue3 = 0.0;
    
    isFirstAudioPlayer = NO;
    isSecondAudioPlayer = NO;
    isThirdAudioPlayer = NO;
    
    [audioPlayerButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [audioPlayerButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [audioPlayerButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    
    NSLog(@"%d",slidesCount);
    NSLog(@"%d",delegate.MODULESLIDESCOUNT);
    
    if (slidesCount==0) {
        
        previousButton.hidden = YES;
        
        NSString *str = [[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)] stringByDecodingHTMLEntities];
        [contentWebView loadHTMLString:str baseURL:[NSURL URLWithString:@"http://website.com"]];
        
        slidesCount = 0;
        
        
        if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TA"]) {
            
            elementImageView1.hidden = YES;
            
            moviePlayer1.hidden = YES;
            playerOverlayButton1.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                audioProgressBar1.hidden = YES;
                audioPlayerButton1.hidden = YES;
            }
            else {
                audioProgressBar1.hidden = NO;
                audioPlayerButton1.hidden = NO;
                
                audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]] error:nil];
                audioPlayer1.delegate = self;
                [audioPlayer1 prepareToPlay];
            }
        }
        
        
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TV"]) {
            
            elementImageView1.hidden = YES;
            
            audioProgressBar1.hidden = YES;
            audioPlayerButton1.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                moviePlayer1.hidden = YES;
                playerOverlayButton1.hidden = YES;
            }
            else {
                moviePlayer1.hidden = NO;
                playerOverlayButton1.hidden = NO;
                
                //[moviePlayer1 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]]];
            }
        }
        
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TI"]) {
            
            moviePlayer1.hidden = YES;
            playerOverlayButton1.hidden = YES;
            
            audioProgressBar1.hidden = YES;
            audioPlayerButton1.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                elementImageView1.hidden = YES;
            }
            else {
                elementImageView1.hidden = NO;
                elementImageView1.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]];
            }
        }
        else {
            
            elementImageView1.hidden = YES;
            
            audioProgressBar1.hidden = YES;
            audioPlayerButton1.hidden = YES;
            
            moviePlayer1.hidden = YES;
            playerOverlayButton1.hidden = YES;
            
        }
        
        
        
        if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TA"]) {
            
            elementImageView2.hidden = YES;
            
            moviePlayer2.hidden = YES;
            playerOverlayButton2.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                audioProgressBar2.hidden = YES;
                audioPlayerButton2.hidden = YES;
            }
            else {
                audioProgressBar2.hidden = NO;
                audioPlayerButton2.hidden = NO;
                
                audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]] error:nil];
                audioPlayer2.delegate = self;
                [audioPlayer2 prepareToPlay];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TV"]) {
            
            elementImageView2.hidden = YES;
            
            audioProgressBar2.hidden = YES;
            audioPlayerButton2.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                moviePlayer2.hidden = YES;
                playerOverlayButton2.hidden = YES;
            }
            else {
                moviePlayer2.hidden = NO;
                playerOverlayButton2.hidden = NO;
                
                //[moviePlayer2 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]]];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TI"]) {
            
            moviePlayer2.hidden = YES;
            playerOverlayButton2.hidden = YES;
            
            audioProgressBar2.hidden = YES;
            audioPlayerButton2.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                elementImageView2.hidden = YES;
            }
            else {
                elementImageView2.hidden = NO;
                elementImageView2.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]];
            }
        }
        else {
            
            elementImageView2.hidden = YES;
            
            audioProgressBar2.hidden = YES;
            audioPlayerButton2.hidden = YES;
            
            moviePlayer2.hidden = YES;
            playerOverlayButton2.hidden = YES;
            
        }
        
        
        
        if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TA"]) {
            
            elementImageView3.hidden = YES;
            
            moviePlayer3.hidden = YES;
            playerOverlayButton3.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                audioProgressBar3.hidden = YES;
                audioPlayerButton3.hidden = YES;
            }
            else {
                audioProgressBar3.hidden = NO;
                audioPlayerButton3.hidden = NO;
                
                audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]] error:nil];
                audioPlayer3.delegate = self;
                [audioPlayer3 prepareToPlay];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TV"]) {
            
            elementImageView3.hidden = YES;
            
            audioProgressBar3.hidden = YES;
            audioPlayerButton3.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                moviePlayer3.hidden = YES;
                playerOverlayButton3.hidden = YES;
            }
            else {
                moviePlayer3.hidden = NO;
                playerOverlayButton3.hidden = NO;
                
                //[moviePlayer3 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]]];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TI"]) {
            
            moviePlayer3.hidden = YES;
            playerOverlayButton3.hidden = YES;
            
            audioProgressBar3.hidden = YES;
            audioPlayerButton3.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                elementImageView3.hidden = YES;
            }
            else {
                elementImageView3.hidden = NO;
                elementImageView3.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]];
            }
        }
        else {
            
            elementImageView3.hidden = YES;
            
            audioProgressBar3.hidden = YES;
            audioPlayerButton3.hidden = YES;
            
            moviePlayer3.hidden = YES;
            playerOverlayButton3.hidden = YES;
            
        }
        
    }

    else {
        
        forwardButton.hidden = NO;
        NSString *str = [[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)] stringByDecodingHTMLEntities];
        [contentWebView loadHTMLString:str baseURL:[NSURL URLWithString:@"http://website.com"]];
        
        if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TA"]) {
            
            elementImageView1.hidden = YES;
            
            moviePlayer1.hidden = YES;
            playerOverlayButton1.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                audioProgressBar1.hidden = YES;
                audioPlayerButton1.hidden = YES;
            }
            else {
                audioProgressBar1.hidden = NO;
                audioPlayerButton1.hidden = NO;
                
                audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]] error:nil];
                audioPlayer1.delegate = self;
                [audioPlayer1 prepareToPlay];
            }
        }
        
        
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TV"]) {
            
            elementImageView1.hidden = YES;
            
            audioProgressBar1.hidden = YES;
            audioPlayerButton1.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                moviePlayer1.hidden = YES;
                playerOverlayButton1.hidden = YES;
            }
            else {
                moviePlayer1.hidden = NO;
                playerOverlayButton1.hidden = NO;
                
                //[moviePlayer1 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]]];
            }
        }
        
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TI"]) {
            
            moviePlayer1.hidden = YES;
            playerOverlayButton1.hidden = YES;
            
            audioProgressBar1.hidden = YES;
            audioPlayerButton1.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                elementImageView1.hidden = YES;
            }
            else {
                elementImageView1.hidden = NO;
                elementImageView1.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]];
            }
        }
        else {
            
            elementImageView1.hidden = YES;
            
            audioProgressBar1.hidden = YES;
            audioPlayerButton1.hidden = YES;
            
            moviePlayer1.hidden = YES;
            playerOverlayButton1.hidden = YES;
            
        }
        
        
        
        if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TA"]) {
            
            elementImageView2.hidden = YES;
            
            moviePlayer2.hidden = YES;
            playerOverlayButton2.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                audioProgressBar2.hidden = YES;
                audioPlayerButton2.hidden = YES;
            }
            else {
                audioProgressBar2.hidden = NO;
                audioPlayerButton2.hidden = NO;
                
                audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]] error:nil];
                audioPlayer2.delegate = self;
                [audioPlayer2 prepareToPlay];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TV"]) {
            
            elementImageView2.hidden = YES;
            
            audioProgressBar2.hidden = YES;
            audioPlayerButton2.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                moviePlayer2.hidden = YES;
                playerOverlayButton2.hidden = YES;
            }
            else {
                moviePlayer2.hidden = NO;
                playerOverlayButton2.hidden = NO;
                
                //[moviePlayer2 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]]];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TI"]) {
            
            moviePlayer2.hidden = YES;
            playerOverlayButton2.hidden = YES;
            
            audioProgressBar2.hidden = YES;
            audioPlayerButton2.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                elementImageView2.hidden = YES;
            }
            else {
                elementImageView2.hidden = NO;
                elementImageView2.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]];
            }
        }
        else {
            
            elementImageView2.hidden = YES;
            
            audioProgressBar2.hidden = YES;
            audioPlayerButton2.hidden = YES;
            
            moviePlayer2.hidden = YES;
            playerOverlayButton2.hidden = YES;
            
        }
        
        
        
        if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TA"]) {
            
            elementImageView3.hidden = YES;
            
            moviePlayer3.hidden = YES;
            playerOverlayButton3.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                audioProgressBar3.hidden = YES;
                audioPlayerButton3.hidden = YES;
            }
            else {
                audioProgressBar3.hidden = NO;
                audioPlayerButton3.hidden = NO;
                
                audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]] error:nil];
                audioPlayer3.delegate = self;
                [audioPlayer3 prepareToPlay];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TV"]) {
            
            elementImageView3.hidden = YES;
            
            audioProgressBar3.hidden = YES;
            audioPlayerButton3.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                moviePlayer3.hidden = YES;
                playerOverlayButton3.hidden = YES;
            }
            else {
                moviePlayer3.hidden = NO;
                playerOverlayButton3.hidden = NO;
                
                //[moviePlayer3 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]]];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TI"]) {
            
            moviePlayer3.hidden = YES;
            playerOverlayButton3.hidden = YES;
            
            audioProgressBar3.hidden = YES;
            audioPlayerButton3.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                elementImageView3.hidden = YES;
            }
            else {
                elementImageView3.hidden = NO;
                elementImageView3.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]];
            }
        }
        else {
            
            elementImageView3.hidden = YES;
            
            audioProgressBar3.hidden = YES;
            audioPlayerButton3.hidden = YES;
            
            moviePlayer3.hidden = YES;
            playerOverlayButton3.hidden = YES;
            
        }

        
    }
}




//************************************************* For Removing Fullscreen Image View ****************************************************//

- (void) removeFullscreenImageView {
    
    welcomeLabel.hidden = NO;
    //previousButton.hidden = NO;
    //forwardButton.hidden = NO;
    fullScreenImageView.hidden = YES;
    closeButton.hidden = YES;
    
    backButton.userInteractionEnabled = YES;
    usermanualButton.userInteractionEnabled = YES;
    majorcomponentButton.userInteractionEnabled = YES;
}


//*************************************************** For Playing Specific Video Player ***************************************************//


- (void) playVideoPlayer:(id) sender {
    
    UIButton *button = (id) sender;
    
    if (button.tag==1) {
        playerOverlayButton1.hidden = YES;
        if (![[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"NA"]) {
            playerOverlayButton2.hidden = NO;
        }
        if (![[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"NA"]) {
            playerOverlayButton3.hidden = NO;
        }
        //[moviePlayer1 play];
    }
    else if (button.tag==2) {
        if (![[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"NA"]) {
            playerOverlayButton1.hidden = NO;
        }
        playerOverlayButton2.hidden = YES;
        if (![[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"NA"]) {
            playerOverlayButton3.hidden = NO;
        }
        //[moviePlayer2 play];
    }
    else if (button.tag==3) {
        if (![[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"NA"]) {
            playerOverlayButton1.hidden = NO;
        }
        if (![[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"NA"]) {
            playerOverlayButton2.hidden = NO;
        }
        playerOverlayButton3.hidden = YES;
        //[moviePlayer3 play];
    }
}




//************************************************** For Maintaining Audio Players Progress Bar *******************************************//

- (void) updateAudioPlayerProgressBar {
    
    if (isFirstAudioPlayer) {
        
        float total=audioPlayer1.duration;
        audioProgressBarValue1 = audioPlayer1.currentTime / total;
        audioProgressBar1.progress = audioProgressBarValue1;
        
    }
    else if (isSecondAudioPlayer) {
        
        float total=audioPlayer2.duration;
        audioProgressBarValue2 = audioPlayer2.currentTime / total;
        audioProgressBar2.progress = audioProgressBarValue2;
        
    }
    else if (isThirdAudioPlayer) {
        
        float total=audioPlayer3.duration;
        audioProgressBarValue3 = audioPlayer3.currentTime / total;
        audioProgressBar3.progress = audioProgressBarValue3;
        
    }
    
}



//************************************************* For Playing Specific Audio Player *****************************************************//


- (void) playAudioPlayer:(id) sender {
    
    UIButton *button = (id) sender;
    
    if (button.tag==4) {
        
        [audioProgressBarTimer1 invalidate];
        [audioProgressBarTimer2 invalidate];
        [audioProgressBarTimer3 invalidate];
        
        [audioPlayerButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [audioPlayerButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        
        audioProgressBar2.progress = audioProgressBarValue2;
        audioProgressBar3.progress = audioProgressBarValue3;
        
        [audioPlayer2 pause];
        [audioPlayer3 pause];
        
        if (!isFirstAudioPlayer) {
            isFirstAudioPlayer = YES;
            isSecondAudioPlayer = NO;
            isThirdAudioPlayer = NO;
            
            [audioPlayerButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Pause.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
            audioProgressBarTimer1 = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateAudioPlayerProgressBar) userInfo:nil repeats:YES];
            
            [audioPlayer1 play];
            
            audioProgressBar1.progress = audioProgressBarValue1;
        }
        else if (isFirstAudioPlayer) {
            
            isFirstAudioPlayer = NO;
            isSecondAudioPlayer = NO;
            isThirdAudioPlayer = NO;
            [audioPlayerButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
            
            [audioPlayer1 pause];
            
            audioProgressBar1.progress = audioProgressBarValue1;
        }
        
    }
    else if (button.tag==5) {
        
        [audioProgressBarTimer1 invalidate];
        [audioProgressBarTimer2 invalidate];
        [audioProgressBarTimer3 invalidate];
        
        [audioPlayerButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [audioPlayerButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        
        audioProgressBar1.progress = audioProgressBarValue1;
        audioProgressBar3.progress = audioProgressBarValue3;
        
        [audioPlayer1 pause];
        [audioPlayer3 pause];
        
        if (!isSecondAudioPlayer) {
            isFirstAudioPlayer = NO;
            isSecondAudioPlayer = YES;
            isThirdAudioPlayer = NO;
            
            [audioPlayerButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Pause.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
            audioProgressBarTimer2 = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateAudioPlayerProgressBar) userInfo:nil repeats:YES];
            
            [audioPlayer2 play];
            
            audioProgressBar2.progress = audioProgressBarValue2;
        }
        else if (isSecondAudioPlayer) {
            
            isFirstAudioPlayer = NO;
            isSecondAudioPlayer = NO;
            isThirdAudioPlayer = NO;
            [audioPlayerButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
            
            [audioPlayer2 pause];
            
            audioProgressBar2.progress = audioProgressBarValue2;
        }
        
    }
    else if (button.tag==6) {
        
        [audioProgressBarTimer1 invalidate];
        [audioProgressBarTimer2 invalidate];
        [audioProgressBarTimer3 invalidate];
        
        [audioPlayerButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [audioPlayerButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        
        audioProgressBar1.progress = audioProgressBarValue1;
        audioProgressBar2.progress = audioProgressBarValue2;
        
        [audioPlayer1 pause];
        [audioPlayer2 pause];
        
        if (!isThirdAudioPlayer) {
            isFirstAudioPlayer = NO;
            isSecondAudioPlayer = NO;
            isThirdAudioPlayer = YES;
            
            [audioPlayerButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Pause.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
            audioProgressBarTimer3 = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateAudioPlayerProgressBar) userInfo:nil repeats:YES];
            
            [audioPlayer3 play];
            
            audioProgressBar3.progress = audioProgressBarValue3;
        }
        else if (isThirdAudioPlayer) {
            
            isFirstAudioPlayer = NO;
            isSecondAudioPlayer = NO;
            isThirdAudioPlayer = NO;
            [audioPlayerButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
            
            [audioPlayer3 pause];
            
            audioProgressBar3.progress = audioProgressBarValue3;
        }
    }
}



//**************************** For Creating WebView To Avoid Crashing As App Was Running On Background Thread *****************************//

- (void) createWebView {
    
    contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(300, 120, 650, 400)];
    [contentWebView setBackgroundColor:[UIColor clearColor]];
    [contentWebView setOpaque:YES];
    [bodyImageView addSubview:contentWebView];
    
    if (delegate.MODULESDATAARRAY.count/8 != 0) {
        
        NSString *str = [[delegate.MODULESDATAARRAY objectAtIndex:0] stringByDecodingHTMLEntities];
        [contentWebView loadHTMLString:str baseURL:[NSURL URLWithString:@"http://website.com"]];
        
        elementImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 120, 230, 120)];
        [bodyImageView addSubview:elementImageView1];
        elementImageView1.userInteractionEnabled = YES;
        elementImageView1.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        elementImageView1.layer.borderWidth = 4.0;
        elementImageView1.hidden = YES;
        
        elementImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 260, 230, 120)];
        [bodyImageView addSubview:elementImageView2];
        elementImageView2.userInteractionEnabled = YES;
        elementImageView2.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        elementImageView2.layer.borderWidth = 4.0;
        elementImageView2.hidden = YES;
        
        elementImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 400, 230, 120)];
        [bodyImageView addSubview:elementImageView3];
        elementImageView3.userInteractionEnabled = YES;
        elementImageView3.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        elementImageView3.layer.borderWidth = 4.0;
        elementImageView3.hidden = YES;
        
        //NSString *moviepath = [[NSBundle mainBundle] pathForResource:@"Bodyguard" ofType:@"mp4"];
        //NSString *moviepath1 = [[NSBundle mainBundle] pathForResource:@"Don2" ofType:@"mp4"];
        /*
        moviePlayer1 = [[MPMoviePlayerController alloc] init];
        moviePlayer1.view.frame = CGRectMake(55, 120, 230, 120);
        [bodyImageView addSubview:moviePlayer1.view];
        [moviePlayer1 setControlStyle:MPMovieControlStyleDefault];
        moviePlayer1.allowsAirPlay = YES;
        moviePlayer1.shouldAutoplay = NO;
        [moviePlayer1 prepareToPlay];
        moviePlayer1.view.hidden = YES;
        
        playerOverlayButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        playerOverlayButton1.frame = CGRectMake(55, 120, 230, 120);
        [playerOverlayButton1 setBackgroundImage:[UIImage imageNamed:@"play-button-overlay.jpg"] forState:UIControlStateNormal];
        playerOverlayButton1.tag = 1;
        [playerOverlayButton1 addTarget:self action:@selector(playVideoPlayer:) forControlEvents:UIControlEventTouchUpInside];
        [bodyImageView addSubview:playerOverlayButton1];
        playerOverlayButton1.hidden = YES;
        
        moviePlayer2 = [[MPMoviePlayerController alloc] init];
        moviePlayer2.view.frame = CGRectMake(55, 260, 230, 120);
        [bodyImageView addSubview:moviePlayer2.view];
        [moviePlayer2 setControlStyle:MPMovieControlStyleDefault];
        moviePlayer2.allowsAirPlay = YES;
        moviePlayer2.shouldAutoplay = NO;
        [moviePlayer2 prepareToPlay];
        moviePlayer2.view.hidden = YES;
        
        playerOverlayButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        playerOverlayButton2.frame = CGRectMake(55, 260, 230, 120);
        [playerOverlayButton2 setBackgroundImage:[UIImage imageNamed:@"play-button-overlay.jpg"] forState:UIControlStateNormal];
        playerOverlayButton2.tag = 2;
        [playerOverlayButton2 addTarget:self action:@selector(playVideoPlayer:) forControlEvents:UIControlEventTouchUpInside];
        [bodyImageView addSubview:playerOverlayButton2];
        playerOverlayButton2.hidden = YES;
        
        moviePlayer3 = [[MPMoviePlayerController alloc] init];
        moviePlayer3.view.frame = CGRectMake(55, 400, 230, 120);
        [bodyImageView addSubview:moviePlayer3.view];
        [moviePlayer3 setControlStyle:MPMovieControlStyleDefault];
        moviePlayer3.allowsAirPlay = YES;
        moviePlayer3.shouldAutoplay = NO;
        [moviePlayer3 prepareToPlay];
        moviePlayer3.view.hidden = YES;
        
        playerOverlayButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
        playerOverlayButton3.frame = CGRectMake(55, 400, 230, 120);
        [playerOverlayButton3 setBackgroundImage:[UIImage imageNamed:@"play-button-overlay.jpg"] forState:UIControlStateNormal];
        playerOverlayButton3.tag = 3;
        [playerOverlayButton3 addTarget:self action:@selector(playVideoPlayer:) forControlEvents:UIControlEventTouchUpInside];
        [bodyImageView addSubview:playerOverlayButton3];
        playerOverlayButton3.hidden = YES;
        */
        
        moviePlayer1 = [[UIWebView alloc] initWithFrame:CGRectMake(55, 120, 230, 120)];
        [bodyImageView addSubview:moviePlayer1];
        
        audioPlayerButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        audioPlayerButton1.frame = CGRectMake(130, 120, 70, 70);
        [audioPlayerButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        audioPlayerButton1.tag = 4;
        [audioPlayerButton1 addTarget:self action:@selector(playAudioPlayer:) forControlEvents:UIControlEventTouchUpInside];
        [bodyImageView addSubview:audioPlayerButton1];
        audioPlayerButton1.hidden = YES;
        
        audioProgressBar1 = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        audioProgressBar1.frame = CGRectMake(70, 200, 200, 20);
        [bodyImageView addSubview:audioProgressBar1];
        [audioProgressBar1 setProgress:0.0 animated:YES];
        audioProgressBar1.hidden = YES;
        
        
        audioPlayerButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        audioPlayerButton2.frame = CGRectMake(130, 260, 70, 70);
        [audioPlayerButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        audioPlayerButton2.tag = 5;
        [audioPlayerButton2 addTarget:self action:@selector(playAudioPlayer:) forControlEvents:UIControlEventTouchUpInside];
        [bodyImageView addSubview:audioPlayerButton2];
        audioPlayerButton2.hidden = YES;
        
        audioProgressBar2 = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        audioProgressBar2.frame = CGRectMake(70, 340, 200, 20);
        [bodyImageView addSubview:audioProgressBar2];
        [audioProgressBar2 setProgress:0.0 animated:YES];
        audioProgressBar2.hidden = YES;
        
        
        audioPlayerButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
        audioPlayerButton3.frame = CGRectMake(130, 400, 70, 70);
        [audioPlayerButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        audioPlayerButton3.tag = 6;
        [audioPlayerButton3 addTarget:self action:@selector(playAudioPlayer:) forControlEvents:UIControlEventTouchUpInside];
        [bodyImageView addSubview:audioPlayerButton3];
        audioPlayerButton3.hidden = YES;
        
        audioProgressBar3 = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        audioProgressBar3.frame = CGRectMake(70, 480, 200, 20);
        [bodyImageView addSubview:audioProgressBar3];
        [audioProgressBar3 setProgress:0.0 animated:YES];
        audioProgressBar3.hidden = YES;
        
        
        forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        forwardButton.frame = CGRectMake(760, 660, 130, 50);
        [forwardButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/NextAarrows.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [forwardButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/NextAarrows_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateSelected];
        [forwardButton addTarget:self action:@selector(handleForwardButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:forwardButton];
        
        previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        previousButton.frame = CGRectMake(360, 660, 130, 50);
        [previousButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/PreviousArrows.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [previousButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/PreviousArrows_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateSelected];
        [previousButton addTarget:self action:@selector(handlePreviousButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:previousButton];
        previousButton.hidden = YES;
        
        
        //NSString *backgroundMusicFilePath = [[NSBundle mainBundle] pathForResource:@"Sound_BG" ofType:@"mp3"];
        //NSURL *musicUrl = [[NSURL alloc] initFileURLWithPath:backgroundMusicFilePath];
        
        
        
        
        
        if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TA"]) {
            
            elementImageView1.hidden = YES;
            
            moviePlayer1.hidden = YES;
            playerOverlayButton1.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                audioProgressBar1.hidden = YES;
                audioPlayerButton1.hidden = YES;
            }
            else {
                audioProgressBar1.hidden = NO;
                audioPlayerButton1.hidden = NO;
                
                audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]] error:nil];
                audioPlayer1.delegate = self;
                [audioPlayer1 prepareToPlay];
            }
        }
        
        
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TV"]) {
            
            elementImageView1.hidden = YES;
            
            audioProgressBar1.hidden = YES;
            audioPlayerButton1.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                moviePlayer1.hidden = YES;
                playerOverlayButton1.hidden = YES;
            }
            else {
                moviePlayer1.hidden = NO;
                playerOverlayButton1.hidden = NO;
                
                
                // iframe
                NSString *url = [delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1];
                NSString* embedHTML = [NSString stringWithFormat:@"\
                                       <iframe width=\"230\" height=\"120\" src=\"%@\" frameborder=\"1\" allowfullscreen></iframe>\
                                       ",url];
                
                NSLog(@"embeded url %@",embedHTML);
                
                NSString* html = [NSString stringWithFormat:embedHTML, url, 230, 120];
                
                [moviePlayer1 loadHTMLString:html baseURL:nil];
                
                //[moviePlayer1 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]]];
            }
        }
        
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TI"]) {
            
            moviePlayer1.hidden = YES;
            playerOverlayButton1.hidden = YES;
            
            audioProgressBar1.hidden = YES;
            audioPlayerButton1.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                elementImageView1.hidden = YES;
            }
            else {
                elementImageView1.hidden = NO;
                elementImageView1.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]];
            }
        }
        else {
            
            elementImageView1.hidden = YES;
            
            audioProgressBar1.hidden = YES;
            audioPlayerButton1.hidden = YES;
            
            moviePlayer1.hidden = YES;
            playerOverlayButton1.hidden = YES;

        }
        
        
        
        if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TA"]) {
            
            elementImageView2.hidden = YES;
            
            moviePlayer2.hidden = YES;
            playerOverlayButton2.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                audioProgressBar2.hidden = YES;
                audioPlayerButton2.hidden = YES;
            }
            else {
                audioProgressBar2.hidden = NO;
                audioPlayerButton2.hidden = NO;
                
                audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]] error:nil];
                audioPlayer2.delegate = self;
                [audioPlayer2 prepareToPlay];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TV"]) {
            
            elementImageView2.hidden = YES;
            
            audioProgressBar2.hidden = YES;
            audioPlayerButton2.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                moviePlayer2.hidden = YES;
                playerOverlayButton2.hidden = YES;
            }
            else {
                moviePlayer2.hidden = NO;
                playerOverlayButton2.hidden = NO;
                
                //[moviePlayer2 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]]];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TI"]) {
            
            moviePlayer2.hidden = YES;
            playerOverlayButton2.hidden = YES;
            
            audioProgressBar2.hidden = YES;
            audioPlayerButton2.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                elementImageView2.hidden = YES;
            }
            else {
                elementImageView2.hidden = NO;
                elementImageView2.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]];
            }
        }
        else {
            
            elementImageView2.hidden = YES;
            
            audioProgressBar2.hidden = YES;
            audioPlayerButton2.hidden = YES;
            
            moviePlayer2.hidden = YES;
            playerOverlayButton2.hidden = YES;
            
        }
        
        
        
        if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TA"]) {
            
            elementImageView3.hidden = YES;
            
            moviePlayer3.hidden = YES;
            playerOverlayButton3.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                audioProgressBar3.hidden = YES;
                audioPlayerButton3.hidden = YES;
            }
            else {
                audioProgressBar3.hidden = NO;
                audioPlayerButton3.hidden = NO;
                
                audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]] error:nil];
                audioPlayer3.delegate = self;
                [audioPlayer3 prepareToPlay];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TV"]) {
            
            elementImageView3.hidden = YES;
            
            audioProgressBar3.hidden = YES;
            audioPlayerButton3.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                moviePlayer3.hidden = YES;
                playerOverlayButton3.hidden = YES;
            }
            else {
                moviePlayer3.hidden = NO;
                playerOverlayButton3.hidden = NO;
                
                //[moviePlayer3 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]]];
            }
        }
        else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TI"]) {
            
            moviePlayer3.hidden = YES;
            playerOverlayButton3.hidden = YES;
            
            audioProgressBar3.hidden = YES;
            audioPlayerButton3.hidden = YES;
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                elementImageView3.hidden = YES;
            }
            else {
                elementImageView3.hidden = NO;
                elementImageView3.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]];
            }
        }
        else {
            
            elementImageView3.hidden = YES;
            
            audioProgressBar3.hidden = YES;
            audioPlayerButton3.hidden = YES;
            
            moviePlayer3.hidden = YES;
            playerOverlayButton3.hidden = YES;
            
        }

        
    }
    
    else {
        /*
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"No slides are available for the module" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
        */
        [self performSelector:@selector(moveToTestResultView) withObject:nil afterDelay:0.5];

    }
    
    
    reviewModuleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reviewModuleButton.frame = CGRectMake(150, 150, 718, 103);
    [reviewModuleButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/ReviewModule.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [reviewModuleButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/ReviewModule_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    [reviewModuleButton addTarget:self action:@selector(reviewModuleAction) forControlEvents:UIControlEventTouchUpInside];
    [bodyImageView addSubview:reviewModuleButton];
    reviewModuleButton.hidden = YES;
    
    
    takeTestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    takeTestButton.frame = CGRectMake(150, 450, 718, 103);
    [takeTestButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TakeModuleTest.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [takeTestButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TakeModuleTest_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    [takeTestButton addTarget:self action:@selector(moveToQuestionaireView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takeTestButton];
    takeTestButton.hidden = YES;
    
    
    fullScreenImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 120, 924, 620)];
    [self.view addSubview:fullScreenImageView];
    fullScreenImageView.userInteractionEnabled = YES;
    fullScreenImageView.layer.borderWidth = 5.0;
    fullScreenImageView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    fullScreenImageView.hidden = YES;
    
    
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(940, 100, 50, 50);
    [closeButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/closeButton.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(removeFullscreenImageView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    closeButton.hidden = YES;
}


# pragma mark - AVAudioPlayerDelegate Methods

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    if (player==audioPlayer1) {
        if (flag==YES) {
            isFirstAudioPlayer = NO;
            [audioPlayerButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
            [audioProgressBarTimer1 invalidate];
            audioProgressBar1.progress = 0.0;
            audioProgressBarValue1 = 0.0;
        }
    }
    else if (player==audioPlayer2) {
        if (flag==YES) {
            isSecondAudioPlayer = NO;
            [audioPlayerButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
            [audioProgressBarTimer2 invalidate];
            audioProgressBar2.progress = 0.0;
            audioProgressBarValue2 = 0.0;
        }
    }
    else if (player==audioPlayer3) {
        if (flag==YES) {
            isThirdAudioPlayer = NO;
            [audioPlayerButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Play.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
            [audioProgressBarTimer3 invalidate];
            audioProgressBar3.progress = 0.0;
            audioProgressBarValue3 = 0.0;
        }
    }
}


#pragma mark - UITouchEvent Methods

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([touch view] == elementImageView1) {
        
        welcomeLabel.hidden = YES;
        //previousButton.hidden = YES;
        //forwardButton.hidden = YES;
        fullScreenImageView.hidden = NO;
        closeButton.hidden = NO;
        fullScreenImageView.image = elementImageView1.image;
        backButton.userInteractionEnabled = NO;
        usermanualButton.userInteractionEnabled = NO;
        majorcomponentButton.userInteractionEnabled = NO;
    }
    else if ([touch view] == elementImageView2) {
        
        welcomeLabel.hidden = YES;
        //previousButton.hidden = YES;
        //forwardButton.hidden = YES;
        fullScreenImageView.hidden = NO;
        closeButton.hidden = NO;
        fullScreenImageView.image = elementImageView2.image;
        backButton.userInteractionEnabled = NO;
        usermanualButton.userInteractionEnabled = NO;
        majorcomponentButton.userInteractionEnabled = NO;
    }
    else if ([touch view] == elementImageView3) {
        
        welcomeLabel.hidden = YES;
        //previousButton.hidden = YES;
        //forwardButton.hidden = YES;
        fullScreenImageView.hidden = NO;
        closeButton.hidden = NO;
        fullScreenImageView.image = elementImageView3.image;
        backButton.userInteractionEnabled = NO;
        usermanualButton.userInteractionEnabled = NO;
        majorcomponentButton.userInteractionEnabled = NO;
    }
    
}


# pragma mark - View Lifecycle Methods

- (void)viewDidLoad
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;    
    delegate = (iTrainerAppDelegate*)[UIApplication sharedApplication].delegate;
    
    //delegate.MODULESLIDESCOUNT = [delegate retrieveTotalModuleSlidesCount];
    //[delegate retrieveSlidesTableDataForModule];
    [delegate checkForModuleStatusForDriver];
    
    slidesCount = 0;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *subFoldersPath = [NSHomeDirectory() stringByAppendingString:@"/Library/"]; 
    videosPath = [subFoldersPath stringByAppendingPathComponent:@"Videos/"];
    audiosPath = [subFoldersPath stringByAppendingPathComponent:@"Audios/"];
    imagesPath = [subFoldersPath stringByAppendingPathComponent:@"Images/"];
    
    
    // For video, audio & images content demo purpose only
    //resourcePath = [[NSBundle mainBundle] resourcePath];
    
    
    topHeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 124)];
    [topHeaderImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TopBanner.png",delegate.resourceFolderPath]]];
    [self.view addSubview:topHeaderImageView];
    topHeaderImageView.userInteractionEnabled = YES;
    
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(100, 92, 116, 29);
    [backButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/BackButton.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/BackButton_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(moveBackToPreviousView) forControlEvents:UIControlEventTouchUpInside];
    [topHeaderImageView addSubview:backButton];
    
    /*
    nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(800, 92, 116, 29);
    [nextButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/NextButton.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [nextButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/NextButton_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    [nextButton addTarget:self action:@selector(moveToMenuViewController) forControlEvents:UIControlEventTouchUpInside];
    [topHeaderImageView addSubview:nextButton];
    */
    
    loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(350, 80, 300, 50)];
    loginLabel.backgroundColor = [UIColor clearColor];
    loginLabel.textAlignment = UITextAlignmentCenter;
    loginLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
    loginLabel.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
    loginLabel.text = [NSString stringWithFormat:@"MODULE %d",delegate.MODULEID];
    [self.view addSubview:loginLabel];
    
    
    bodyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 124, 1024, 644)];
    [bodyImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Body.png",delegate.resourceFolderPath]]];
    [self.view addSubview:bodyImageView];
    bodyImageView.userInteractionEnabled = YES;
    
    
    welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 135, 720, 50)];
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.text = [NSString stringWithFormat:@"%@",[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+4]];
    [self.view addSubview:welcomeLabel];
    
    
    
    usermanualButton = [UIButton buttonWithType:UIButtonTypeCustom];
    usermanualButton.frame = CGRectMake(200, 615, 119, 16);
    [usermanualButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/UserManual.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [usermanualButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/UserManual_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    [usermanualButton addTarget:self action:@selector(moveToManualViewController) forControlEvents:UIControlEventTouchUpInside];
    [bodyImageView addSubview:usermanualButton];
    
    majorcomponentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    majorcomponentButton.frame = CGRectMake(700, 615, 193, 16);
    [majorcomponentButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/MajorComponents2.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    [majorcomponentButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/MajorComponents2_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
    [majorcomponentButton addTarget:self action:@selector(moveToMajorComponentsViewController) forControlEvents:UIControlEventTouchUpInside];
    [bodyImageView addSubview:majorcomponentButton];
        
    [self performSelectorOnMainThread:@selector(createWebView) withObject:nil waitUntilDone:NO];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [moviePlayer1 stopLoading];
    [moviePlayer2 stopLoading];
    [moviePlayer3 stopLoading];
 
    [moviePlayer1 loadRequest:nil];
}

- (void) viewWillAppear:(BOOL)animated {
    
    if (delegate.ISCOMINGBACKFROMQUESTIONAIREVIEW) {
        
        takeTestButton.hidden = YES;
        reviewModuleButton.hidden = YES;
        forwardButton.hidden = NO;
        
        
        delegate.ISCOMINGBACKFROMQUESTIONAIREVIEW = NO;
        //delegate.MODULESLIDESCOUNT = [delegate retrieveTotalModuleSlidesCount];
        [delegate.MODULESDATAARRAY removeAllObjects];
        //[delegate retrieveSlidesTableDataForModule];
        [delegate checkForModuleStatusForDriver];
        
        slidesCount = 0;
        
        
        if (delegate.MODULESDATAARRAY.count/8 != 0) {
            
            welcomeLabel.text = [NSString stringWithFormat:@"%@",[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+4]];
            loginLabel.text = [NSString stringWithFormat:@"MODULE %d",delegate.MODULEID];
            
            NSString *str = [[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)] stringByDecodingHTMLEntities];
            [contentWebView loadHTMLString:str baseURL:[NSURL URLWithString:@"http://website.com"]];
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TA"]) {
                
                elementImageView1.hidden = YES;
                
                moviePlayer1.hidden = YES;
                playerOverlayButton1.hidden = YES;
                
                if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                    audioProgressBar1.hidden = YES;
                    audioPlayerButton1.hidden = YES;
                }
                else {
                    audioProgressBar1.hidden = NO;
                    audioPlayerButton1.hidden = NO;
                    
                    audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]] error:nil];
                    audioPlayer1.delegate = self;
                    [audioPlayer1 prepareToPlay];
                }
            }
            
            
            else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TV"]) {
                
                elementImageView1.hidden = YES;
                
                audioProgressBar1.hidden = YES;
                audioPlayerButton1.hidden = YES;
                
                if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                    moviePlayer1.hidden = YES;
                    playerOverlayButton1.hidden = YES;
                }
                else {
                    moviePlayer1.hidden = NO;
                    playerOverlayButton1.hidden = NO;
                    
                    
                    // iframe
                    NSString *url = [delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1];
                    NSString* embedHTML = [NSString stringWithFormat:@"\
                                           <iframe width=\"230\" height=\"120\" src=\"%@\" frameborder=\"1\" allowfullscreen></iframe>\
                                           ",url];
                    
                    NSLog(@"embeded url %@",embedHTML);
                    
                    NSString* html = [NSString stringWithFormat:embedHTML, url, 230, 120];
                    
                    [moviePlayer1 loadHTMLString:html baseURL:nil];
                    
                    //[moviePlayer1 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]]];
                }
            }
            
            else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+5] isEqualToString:@"TI"]) {
                
                moviePlayer1.hidden = YES;
                playerOverlayButton1.hidden = YES;
                
                audioProgressBar1.hidden = YES;
                audioPlayerButton1.hidden = YES;
                
                if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1] isEqualToString:@"NA"]) {
                    elementImageView1.hidden = YES;
                }
                else {
                    elementImageView1.hidden = NO;
                    elementImageView1.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+1]]];
                }
            }
            else {
                
                elementImageView1.hidden = YES;
                
                audioProgressBar1.hidden = YES;
                audioPlayerButton1.hidden = YES;
                
                moviePlayer1.hidden = YES;
                playerOverlayButton1.hidden = YES;
                
            }
            
            
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TA"]) {
                
                elementImageView2.hidden = YES;
                
                moviePlayer2.hidden = YES;
                playerOverlayButton2.hidden = YES;
                
                if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                    audioProgressBar2.hidden = YES;
                    audioPlayerButton2.hidden = YES;
                }
                else {
                    audioProgressBar2.hidden = NO;
                    audioPlayerButton2.hidden = NO;
                    
                    audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]] error:nil];
                    audioPlayer2.delegate = self;
                    [audioPlayer2 prepareToPlay];
                }
            }
            else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TV"]) {
                
                elementImageView2.hidden = YES;
                
                audioProgressBar2.hidden = YES;
                audioPlayerButton2.hidden = YES;
                
                if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                    moviePlayer2.hidden = YES;
                    playerOverlayButton2.hidden = YES;
                }
                else {
                    moviePlayer2.hidden = NO;
                    playerOverlayButton2.hidden = NO;
                    
                    //[moviePlayer2 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]]];
                }
            }
            else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+6] isEqualToString:@"TI"]) {
                
                moviePlayer2.hidden = YES;
                playerOverlayButton2.hidden = YES;
                
                audioProgressBar2.hidden = YES;
                audioPlayerButton2.hidden = YES;
                
                if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2] isEqualToString:@"NA"]) {
                    elementImageView2.hidden = YES;
                }
                else {
                    elementImageView2.hidden = NO;
                    elementImageView2.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+2]]];
                }
            }
            else {
                
                elementImageView2.hidden = YES;
                
                audioProgressBar2.hidden = YES;
                audioPlayerButton2.hidden = YES;
                
                moviePlayer2.hidden = YES;
                playerOverlayButton2.hidden = YES;
                
            }
            
            
            
            if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TA"]) {
                
                elementImageView3.hidden = YES;
                
                moviePlayer3.hidden = YES;
                playerOverlayButton3.hidden = YES;
                
                if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                    audioProgressBar3.hidden = YES;
                    audioPlayerButton3.hidden = YES;
                }
                else {
                    audioProgressBar3.hidden = NO;
                    audioPlayerButton3.hidden = NO;
                    
                    audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForAudios,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]] error:nil];
                    audioPlayer3.delegate = self;
                    [audioPlayer3 prepareToPlay];
                }
            }
            else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TV"]) {
                
                elementImageView3.hidden = YES;
                
                audioProgressBar3.hidden = YES;
                audioPlayerButton3.hidden = YES;
                
                if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                    moviePlayer3.hidden = YES;
                    playerOverlayButton3.hidden = YES;
                }
                else {
                    moviePlayer3.hidden = NO;
                    playerOverlayButton3.hidden = NO;
                    
                    //[moviePlayer3 setContentURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",resourcePath,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]]];
                }
            }
            else if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+7] isEqualToString:@"TI"]) {
                
                moviePlayer3.hidden = YES;
                playerOverlayButton3.hidden = YES;
                
                audioProgressBar3.hidden = YES;
                audioPlayerButton3.hidden = YES;
                
                if ([[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3] isEqualToString:@"NA"]) {
                    elementImageView3.hidden = YES;
                }
                else {
                    elementImageView3.hidden = NO;
                    elementImageView3.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",delegate.documentDirectoryPathForImages,[delegate.MODULESDATAARRAY objectAtIndex:(slidesCount*8)+3]]];
                }
            }
            else {
                
                elementImageView3.hidden = YES;
                
                audioProgressBar3.hidden = YES;
                audioPlayerButton3.hidden = YES;
                
                moviePlayer3.hidden = YES;
                playerOverlayButton3.hidden = YES;
                
            }

        }
        
        else {
            
            /*
            forwardButton.hidden = YES;
            [contentWebView loadHTMLString:nil baseURL:nil];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"No slides are available for the module" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
            */
            
            TestResultViewController *obj = [[TestResultViewController alloc] init];
            [self.navigationController pushViewController:obj animated:YES];
        }
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

//******************************************************* Method For Hiding Status Bar ***********************************************************//

- (BOOL) prefersStatusBarHidden {
    
    return YES;
}

@end

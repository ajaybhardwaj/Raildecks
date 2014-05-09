//
//  QuestionaireViewController.m
//  iTrainer
//
//  Created by Ajay Bhardwaj on 13/07/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import "QuestionaireViewController.h"

@interface QuestionaireViewController ()

@end

@implementation QuestionaireViewController

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
    
    MajorComponentsViewController *obj = [[MajorComponentsViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
}



//********************************************* Method To Move To Manual View COntroller **************************************************//

- (void) moveToManualViewController {
    
    ManualViewController *obj = [[ManualViewController alloc] init];
    [self.navigationController pushViewController:obj animated:YES];
}


//*********************************************** For Moving Back To Previous View ********************************************************//

- (void) moveBackToPreviousView {
    
    [self.navigationController popViewControllerAnimated:YES];
}



/*-------------------------- For Handling Options Radio Buttons ----------------------*/

- (void) handleOptionRadiobuttons:(id) sender {
    
    isOptionSelected = YES;
    
    UIButton *button = (id) sender;
    
    if (button.tag==1) {
        selectedAnswerValue = @"1";
        [radioButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio2.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton4 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton5 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    }
    else if (button.tag==2) {
        selectedAnswerValue = @"2";
        [radioButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio2.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton4 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton5 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    }
    else if (button.tag==3) {
        selectedAnswerValue = @"3";
        [radioButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio2.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton4 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton5 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    }
    else if (button.tag==4) {
        selectedAnswerValue = @"4";
        [radioButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton4 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio2.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton5 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    }
    else if (button.tag==5) {
        selectedAnswerValue = @"5";
        [radioButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton4 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [radioButton5 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio2.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
    }
    
}



/*---------------------- For Generating Random Number For Questions -----------------------*/

- (void) generateRandomNumber {
    
    forwardButton.userInteractionEnabled = NO;
    radioButton1.userInteractionEnabled = NO;
    radioButton2.userInteractionEnabled = NO;
    radioButton3.userInteractionEnabled = NO;
    radioButton4.userInteractionEnabled = NO;
    radioButton5.userInteractionEnabled = NO;
    randomQuestionNumber = arc4random() % delegate.QUESTIONSSLIDESCOUNT;
    NSLog(@"%d",randomQuestionNumber);
    [self moveToNextQuestionOrModule];
}



/*---------------------- For Checking Answers IS Correct Or Not ---------------------------*/

- (void) checkSelectedAnswerCorrectness {
    
    questionsAttemptedCount = questionsAttemptedCount + 1.0;
    
    if ([answerValue isEqualToString:selectedAnswerValue]) {
        correctAnswerCount = correctAnswerCount + 1.0;
    }
    
    [self generateRandomNumber];
    
}



/*---------------------- For Moving To Next Question Or Next Module -----------------------*/

- (void) moveToNextQuestionOrModule {
    
    isFindNewRandomNumber = NO;
    
    if (isOptionSelected) {
        
        if (questionsSlideCount==delegate.QUESTIONSSLIDESCOUNT-1) {
            
            //NSLog(@"total questions attempted %f",questionsAttemptedCount);
            //NSLog(@"total correct answers %f",correctAnswerCount);
            //NSLog(@"Questions Over");
            
            
            float scorePercentage = correctAnswerCount/questionsAttemptedCount;
            scorePercentage = scorePercentage * 100;
            //delegate.SCOREPERCENTAGESTRING = [NSString stringWithFormat:@"%.1f%%",scorePercentage];
            delegate.SCOREPERCENTAGESTRING = [NSString stringWithFormat:@"%.1f",scorePercentage];
            //NSLog(@"%@",delegate.SCOREPERCENTAGESTRING);
            if (scorePercentage>=75) {
                delegate.ISCOMPLETEDVALUE = 1;
                [delegate addDriverStatusForModule];
            }
            else {
                delegate.ISCOMPLETEDVALUE = 0;
                [delegate addDriverStatusForModule];
            }
            
            // For temporary purpose only, moving directly to result screen after 2nd module
            
            if (delegate.MODULEID==delegate.MODULESCOUNT) {
                
                TestResultViewController *obj = [[TestResultViewController alloc] init];
                [self.navigationController pushViewController:obj animated:YES];
            }
            else {
                delegate.ISCOMINGBACKFROMQUESTIONAIREVIEW = YES;
                delegate.MODULEID = delegate.MODULEID + 1;
                [delegate.QUESTIONSARRAY removeAllObjects];
                [questionsIdArray removeAllObjects];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
        else {
            
            NSString *randomString = [NSString stringWithFormat:@"%d",randomQuestionNumber];
            
            for (int i =0; i<questionsIdArray.count; i++) {
                
                if ([randomString isEqualToString:[questionsIdArray objectAtIndex:i]]) {
                    [loadingIndicator startAnimating];
                    //[self performSelector:@selector(generateRandomNumber) withObject:nil afterDelay:1.0];
                    [self performSelectorInBackground:@selector(generateRandomNumber) withObject:nil];
                    return;
                }
            }
            
            [loadingIndicator stopAnimating];
            
            forwardButton.userInteractionEnabled = YES;
            radioButton1.userInteractionEnabled = YES;
            radioButton2.userInteractionEnabled = YES;
            radioButton3.userInteractionEnabled = YES;
            radioButton4.userInteractionEnabled = YES;
            radioButton5.userInteractionEnabled = YES;
            
            isOptionSelected = NO;
            questionsSlideCount = questionsSlideCount + 1;
            [questionsIdArray addObject:randomString];
            headingLabel.text = [NSString stringWithFormat:@"QUESTION %d:",questionsSlideCount+1];
            
            int questionLength = [[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)] length];
            questionLabel.frame = CGRectMake(10, 110, 780, questionLength*1.2);
            questionLabel.text = [delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)];
            [questionLabel sizeToFit];
            
            answerValue = [NSString stringWithFormat:@"%@",[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+6]];
            
            radioButton1.frame = CGRectMake(20, questionLabel.frame.origin.y + questionLabel.bounds.size.height + 20, 40, 40);
            [radioButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
            int option1Length = [[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+1] length];
            if (option1Length<30) {
                radioLabel1.frame = CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + 25, 700, 30);
            }
            else {
                radioLabel1.frame = CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + 25, 700, option1Length*1.2);
            }
            radioLabel1.text = [delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+1];
            [radioLabel1 sizeToFit];
            
            radioButton2.frame = CGRectMake(20, questionLabel.frame.origin.y + questionLabel.bounds.size.height + 35 + radioLabel1.bounds.size.height, 40, 40);
            [radioButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
            int option2Length = [[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+2] length];
            if (option2Length<30) {
                radioLabel2.frame = CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height + 40, 700, 30);
            }
            else {
                radioLabel2.frame = CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height+ 40, 700, option2Length*1.2);
            }
            radioLabel2.text = [delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+2];
            [radioLabel2 sizeToFit];
            
            radioButton3.frame = CGRectMake(20, questionLabel.frame.origin.y + questionLabel.bounds.size.height + 50 + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height, 40, 40);
            [radioButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
            int option3Length = [[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+3] length];
            if (option3Length<30) {
                radioLabel3.frame = CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + 55, 700, 30);
            }
            else {
                radioLabel3.frame = CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + 55, 700, option3Length*1.2);
            }
            radioLabel3.text = [delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+3];
            [radioLabel3 sizeToFit];
            
            radioButton4.frame = CGRectMake(20, questionLabel.frame.origin.y + questionLabel.bounds.size.height + 65 + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + radioLabel3.bounds.size.height, 40, 40);
            [radioButton4 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
            int option4Length = [[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+4] length];
            if (option4Length<30) {
                radioLabel4.frame = CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + radioLabel3.bounds.size.height + 70, 700, 30);
            }
            else {
                radioLabel4.frame = CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + radioLabel3.bounds.size.height + 70, 700, option4Length*1.2);
            }
            radioLabel4.text = [delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+4];
            [radioLabel4 sizeToFit];
            
            radioButton5.frame = CGRectMake(20, questionLabel.frame.origin.y + questionLabel.bounds.size.height + 80 + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + radioLabel3.bounds.size.height + radioLabel4.bounds.size.height, 40, 40);
            [radioButton5 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
            int option5Length = [[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+5] length];
            if (option5Length<30) {
                radioLabel5.frame = CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + radioLabel3.bounds.size.height + radioLabel4.bounds.size.height + 85, 700, 30);
            }
            else {
                radioLabel5.frame = CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + radioLabel3.bounds.size.height + radioLabel4.bounds.size.height + 85, 700, option5Length*1.2);
            }
            radioLabel5.text = [delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+5];
            [radioLabel5 sizeToFit];
            
            
            
            
            if ([[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+3] isEqualToString:@"NA"]) {
                radioButton3.hidden = YES;
                radioLabel3.hidden = YES;
            }
            else {
                radioButton3.hidden = NO;
                radioLabel3.hidden = NO;
            }
            
            if ([[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+4] isEqualToString:@"NA"]) {
                radioButton4.hidden = YES;
                radioLabel4.hidden = YES;
            }
            else {
                radioButton4.hidden = NO;
                radioLabel4.hidden = NO;
            }
            
            if ([[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+5] isEqualToString:@"NA"]) {
                radioButton5.hidden = YES;
                radioLabel5.hidden = YES;
            }
            else {
                radioButton5.hidden = NO;
                radioLabel5.hidden = NO;
            }
            
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"You have to answer the current question to move for next one" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
        forwardButton.userInteractionEnabled = YES;
        radioButton1.userInteractionEnabled = YES;
        radioButton2.userInteractionEnabled = YES;
        radioButton3.userInteractionEnabled = YES;
        radioButton4.userInteractionEnabled = YES;
        radioButton5.userInteractionEnabled = YES;
    }
}



# pragma mark - View Lifecycle Methods

- (void)viewDidLoad
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;    
    delegate = (iTrainerAppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.QUESTIONSSLIDESCOUNT = [delegate retrieveTotalQuestionSlidesCount];
    
    loadingIndicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(500,400,45,45)];
	loadingIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
	[self.view addSubview:loadingIndicator];
    
    questionsAttemptedCount = 0;
    correctAnswerCount = 0;
    
    questionsIdArray = [[NSMutableArray alloc] init];
    
    questionsSlideCount = 0;
    [delegate retrieveQuestionSlidesDataForModule];
    
    
    
    
    topHeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 124)];
    [topHeaderImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/TopBanner.png",delegate.resourceFolderPath]]];
    [self.view addSubview:topHeaderImageView];
    topHeaderImageView.userInteractionEnabled = YES;
    
    /*
     backButton = [UIButton buttonWithType:UIButtonTypeCustom];
     backButton.frame = CGRectMake(100, 92, 116, 29);
     [backButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/BackButton.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
     [backButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/BackButton_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
     [backButton addTarget:self action:@selector(moveBackToPreviousView) forControlEvents:UIControlEventTouchUpInside];
     [topHeaderImageView addSubview:backButton];
     
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
    welcomeLabel.text = @"Questions";
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
    
    
    
    
    contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 120, 850, 400)];
    contentImageView.userInteractionEnabled = YES;
    [bodyImageView addSubview:contentImageView];
    
    contentBackgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 800, 400)];
    contentBackgroundScrollView.backgroundColor = [UIColor clearColor];
    contentBackgroundScrollView.contentSize = CGSizeMake(800, 950);
    contentBackgroundScrollView.showsVerticalScrollIndicator = YES;
    contentBackgroundScrollView.showsHorizontalScrollIndicator = NO;
    [contentImageView addSubview:contentBackgroundScrollView];
    contentBackgroundScrollView.backgroundColor = [UIColor clearColor];
    contentBackgroundScrollView.userInteractionEnabled = YES;
    
    if (delegate.QUESTIONSARRAY.count/9 != 0) {
        
        questionsAttemptedCount = 0.0;
        correctAnswerCount = 0.0;
        
        bulletImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 26, 26)];
        bulletImageView.backgroundColor = [UIColor colorWithPatternImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/BulletPoint.png",delegate.resourceFolderPath]]];
        [contentBackgroundScrollView addSubview:bulletImageView];
        
        headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 560, 30)];
        headingLabel.text = [NSString stringWithFormat:@"QUESTION %d:",questionsSlideCount+1];
        headingLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30];
        headingLabel.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
        headingLabel.backgroundColor = [UIColor clearColor];
        [contentBackgroundScrollView addSubview:headingLabel];
        
        
        randomQuestionNumber = arc4random() % delegate.QUESTIONSARRAY.count/9;
        NSString *numberString = [NSString stringWithFormat:@"%d",randomQuestionNumber];
        [questionsIdArray addObject:numberString];
        
        answerValue = [NSString stringWithFormat:@"%@",[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+6]];
        
        int questionLength = [[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)] length];
        questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 780, questionLength*1.2)];
        questionLabel.text = [delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)];
        questionLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
        questionLabel.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
        questionLabel.backgroundColor = [UIColor clearColor];
        questionLabel.textAlignment = UITextAlignmentLeft;
        questionLabel.numberOfLines = 0;
        [questionLabel sizeToFit];
        [contentBackgroundScrollView addSubview:questionLabel];
        
        
        radioButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        radioButton1.frame = CGRectMake(20, questionLabel.frame.origin.y + questionLabel.bounds.size.height + 20, 40, 40);
        [radioButton1 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        radioButton1.tag = 1;
        [radioButton1 addTarget:self action:@selector(handleOptionRadiobuttons:) forControlEvents:UIControlEventTouchUpInside];
        [contentBackgroundScrollView addSubview:radioButton1];
        
        int option1Length = [[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+1] length];
        if (option1Length<30) {
            radioLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + 25, 700, 30)];
        }
        else {
            radioLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + 25, 700, option1Length*1.2)];
        }
        radioLabel1.text = [delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+1];
        radioLabel1.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
        radioLabel1.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
        radioLabel1.backgroundColor = [UIColor clearColor];
        radioLabel1.textAlignment = UITextAlignmentLeft;
        radioLabel1.numberOfLines = 0;
        [radioLabel1 sizeToFit];
        [contentBackgroundScrollView addSubview:radioLabel1];
        
        
        radioButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        radioButton2.frame = CGRectMake(20, questionLabel.frame.origin.y + questionLabel.bounds.size.height + 35 + radioLabel1.bounds.size.height, 40, 40);
        [radioButton2 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        radioButton2.tag = 2;
        [radioButton2 addTarget:self action:@selector(handleOptionRadiobuttons:) forControlEvents:UIControlEventTouchUpInside];
        [contentBackgroundScrollView addSubview:radioButton2];
        
        
        int option2Length = [[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+2] length];
        if (option2Length<30) {
            radioLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height + 40, 700, 30)];
        }
        else {
            radioLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height+ 40, 700, option2Length*1.2)];
        }
        radioLabel2.text = [delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+2];
        radioLabel2.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
        radioLabel2.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
        radioLabel2.backgroundColor = [UIColor clearColor];
        radioLabel2.textAlignment = UITextAlignmentLeft;
        radioLabel2.numberOfLines = 0;
        [radioLabel2 sizeToFit];
        [contentBackgroundScrollView addSubview:radioLabel2];
        
        
        
        radioButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
        radioButton3.frame = CGRectMake(20, questionLabel.frame.origin.y + questionLabel.bounds.size.height + 50 + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height, 40, 40);
        [radioButton3 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        radioButton3.tag = 3;
        [radioButton3 addTarget:self action:@selector(handleOptionRadiobuttons:) forControlEvents:UIControlEventTouchUpInside];
        [contentBackgroundScrollView addSubview:radioButton3];
        
        
        int option3Length = [[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+3] length];
        if (option3Length<30) {
            radioLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + 55, 700, 30)];
        }
        else {
            radioLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + 55, 700, option3Length*1.2)];
        }
        radioLabel3.text = [delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+3];
        radioLabel3.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
        radioLabel3.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
        radioLabel3.backgroundColor = [UIColor clearColor];
        radioLabel3.textAlignment = UITextAlignmentLeft;
        radioLabel3.numberOfLines = 0;
        [radioLabel3 sizeToFit];
        [contentBackgroundScrollView addSubview:radioLabel3];
        if ([[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+3] isEqualToString:@"NA"]) {
            radioButton3.hidden = YES;
            radioLabel3.hidden = YES;
        }
        
        
        radioButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
        radioButton4.frame = CGRectMake(20, questionLabel.frame.origin.y + questionLabel.bounds.size.height + 65 + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + radioLabel3.bounds.size.height, 40, 40);
        [radioButton4 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        radioButton4.tag = 4;
        [radioButton4 addTarget:self action:@selector(handleOptionRadiobuttons:) forControlEvents:UIControlEventTouchUpInside];
        [contentBackgroundScrollView addSubview:radioButton4];
        
        
        int option4Length = [[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+4] length];
        if (option4Length<30) {
            radioLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + radioLabel3.bounds.size.height + 70, 700, 30)];
        }
        else {
            radioLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + radioLabel3.bounds.size.height + 70, 700, option4Length*1.2)];
        }
        radioLabel4.text = [delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+4];
        radioLabel4.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
        radioLabel4.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
        radioLabel4.backgroundColor = [UIColor clearColor];
        radioLabel4.textAlignment = UITextAlignmentLeft;
        radioLabel4.numberOfLines = 0;
        [radioLabel4 sizeToFit];
        [contentBackgroundScrollView addSubview:radioLabel4];
        if ([[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+4] isEqualToString:@"NA"]) {
            radioButton4.hidden = YES;
            radioLabel4.hidden = YES;
        }
        
        
        radioButton5 = [UIButton buttonWithType:UIButtonTypeCustom];
        radioButton5.frame = CGRectMake(20, questionLabel.frame.origin.y + questionLabel.bounds.size.height + 80 + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + radioLabel3.bounds.size.height + radioLabel4.bounds.size.height, 40, 40);
        [radioButton5 setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/radio1.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        radioButton5.tag = 5;
        [radioButton5 addTarget:self action:@selector(handleOptionRadiobuttons:) forControlEvents:UIControlEventTouchUpInside];
        [contentBackgroundScrollView addSubview:radioButton5];
        
        
        int option5Length = [[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+5] length];
        if (option5Length<30) {
            radioLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + radioLabel3.bounds.size.height + radioLabel4.bounds.size.height + 85, 700, 30)];
        }
        else {
            radioLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(70, questionLabel.frame.origin.y + questionLabel.bounds.size.height + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + radioLabel3.bounds.size.height + radioLabel4.bounds.size.height + 85, 700, option5Length*1.2)];
        }
        radioLabel5.text = [delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+5];
        radioLabel5.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:25];
        radioLabel5.textColor = [UIColor colorWithRed:7.0/256.0 green:64.0/256.0 blue:165.0/256.0 alpha:1.0];
        radioLabel5.backgroundColor = [UIColor clearColor];
        radioLabel5.textAlignment = UITextAlignmentLeft;
        radioLabel5.numberOfLines = 0;
        [radioLabel5 sizeToFit];
        [contentBackgroundScrollView addSubview:radioLabel5];
        if ([[delegate.QUESTIONSARRAY objectAtIndex:(randomQuestionNumber*9)+5] isEqualToString:@"NA"]) {
            radioButton5.hidden = YES;
            radioLabel5.hidden = YES;
        }
        
        
        
        contentBackgroundScrollView.contentSize = CGSizeMake(560, 30 + headingLabel.bounds.size.height + 30 + questionLabel.bounds.size.height + 20 + radioLabel1.bounds.size.height + radioLabel2.bounds.size.height + radioLabel3.bounds.size.height + radioLabel4.bounds.size.height + radioLabel5.bounds.size.height + 100);
        
        
        
        
        forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        forwardButton.frame = CGRectMake(760, 660, 130, 50);
        [forwardButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/NextAarrows.png",delegate.resourceFolderPath]] forState:UIControlStateNormal];
        [forwardButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/NextAarrows_Rollover.png",delegate.resourceFolderPath]] forState:UIControlStateHighlighted];
        [forwardButton addTarget:self action:@selector(checkSelectedAnswerCorrectness) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:forwardButton];
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"No questions available for module." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

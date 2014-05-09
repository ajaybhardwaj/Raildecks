//
//  iTrainerAppDelegate.h
//  iTrainer
//
//  Created by Ajay Bhardwaj on 01/07/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//
// database
// navc
// PREMODULEARRAY
// 

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class iTrainerViewController;

@interface iTrainerAppDelegate : UIResponder <UIApplicationDelegate> {
    
    sqlite3 *database;
    UINavigationController *navc;
    
    NSMutableArray *PREMODULEARRAY,*MODULESDATAARRAY,*QUESTIONSARRAY,*TESTRESULTARRAY,*DRIVERSDETAILSARRAY,*SELECTEDDRIVERTESTRESULTARRAY;
    int PREMODULESLIDESCOUNT,MODULESLIDESCOUNT,QUESTIONSSLIDESCOUNT;
    int MODULEID,DRIVERID,ISCOMPLETEDVALUE;
    
    NSString *SCOREPERCENTAGESTRING;
    
    BOOL ISCOMINGBACKFROMQUESTIONAIREVIEW;
    
    NSString *TRAINERUSERNAME,*TRAINERID,*TRAINERPASSWORD;
    
    NSString *DRIVERNAME,*DRIVERCOMPANY,*DRIVERCITY,*DRIVERPROVIANCE,*DRIVEREMAIL,*DRIVERMOBILE;
    NSInteger MODULESCOUNT,DRIVERNUMBEROFRECORDS;
    
    NSString *resourceFolderPath,*documentDirectoryPathForImages,*documentDirectoryPathForAudios;
    
    NSMutableArray *premoduleSyncArray,*slidesSyncArray,*questionaireSyncArray,*imagesSyncArray,*audioSyncArray;
    
    NSString *isSyncingPreModule,*isSyncingQuestionaire,*isSyncingSlides,*isSyncingImages,*isSyncingAudio;
    BOOL isCheckingLastUpdate;
    
    int SERVERMODULECOUNT;
    
    NSString *ISSERVERIMAGESUPDATED,*ISSERVERSLIDESUPDATED,*ISSERVERQUIZUPDATED,*ISSERVERPREMODULEUPDATED,*ISSERVERAUDIOUPDATED;
    
    BOOL ISCOMINGBACKFROMATTEMPTEDDRIVERSSCOREVIEW;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) iTrainerViewController *viewController;

@property (nonatomic, retain) NSMutableArray *PREMODULEARRAY,*MODULESDATAARRAY,*QUESTIONSARRAY,*TESTRESULTARRAY,*DRIVERSDETAILSARRAY,*SELECTEDDRIVERTESTRESULTARRAY;
@property (nonatomic, assign) int PREMODULESLIDESCOUNT,MODULESLIDESCOUNT,QUESTIONSSLIDESCOUNT;
@property (nonatomic, assign) int MODULEID,DRIVERID,ISCOMPLETEDVALUE;
@property (nonatomic, assign) BOOL ISCOMINGBACKFROMQUESTIONAIREVIEW,isCheckingLastUpdate,ISCOMINGBACKFROMATTEMPTEDDRIVERSSCOREVIEW;
@property (nonatomic, retain) NSString *SCOREPERCENTAGESTRING;
@property (nonatomic, retain) NSString *TRAINERUSERNAME,*TRAINERID,*TRAINERPASSWORD;
@property (nonatomic, retain) NSString *DRIVERNAME,*DRIVERCOMPANY,*DRIVERCITY,*DRIVERPROVIANCE,*DRIVEREMAIL,*DRIVERMOBILE;
@property (nonatomic, assign) NSInteger MODULESCOUNT,DRIVERNUMBEROFRECORDS;
@property (nonatomic, retain) NSString *resourceFolderPath,*documentDirectoryPathForImages,*documentDirectoryPathForAudios;
@property (nonatomic, retain) NSMutableArray *premoduleSyncArray,*slidesSyncArray,*questionaireSyncArray,*imagesSyncArray,*audioSyncArray;
@property (nonatomic, retain) NSString *isSyncingPreModule,*isSyncingQuestionaire,*isSyncingSlides,*isSyncingImages,*isSyncingAudio;
@property (nonatomic, retain) NSString *LASTUPDATEDSERVERVERSION,*LASTUPDATEDLOCALVERSION;
@property (nonatomic, assign) int SERVERMODULECOUNT;
@property (nonatomic, retain) NSString *ISSERVERIMAGESUPDATED,*ISSERVERSLIDESUPDATED,*ISSERVERQUIZUPDATED,*ISSERVERPREMODULEUPDATED,*ISSERVERAUDIOUPDATED;


- (void) retrievePreModuleDetailsTableData;
- (int) retrieveTotalModuleSlidesCount;
- (void) retrieveSlidesTableDataForModule;
- (int) retrieveTotalQuestionSlidesCount;
- (void) retrieveQuestionSlidesDataForModule;
- (void) checkForModuleStatusForDriver;
- (void) addDriverStatusForModule;
- (void) deleteAllData;
- (void) retrieveTestResultData;
- (int) getModuleStatusRepeatingModulesOption;
- (void) insertNewDriverDetails;
- (void) retrieveDriversList;
- (void) retrieveSelectedDriverTestResultData;
- (int) retrieveTotalNumberOfRecordsForDriver;
- (void) syncSlidesDataTable;
- (void) syncQuestionaireDataTable;
- (void) syncPremoduleDataTable;
- (void) syncLastUpdateTable;
- (void) syncModulesCountTable;
- (void) updateDriverScoreSyncStatus;
- (void) retrieveLastUpdateLocalDate;

@end

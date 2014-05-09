//
//  iTrainerAppDelegate.m
//  iTrainer
//
//  Created by Ajay Bhardwaj on 01/07/12.
//  Copyright (c) 2012 ajay@sabnetworks.com. All rights reserved.
//

#import "iTrainerAppDelegate.h"

#import "iTrainerViewController.h"

@implementation iTrainerAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

@synthesize PREMODULEARRAY,MODULESDATAARRAY,QUESTIONSARRAY,TESTRESULTARRAY,DRIVERSDETAILSARRAY,SELECTEDDRIVERTESTRESULTARRAY;
@synthesize PREMODULESLIDESCOUNT,MODULESLIDESCOUNT,QUESTIONSSLIDESCOUNT;
@synthesize MODULEID,DRIVERID,ISCOMPLETEDVALUE;
@synthesize ISCOMINGBACKFROMQUESTIONAIREVIEW,ISCOMINGBACKFROMATTEMPTEDDRIVERSSCOREVIEW;
@synthesize SCOREPERCENTAGESTRING;
@synthesize TRAINERUSERNAME,TRAINERID,TRAINERPASSWORD;
@synthesize DRIVERNAME,DRIVERCOMPANY,DRIVERCITY,DRIVERPROVIANCE,DRIVEREMAIL,DRIVERMOBILE;
@synthesize MODULESCOUNT,DRIVERNUMBEROFRECORDS;
@synthesize resourceFolderPath,documentDirectoryPathForImages,documentDirectoryPathForAudios;
@synthesize premoduleSyncArray,slidesSyncArray,questionaireSyncArray,imagesSyncArray,audioSyncArray;
@synthesize isSyncingPreModule,isSyncingQuestionaire,isSyncingSlides,isCheckingLastUpdate,isSyncingImages,isSyncingAudio;
@synthesize LASTUPDATEDLOCALVERSION,LASTUPDATEDSERVERVERSION;
@synthesize SERVERMODULECOUNT;
@synthesize ISSERVERIMAGESUPDATED,ISSERVERSLIDESUPDATED,ISSERVERQUIZUPDATED,ISSERVERPREMODULEUPDATED,ISSERVERAUDIOUPDATED;


#pragma mark - Methods For Sqlite Database



- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}


/*------------------ For Getting The Path For Document Directory ------------------*/

-(NSString*) getdestinationPath{
    
//    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSLog(@"%@",[NSHomeDirectory() stringByAppendingString:@"/Library/"]);
//    return [[pathsArray objectAtIndex:0] stringByAppendingPathComponent:@"iTrainer_DB.sqlite"];
    
    return [NSHomeDirectory() stringByAppendingString:@"/Library/iTrainer_DB.sqlite"];
}


-(NSString*) getdestinationPathForImagesFolder{
    
//    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    documentDirectoryPathForImages = [[pathsArray objectAtIndex:0] stringByAppendingPathComponent:@"Images"];
    
    documentDirectoryPathForImages = [NSHomeDirectory() stringByAppendingString:@"/Library/Images/"];
    
    return documentDirectoryPathForImages;
}

-(NSString*) getdestinationPathForAudioFolder{
    
//    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    documentDirectoryPathForAudios = [[pathsArray objectAtIndex:0] stringByAppendingPathComponent:@"Audios"];
    
    documentDirectoryPathForAudios = [NSHomeDirectory() stringByAppendingString:@"/Library/Audios/"];
    
    return documentDirectoryPathForImages;
}


/*--------------------- For Checking And Creating Database ------------------------*/

-(void)chkAndCreateDatbase{
    
    NSFileManager *fileManger=[NSFileManager defaultManager];
    
    NSString *destinationPath=[self getdestinationPath];
    
    if ([fileManger fileExistsAtPath:destinationPath]){
		return;
    }
    
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"iTrainer_DB" ofType:@"sqlite"];    
    
    [fileManger copyItemAtPath:sourcePath toPath:destinationPath error:nil];
}


/*----------------------------- For Opening Database ------------------------------*/

-(void)openDatabase{
    
    NSString *path=[self getdestinationPath];
    if (sqlite3_open([path UTF8String], &database)==SQLITE_OK) {
		//NSLog(@"dataBaseOpen");
    }
    else {
		sqlite3_close(database);
		//NSLog(@"dataBaseNotOpen");
    }	
}



//********************************************** Method To Sync Modules Count Table *******************************************************//

- (void) syncModulesCountTable {
    
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *updateSQL = [NSString stringWithFormat: @"UPDATE Modules_Count SET count=\"%d\"",SERVERMODULECOUNT];
        
		const char *insert_stmt = [updateSQL UTF8String];
		
		sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
		if (sqlite3_step(statement) == SQLITE_DONE)
		{
			NSLog(@"ROW UPDATED");
			
		}
		
		else {
			NSLog(@"Failed To UPDATE ROW");
		}
        
        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}





//********************************************** Method To Sync Last Update Table *********************************************************//

- (void) syncLastUpdateTable {
    
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *updateSQL = [NSString stringWithFormat: @"UPDATE lastupdate SET last_update_date=\"%@\"",LASTUPDATEDSERVERVERSION];
        
		const char *insert_stmt = [updateSQL UTF8String];
		
		sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
		if (sqlite3_step(statement) == SQLITE_DONE)
		{
			NSLog(@"ROW UPDATED");
			
		}
		
		else {
			NSLog(@"Failed To UPDATE ROW");
		}
        
        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}



//******************************************* Method To Sync Premodule Data Table *********************************************************//

- (void) syncPremoduleDataTable {
    
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *deletSQL = [NSString stringWithFormat: @"DELETE FROM PreModuleDetails"];
        
		const char *insert_stmt = [deletSQL UTF8String];
		
		sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
		if (sqlite3_step(statement) == SQLITE_DONE)
		{
			//NSLog(@"Table Deleted");
			
		}
		
		else {
			//NSLog(@"Failed To Delete Table");
		}
        
        
        for (int i=0; i<premoduleSyncArray.count/9; i++) {
            
            NSLog(@"%@",[premoduleSyncArray objectAtIndex:(i*9)]);
            NSString *contentString = [premoduleSyncArray objectAtIndex:(i*9)];//[[premoduleSyncArray objectAtIndex:(i*9)] stringByReplacingOccurrencesOfString:@"===" withString:@"<"];
            //contentString = [contentString stringByReplacingOccurrencesOfString:@"@@@" withString:@">"];
                        
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO PreModuleDetails (Content, Position, Title, Element1, Element2, Element3, Type1, Type2, Type3) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",contentString,[premoduleSyncArray objectAtIndex:(i*9)+1],[premoduleSyncArray objectAtIndex:(i*9)+2],[premoduleSyncArray objectAtIndex:(i*9)+3],[premoduleSyncArray objectAtIndex:(i*9)+4],[premoduleSyncArray objectAtIndex:(i*9)+5],[premoduleSyncArray objectAtIndex:(i*9)+6],[premoduleSyncArray objectAtIndex:(i*9)+7],[premoduleSyncArray objectAtIndex:(i*9)+8]];
            const char *insert_stmt = [insertSQL UTF8String];
            
            NSLog(@"insert premodule data ---- %@",insertSQL);
            
            sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                //NSLog(@"Row added");
            }
            
            else {
                //NSLog(@"Failed to add row");
            }
            
            //contentString = @"";
        }
        
        isSyncingPreModule = @"2";
        
        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}


//****************************************** Method To Sync Questionaire Data Table *******************************************************//

- (void) syncQuestionaireDataTable {
    
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *deletSQL = [NSString stringWithFormat: @"DELETE FROM Questionaire"];
        
		const char *insert_stmt = [deletSQL UTF8String];
		
		sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
		if (sqlite3_step(statement) == SQLITE_DONE)
		{
			//NSLog(@"Table Deleted");
			
		}
		
		else {
			//NSLog(@"Failed To Delete Table");
		}
        
        
        for (int i=0; i<questionaireSyncArray.count/10; i++) {
            
            
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO Questionaire (Question, Option1, Option2, Option3, Option4, Option5, Answer, Options_count, Module_id, id) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",[questionaireSyncArray objectAtIndex:(i*10)],[questionaireSyncArray objectAtIndex:(i*10)+1],[questionaireSyncArray objectAtIndex:(i*10)+2],[questionaireSyncArray objectAtIndex:(i*10)+3],[questionaireSyncArray objectAtIndex:(i*10)+4],[questionaireSyncArray objectAtIndex:(i*10)+5],[questionaireSyncArray objectAtIndex:(i*10)+6],[questionaireSyncArray objectAtIndex:(i*10)+7],[questionaireSyncArray objectAtIndex:(i*10)+8],[questionaireSyncArray objectAtIndex:(i*10)+9]];
            const char *insert_stmt = [insertSQL UTF8String];
            
            sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                //NSLog(@"Row added");
            }
            
            else {
                //NSLog(@"Failed to add row");
            }
            
        }
        
        isSyncingQuestionaire = @"2";

        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}


//*********************************************** Method To Sync Slides Data Table ********************************************************//

- (void) syncSlidesDataTable {
    
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *deletSQL = [NSString stringWithFormat: @"DELETE FROM Slides"];
        
		const char *insert_stmt = [deletSQL UTF8String];
		
		sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
		if (sqlite3_step(statement) == SQLITE_DONE)
		{
			//NSLog(@"Table Deleted");
			
		}
		
		else {
			//NSLog(@"Failed To Delete Table");
		}
        
        
        for (int i=0; i<slidesSyncArray.count/10; i++) {
            
            NSString *contentString = [slidesSyncArray objectAtIndex:(i*10)];//[[slidesSyncArray objectAtIndex:(i*11)] stringByReplacingOccurrencesOfString:@"===" withString:@"<"];
            //contentString = [contentString stringByReplacingOccurrencesOfString:@"@@@" withString:@">"];
            
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO Slides (Content, Module_id, Position, Element1, Element2, Element3, Title, Type1, Type2, Type3) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",contentString,[slidesSyncArray objectAtIndex:(i*10)+1],[slidesSyncArray objectAtIndex:(i*10)+2],[slidesSyncArray objectAtIndex:(i*10)+3],[slidesSyncArray objectAtIndex:(i*10)+4],[slidesSyncArray objectAtIndex:(i*10)+5],[slidesSyncArray objectAtIndex:(i*10)+6],[slidesSyncArray objectAtIndex:(i*10)+7],[slidesSyncArray objectAtIndex:(i*10)+8],[slidesSyncArray objectAtIndex:(i*10)+9]];
            const char *insert_stmt = [insertSQL UTF8String];
            
            NSLog(@"insert query is ---- %@",insertSQL);
            
            sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                //NSLog(@"Row added");
            }
            
            else {
                //NSLog(@"Failed to add row");
            }
            
            //contentString = @"";
        }
        
        isSyncingSlides = @"2";
        
        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}


/*---------------- For Counting Total Entries In PreModule Table ------------------*/


- (int) retrieveTotalPreModuleSlidesCount {
    
	int count = 0;
	
	NSString *destinationPath = [self getdestinationPath];
	
	const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
		NSString *querySQL = [NSString stringWithFormat: @"SELECT COUNT(*) FROM PreModuleDetails"];
		
		
		const char *query_stmt = [querySQL UTF8String];
		
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                
                count = sqlite3_column_int(statement, 0);
                
            }
            
		}
	}
    return count;
}





/*------------------- For Counting Total Entries For A Driver -------------------*/


- (int) retrieveTotalNumberOfRecordsForDriver {
    
	int count = 0;
	
	NSString *destinationPath = [self getdestinationPath];
	
	
	const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
		NSString *querySQL = [NSString stringWithFormat: @"SELECT COUNT(*) FROM Module_Completion WHERE driver_id=\"%d\"",DRIVERID];
		
		
		const char *query_stmt = [querySQL UTF8String];
		
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                
                count = sqlite3_column_int(statement, 0);
                
            }
            
		}
	}
    return count;
}




/*------------------ For Retrieving PreModule Slides Details --------------------*/

- (void) retrievePreModuleDetailsTableData {
    
    [PREMODULEARRAY removeAllObjects];
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM PreModuleDetails"];
        
		
		const char *query_stmt = [querySQL UTF8String];
		
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *content = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *position = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *title = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString *element1 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                NSString *element2 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                NSString *element3 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                NSString *type1 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                NSString *type2 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
                NSString *type3 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
                
                [PREMODULEARRAY addObject:content];
                [PREMODULEARRAY addObject:position];
                [PREMODULEARRAY addObject:title];
                [PREMODULEARRAY addObject:element1];
                [PREMODULEARRAY addObject:element2];
                [PREMODULEARRAY addObject:element3];
                [PREMODULEARRAY addObject:type1];
                [PREMODULEARRAY addObject:type2];
                [PREMODULEARRAY addObject:type3];
                
            }
        }
        
        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}



//*********************************************** For Retrieving Last Update Local Date ***************************************************//

- (void) retrieveLastUpdateLocalDate {
    
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM lastupdate"];
        
		
		const char *query_stmt = [querySQL UTF8String];
		
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                
                LASTUPDATEDLOCALVERSION= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
//                NSLog(@"local date string: %@",dateString);
//                NSRange range = [dateString rangeOfString:@" "];
//                NSString *newString = [dateString substringToIndex:range.location];
//                NSLog(@"local date: %@",newString);
//                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                [formatter setDateFormat:@"yyyy-MM-dd"];
//                LASTUPDATEDLOCALDATE = [formatter dateFromString:newString];
                //LASTUPDATEDLOCALDATE = [LASTUPDATEDLOCALDATE dateByAddingTimeInterval:60*60*24*1];
                //NSLog(@"local date: %@",LASTUPDATEDLOCALDATE);
            }
        }
        
        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}




/*---------------------- For Retrieving Total Modules Count ----------------------*/

- (void) retrieveTotalModulesCount {
    
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM Modules_Count"];
        
		
		const char *query_stmt = [querySQL UTF8String];
		
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *count = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                MODULESCOUNT = [count intValue];
                
                NSLog(@"Total modules available are %d",MODULESCOUNT);
            }
        }
        
        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}



/*--------------------- For Retrieving Test Resutl Details --------------------*/

- (void) retrieveTestResultData {
    
    [TESTRESULTARRAY removeAllObjects];
    TESTRESULTARRAY = [[NSMutableArray alloc] init];
    
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat: @"SELECT module_id, score, driver_id FROM Module_Completion WHERE driver_id=\"%d\"",DRIVERID];
		
		const char *query_stmt = [querySQL UTF8String];
		
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *moduleid = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *score = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                [TESTRESULTARRAY addObject:moduleid];
                [TESTRESULTARRAY addObject:score];
            }
        }
        
        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}



/*--------------- For Retrieving Selected Driver Resutl Details -----------------*/

- (void) retrieveSelectedDriverTestResultData {
    
    [SELECTEDDRIVERTESTRESULTARRAY removeAllObjects];
    SELECTEDDRIVERTESTRESULTARRAY = [[NSMutableArray alloc] init];
    
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat: @"SELECT module_id, score FROM Module_Completion WHERE driver_id=\"%d\"",DRIVERID];
		
		const char *query_stmt = [querySQL UTF8String];
		
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *moduleid = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *score = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                [SELECTEDDRIVERTESTRESULTARRAY addObject:moduleid];
                [SELECTEDDRIVERTESTRESULTARRAY addObject:score];
            }
        }
        
        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}




/*---------------- For Counting Total Slides For Specific Module -------------------*/


- (int) retrieveTotalModuleSlidesCount {
    
	int count = 0;
	
	NSString *destinationPath = [self getdestinationPath];
	
	
	const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
		NSString *querySQL = [NSString stringWithFormat: @"SELECT COUNT(*) FROM Slides WHERE Module_id=\"%d\"",MODULEID];
		
		
		const char *query_stmt = [querySQL UTF8String];
		
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                
                count = sqlite3_column_int(statement, 0);
                
            }
            
		}
	}
    return count;
}



/*---------------------- For Retrieving Module Slides Details ----------------------*/

- (void) retrieveSlidesTableDataForModule {
    
    [MODULESDATAARRAY removeAllObjects];
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Content, Element1, Element2, Element3, Title, Type1, Type2, Type3 FROM Slides WHERE Module_id=\"%d\" ORDER BY Position ASC",MODULEID];
        
		
		const char *query_stmt = [querySQL UTF8String];
		
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *content = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *element1 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *element2 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString *element3 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                NSString *title = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                NSString *type1 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                NSString *type2 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                NSString *type3 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
                
                [MODULESDATAARRAY addObject:content];
                [MODULESDATAARRAY addObject:element1];
                [MODULESDATAARRAY addObject:element2];
                [MODULESDATAARRAY addObject:element3];
                [MODULESDATAARRAY addObject:title];
                [MODULESDATAARRAY addObject:type1];
                [MODULESDATAARRAY addObject:type2];
                [MODULESDATAARRAY addObject:type3];
            }
        }
        
        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}


/*------------- For Counting Total Question Slides For Specific Module ----------------*/


- (int) retrieveTotalQuestionSlidesCount {
    
	int count = 0;
	
	NSString *destinationPath = [self getdestinationPath];
	
	
	const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
		NSString *querySQL = [NSString stringWithFormat: @"SELECT COUNT(*) FROM Questionaire WHERE Module_id=\"%d\"",MODULEID];
		
		
		const char *query_stmt = [querySQL UTF8String];
		
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                
                count = sqlite3_column_int(statement, 0);
                
            }
            
		}
	}
    return count;
}


/*---------------------- For Retrieving Module Slides Details ----------------------*/

- (void) retrieveQuestionSlidesDataForModule {
    
    [QUESTIONSARRAY removeAllObjects];
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Question, Option1, Option2, Option3, Option4, Option5, Answer, Options_count, id FROM Questionaire WHERE Module_id=\"%d\"",MODULEID];
        
		
		const char *query_stmt = [querySQL UTF8String];
		
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *question = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *option1 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *option2 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString *option3 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                NSString *option4 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                NSString *option5 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                NSString *answer = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                NSString *optioncount = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
                NSString *idValue = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
                
                [QUESTIONSARRAY addObject:question];
                [QUESTIONSARRAY addObject:option1];
                [QUESTIONSARRAY addObject:option2];
                [QUESTIONSARRAY addObject:option3];
                [QUESTIONSARRAY addObject:option4];
                [QUESTIONSARRAY addObject:option5];
                [QUESTIONSARRAY addObject:answer];
                [QUESTIONSARRAY addObject:optioncount];
                [QUESTIONSARRAY addObject:idValue];
            }
        }
        
        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}




/*---------------------- Check Driver Have Cleared The Module ----------------------*/

- (void) checkForModuleStatusForDriver {
    
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat: @"SELECT isCompleted FROM Module_Completion WHERE module_id=\"%d\" AND driver_id=\"%d\"",MODULEID,DRIVERID];
        
		
		const char *query_stmt = [querySQL UTF8String];
		
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *iscomplete = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                ISCOMPLETEDVALUE = [iscomplete intValue];
            }
        }
        
        if (ISCOMPLETEDVALUE==1) {
            ISCOMPLETEDVALUE = 0;
            MODULEID = MODULEID + 1;
            [self checkForModuleStatusForDriver];
        }
        else {
            MODULESLIDESCOUNT = [self retrieveTotalModuleSlidesCount];
            [self retrieveSlidesTableDataForModule];
        }
        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}




/*---------------- For Updating Driver Status For Specific Module ------------------*/ 

- (void) addDriverStatusForModule {
    
    
	sqlite3_stmt *statement;
	
	NSString *destinationPath = [self getdestinationPath];
	
	const char *dbpath = [destinationPath UTF8String];
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        
        NSString *searchQuery = [NSString stringWithFormat:@"SELECT COUNT(*) FROM Module_Completion WHERE driver_id=\"%d\" AND module_id=\"%d\" AND isCompleted=0",DRIVERID,MODULEID];
        int rowCount=0;
        const char *query_stmt = [searchQuery UTF8String];
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                rowCount = sqlite3_column_int(statement, 0);
            }
		}
        
        
        
        if (rowCount==1) {
            
            NSString *idValue;
            
            NSString *querySQL = [NSString stringWithFormat: @"SELECT id FROM Module_Completion WHERE module_id=\"%d\" AND driver_id=\"%d\" AND isCompleted=0",MODULEID,DRIVERID];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    idValue = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                }
            }
            
            
            
            
            NSString *updateQuery = [NSString stringWithFormat:@"UPDATE Module_Completion SET isCompleted=\"%d\", score=\"%@\" WHERE id=\"%@\"",ISCOMPLETEDVALUE,SCOREPERCENTAGESTRING,idValue];
            
            const char *insert_stmt = [updateQuery UTF8String];
            
            sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Row Updated");
            } 
            
            else {
                NSLog(@"Failed to update row");
            }
            
        }
        else {
            
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO Module_Completion (driver_id, module_id, isCompleted, score) VALUES (\"%d\", \"%d\", \"%d\", \"%@\")", DRIVERID,MODULEID,ISCOMPLETEDVALUE,SCOREPERCENTAGESTRING];
            
            NSLog(@"query %@",insertSQL);
            const char *insert_stmt = [insertSQL UTF8String];
            
            sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Row added");
            } 
            
            else {
                NSLog(@"Failed to add row");
            }
        }
        
        ISCOMPLETEDVALUE = 0;
        
		//sqlite3_finalize(statement);
		sqlite3_close(database);
	}
    
}



/*------------------- For Getting Count Of Unfinished Modules ----------------------*/

- (int) getModuleStatusRepeatingModulesOption {
    
    sqlite3_stmt *statement;
	
	NSString *destinationPath = [self getdestinationPath];
	
	const char *dbpath = [destinationPath UTF8String];
	
    int rowCount=0;
    
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        
        NSString *searchQuery = [NSString stringWithFormat:@"SELECT COUNT(*) FROM Module_Completion WHERE driver_id=\"%d\" AND isCompleted=0",DRIVERID];
        
        const char *query_stmt = [searchQuery UTF8String];
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                rowCount = sqlite3_column_int(statement, 0);
            }
		}
    }
    
    return rowCount;
}




//******************************************* Method To Update Driver Score Sync Status ***************************************************//

- (void) updateDriverScoreSyncStatus {
    
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *updateSQL = [NSString stringWithFormat: @"UPDATE Driver_Details SET isScoreSynced=\"%@\" WHERE id=\"%d\"",@"1",DRIVERID];
        
		const char *insert_stmt = [updateSQL UTF8String];
		
		sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
		if (sqlite3_step(statement) == SQLITE_DONE)
		{
			NSLog(@"ROW UPDATED");
			
		}
		
		else {
			NSLog(@"Failed To UPDATE ROW");
		}
        
        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}




/*----------------- For Inserting New Driver Info In Database ----------------------*/

- (void) insertNewDriverDetails {
    
    sqlite3_stmt *statement;
	
	NSString *destinationPath = [self getdestinationPath];
	
	const char *dbpath = [destinationPath UTF8String];
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO Driver_Details (id, name, company, city, proviance, email, mobile, trainer_id, isScoreSynced) VALUES (\"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", DRIVERID,DRIVERNAME,DRIVERCOMPANY,DRIVERCITY,DRIVERPROVIANCE,DRIVEREMAIL,DRIVERMOBILE,TRAINERID,@"0"];
        
        NSLog(@"query %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Row added");
        } 
        
        else {
            NSLog(@"Failed to add row");
        }
    }
    
}




/*-------------------- For Retrieving Drivers List From Database -------------------*/

- (void) retrieveDriversList {
    
    [DRIVERSDETAILSARRAY removeAllObjects];
    NSString *destinationPath = [self getdestinationPath];
    
    const char *dbpath = [destinationPath UTF8String];
	sqlite3_stmt    *statement;
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        NSString *querySQL = [NSString stringWithFormat: @"SELECT id, name, company, isScoreSynced FROM Driver_Details WHERE trainer_id=\"%@\"",TRAINERID];
        
		
		const char *query_stmt = [querySQL UTF8String];
		
		if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
                NSString *idValue = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *nameValue = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *companyValue = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString *scoresynced = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                
                [DRIVERSDETAILSARRAY addObject:idValue];
                [DRIVERSDETAILSARRAY addObject:nameValue];
                [DRIVERSDETAILSARRAY addObject:companyValue];
                [DRIVERSDETAILSARRAY addObject:scoresynced];
            }
        }
        
        //sqlite3_finalize(statement);
		sqlite3_close(database);
    }
    
}



/*---------------- For Creating Sub Folders In Document Directory ------------------*/ 

- (void) createSubFoldersInDocumentDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory = [paths objectAtIndex:0];  // Get Documents directory
    
    NSFileManager *manager= [NSFileManager defaultManager]; 
    
    BOOL isDirectory;
    NSString *directoryName = @"Videos/";
    NSString *subFolder = [[NSHomeDirectory() stringByAppendingString:@"/Library/"] stringByAppendingPathComponent:directoryName];
    if (![manager fileExistsAtPath:subFolder isDirectory:&isDirectory] || !isDirectory) {
        NSError *error = nil;
        NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                         forKey:NSFileProtectionKey];
        [manager createDirectoryAtPath:subFolder
           withIntermediateDirectories:YES
                            attributes:attr
                                 error:&error];
        if (error)
            NSLog(@"Error creating directory path: %@", [error localizedDescription]);
    }
    
    
    directoryName = @"Audios/";
    subFolder = [[NSHomeDirectory() stringByAppendingString:@"/Library/"] stringByAppendingPathComponent:directoryName];
    if (![manager fileExistsAtPath:subFolder isDirectory:&isDirectory] || !isDirectory) {
        NSError *error = nil;
        NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                         forKey:NSFileProtectionKey];
        [manager createDirectoryAtPath:subFolder
           withIntermediateDirectories:YES
                            attributes:attr
                                 error:&error];
        if (error)
            NSLog(@"Error creating directory path: %@", [error localizedDescription]);
    }
    
    
    directoryName = @"Images/";
    subFolder = [[NSHomeDirectory() stringByAppendingString:@"/Library/"] stringByAppendingPathComponent:directoryName];
    if (![manager fileExistsAtPath:subFolder isDirectory:&isDirectory] || !isDirectory) {
        NSError *error = nil;
        NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                         forKey:NSFileProtectionKey];
        [manager createDirectoryAtPath:subFolder
           withIntermediateDirectories:YES
                            attributes:attr
                                 error:&error];
        if (error)
            NSLog(@"Error creating directory path: %@", [error localizedDescription]);
    }
    
}


// temp method
- (void) deleteAllData {
    
    sqlite3_stmt *statement;
	
	NSString *destinationPath = [self getdestinationPath];
	
	const char *dbpath = [destinationPath UTF8String];
	
	if (sqlite3_open(dbpath, &database) == SQLITE_OK)
	{
        
		
		NSString *deleteSQL = [NSString stringWithFormat: @"DELETE FROM Module_Completion"];
        
        NSLog(@"query %@",deleteSQL);
		const char *insert_stmt = [deleteSQL UTF8String];
        
		sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
		if (sqlite3_step(statement) == SQLITE_DONE)
		{
			NSLog(@"Rows Deleted");
		} 
		
		else {
			NSLog(@"Failed to delete rows");
		}
		//sqlite3_finalize(statement);
		sqlite3_close(database);
	}

}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self getdestinationPath];
    
    [self chkAndCreateDatbase];
    //[self openDatabase];
    isCheckingLastUpdate = YES;
    resourceFolderPath = [[NSBundle mainBundle] resourcePath];
    [self getdestinationPathForImagesFolder];
    [self getdestinationPathForAudioFolder];
    [self retrieveLastUpdateLocalDate];
    
    MODULEID = 1;
    PREMODULEARRAY = [[NSMutableArray alloc] init];
    MODULESDATAARRAY = [[NSMutableArray alloc] init];
    PREMODULESLIDESCOUNT = [self retrieveTotalPreModuleSlidesCount];
    QUESTIONSARRAY = [[NSMutableArray alloc] init];
    DRIVERSDETAILSARRAY = [[NSMutableArray alloc] init];
    
    [self createSubFoldersInDocumentDirectory];
    [self retrieveTotalModulesCount];
    
    // Override point for customization after application launch.
    UIViewController *rootController = [[iTrainerViewController alloc] initWithNibName:@"iTrainerViewController" bundle:nil];
    navc = [[UINavigationController alloc] initWithRootViewController:rootController];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //[self.window addSubview:navc.view];
    if ([[UIDevice currentDevice].systemVersion floatValue] < 6.0) {
        [self.window addSubview:navc.view];
    }
    else {
        self.window.rootViewController = navc;
    }
    [self.window makeKeyAndVisible];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    [self retrieveLastUpdateLocalDate];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

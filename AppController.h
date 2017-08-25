//
//  AppController.h
//  PopularWords
//
//  Created by openuser on 11/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TableDataObject.h"

@interface AppController : NSObject 
{

	IBOutlet NSButton *clearButton;
	IBOutlet NSButton *determinePop;
	IBOutlet NSTextView *wordsInput;
	IBOutlet NSTextField *numberOfUniqueWords;
	IBOutlet NSTextField *totalWordCount;
	NSCountedSet *resultsSet;

	IBOutlet NSTableView *resultsTableView;
	IBOutlet NSMutableArray *tableObjectArrary;
	IBOutlet NSTabView *wordsResultsTabView;

}

@property (assign) NSTableView *resultsTableView;
@property (assign) NSMutableArray *tableObjectArrary;


-(IBAction)clear: (id) sender;

-(IBAction)trackWord: (id)sender;

-(void)updateNumberOfUniqueWords;

-(void)updateTotalWordCount;

-(void)prepareTable:(NSCountedSet *)theResultSet;

-(void)tableView:(NSTableView *)tableView sortDescriptorsDidChange:(NSArray *)oldDescriptors;

-(NSInteger)numberOfRowsInTableView:(NSTableView *) theTableView;

-(id) tableView:(NSTableView *)theTableViewObj objectValueForTableColumn:(NSTableColumn *)theTableColumn row:(int)theRowIndex;



@end

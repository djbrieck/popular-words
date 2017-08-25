//
//  AppController.m
//  PopularWords
//
//  Created by openuser on 11/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "WordsCounter.h"

@implementation AppController

@synthesize resultsTableView;
@synthesize tableObjectArrary;


-(void)awakeFromNib
{
    tableObjectArrary = [[NSMutableArray alloc] initWithCapacity: 1]; 
}

-(IBAction)clear: (id) sender
{
	NSLog(@"The clear action was called");
	//Clear the text input windows text view
	[wordsInput setString:@""];
}


-(IBAction)trackWord: (id)sender
{
	NSLog(@"Begin counting words");
	
	WordsCounter *myCounter = [[WordsCounter alloc] init];
	
	resultsSet = [myCounter countedSetWordsFromString:[wordsInput string]];

	
	//--------------------------------------------------
	// [myCounter logDetailsAboutCountedSet];
	//-------------------------------------------------- 
	
	[myCounter release];

	[self updateNumberOfUniqueWords];

	[self updateTotalWordCount];

	[self prepareTable:resultsSet];

	[wordsResultsTabView selectTabViewItemWithIdentifier:@"2"];
}

-(void)updateNumberOfUniqueWords
{
    [numberOfUniqueWords setIntegerValue:[resultsSet count]];

   NSLog(@"%i unique words found.",[resultsSet count]);
}

-(void)updateTotalWordCount
{
    //Going through the counted set using an enumerator.
    NSEnumerator *countEnumerator = [resultsSet objectEnumerator];
   
    int tempcount = 0; 
    id object;
 
    while ((object = [countEnumerator nextObject])) 
    {
	tempcount += [resultsSet countForObject:object];   
    }

    //Updating the text field to show the count
    [totalWordCount setIntegerValue:tempcount];
}




-(void)prepareTable:(NSCountedSet *)theResultSet
{
   
  if([tableObjectArrary count]>= 0)
  {
      [tableObjectArrary removeAllObjects];
  }

    
    NSLog(@"Prepare Table Called");
    NSEnumerator *myEnumerator = [theResultSet objectEnumerator];
    id object;  
   
    while(object = [myEnumerator nextObject])
    {
	//Make a new table data object
	TableDataObject *myTableDataObject = [[TableDataObject alloc] init];

	//Set the current word string
	[myTableDataObject setWordString:object];

	//Get the number of times the current word had been counted
	[myTableDataObject setCountString:[NSNumber numberWithInt:[theResultSet countForObject:object]]];

	//put it in the table array
	[tableObjectArrary addObject: myTableDataObject];
       
    }

    //TODO Remove this
    for (id object in tableObjectArrary )
    {
	NSLog(@"%@ %@", [object word], [object count]);

    }


    object = nil;
    myEnumerator = nil;


    [resultsTableView reloadData];

}

-(void)tableView:(NSTableView *)tableView sortDescriptorsDidChange:(NSArray *)oldDescriptors
{
    NSArray *newDescriptors = [tableView sortDescriptors];
    [tableObjectArrary sortUsingDescriptors:newDescriptors];
    [tableView reloadData];
}


-(NSInteger)numberOfRowsInTableView:(NSTableView *) theTableView
{
   NSLog(@"numberOfRowCalled_TController");
    return [tableObjectArrary count];
}

-(id) tableView:(NSTableView *)theTableViewObj objectValueForTableColumn:(NSTableColumn *)theTableColumn row:(int)theRowIndex
{
   
    TableDataObject *tvDataObject =  (TableDataObject *) [self.tableObjectArrary objectAtIndex: theRowIndex];

    if(!tvDataObject)
    {
	NSLog(@"tableView: objectAtIndex:%d = NULL", theRowIndex);
	return NULL;
    }

    //NSLog(@"theTableColumn identifier = %@", [theTableColumn identifier]);


    if([[theTableColumn identifier] isEqualToString:@"Word"])
    {
	return [tvDataObject word];
    }
    
        if([[theTableColumn identifier] isEqualToString:@"Repeats"])
    {
	return [tvDataObject count];
    }

    return NULL;
	
}

@end

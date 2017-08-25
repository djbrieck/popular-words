//
//  MyTableController.m
//  PopularWords
//
//  Created by Daniel J. Brieck Jr. on 6/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyTableController.h"


@implementation MyTableController

@synthesize resultsTableView; 
@synthesize tableObjectArrary; 

-(void)awakeFromNib
{
    tableObjectArrary = [[NSMutableArray alloc] initWithCapacity: 1]; 
}

-(void)prepareTable:(NSCountedSet *)theResultSet
{
   
    NSLog(@"Prepare Table Called");
    NSEnumerator *myEnumerator = [theResultSet objectEnumerator];
    id object;  
   
    while(object = [myEnumerator nextObject])
    {
	//Make a new table data object
	TableDataObject *myTableDataObject = [[TableDataObject alloc] init];

	//Get the current word string
	[myTableDataObject setWordString:object];

	//Get the number of times the current word had been counted
	[theResultSet countForObject:object];

	//put it in the table array
	[tableObjectArrary addObject: myTableDataObject];
   
    }

    object = nil;
    myEnumerator = nil;


    [resultsTableView reloadData];

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

    NSLog(@"theTableColumn identifier = %@", [theTableColumn identifier]);


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

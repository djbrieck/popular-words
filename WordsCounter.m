//
//  WordsCounter.m
//  PopularWords
//
//  Created by openuser on 11/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WordsCounter.h"

@implementation WordsCounter

-(NSCountedSet* )countedSetWordsFromString:(NSString*)inString
{

    NSString *currentString;
    NSString *strippedString;
    NSMutableArray *wordMArray = [NSMutableArray arrayWithCapacity:88];
    NSScanner *wordScanner = nil;
    NSArray *baseWordsArray;

    //Lower case the input string...
    inString = [inString lowercaseString];

    //Set up the scanner.
    wordScanner = [NSScanner scannerWithString: inString];

    //Getting rid of any leading punction marks
    [wordScanner setCharactersToBeSkipped:[NSCharacterSet punctuationCharacterSet]];


    //Do the scanning
        while([wordScanner isAtEnd] != YES)
    {

	//Scan a word and a single space or new line after it...
	if([wordScanner scanUpToCharactersFromSet:
				    [NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:&currentString] 
		&& 
	    [wordScanner scanCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]intoString:NULL] )
	{
	    
	    //NSLog(@"The current string is: %@", currentString);
	    
	    //Get rid of an trailing punctuation characters
	    strippedString = [currentString stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
	    [wordMArray addObject: strippedString];
	}
	else if ([wordScanner isAtEnd])//Make sure you save the last string in the paragraph
	{
	   
	    //NSLog(@"The current string is: %@", currentString);
	    
	    //Get rid of an trailing punctuation characters
	    strippedString = [currentString stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
	    [wordMArray addObject: strippedString]; 
	}
	else //Process out those extra spaces etc...
	{
	    [wordScanner scanCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]intoString:NULL];
	}
    }


    NSLog(@"Past the scanner, the wordMArray has %i objects", [wordMArray count]);

    //Print the cleaned up Array
//--------------------------------------------------
//     NSEnumerator *enumerator = [wordMArray objectEnumerator];
// 
//     for(NSString *element in enumerator)
//     {
// 	NSLog(@"element is: %@",element);
//     }
//-------------------------------------------------- 


   //Convert the Mutable Array to the counted set... 
    baseWordsArray = [NSArray arrayWithArray: wordMArray];
    
    wordsCountedSet = [[NSCountedSet alloc] initWithArray:baseWordsArray]; 


    NSLog(@"The counted set has %i item/s in it...", [wordsCountedSet count]);


    return wordsCountedSet;
}


-(void)logDetailsAboutCountedSet
{
    	NSLog(@"There are %d things in this counted set.", [wordsCountedSet count]);
	
	
	NSLog(@"Print the contents of the wordSet");
	
	NSEnumerator * myEnumerator = [wordsCountedSet objectEnumerator];

	id object;

	while(object = [myEnumerator nextObject])
	{
	    NSLog(@"A thing in the set: %@", object );
		
		NSLog(@"It is present %i times.", [wordsCountedSet countForObject:object]);
	}

}

@end

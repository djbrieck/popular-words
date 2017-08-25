//
//  WordsCounter.h
//  PopularWords
//
//  Created by openuser on 11/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface WordsCounter : NSObject 
{
	NSCountedSet *wordsCountedSet;

}


-(id)countedSetWordsFromString:(NSString *)inString;

-(void)logDetailsAboutCountedSet;

@end

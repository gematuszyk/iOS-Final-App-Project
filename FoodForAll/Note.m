//
//  Note.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/21/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "Note.h"

#define kAllNotes @"allthenotes"
static NSInteger currentNoteIndex = -1;
static NSMutableArray *allNotes = nil;
static UITableView *tableView;

@implementation Note

@synthesize note,time,date;

+(UITableView *)getTable {
    return tableView;
}

+ (void)setTable:(UITableView *)t {
    tableView = t;
}

+ (NSMutableArray *)getAllNotes {
    return allNotes;
}

+ (NSInteger)getCurrentNoteIndex {
    return currentNoteIndex;
}

+ (void)setCurrentNoteIndex:(NSInteger)index {
    currentNoteIndex = index;
}

+ (void)saveNotes {
  
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:allNotes];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kAllNotes];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)loadNotes {
    if(allNotes== nil) {
        allNotes = [NSMutableArray arrayWithArray:@[]];
    }
    NSData *rawData = [[NSUserDefaults standardUserDefaults]dataForKey:kAllNotes];
    if(rawData == nil ) {
        return;
    }
    NSArray *aData = [NSKeyedUnarchiver unarchiveObjectWithData:rawData];
    allNotes = [NSMutableArray arrayWithArray:aData];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        note = @"";
        time = @"";
        date = [NSDate date].description;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        note = [coder decodeObjectForKey:@"note"];
        time = [coder decodeObjectForKey:@"time"];
        date = [coder decodeObjectForKey:@"date"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.note forKey:@"note"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.date forKey:@"date"];
}


@end
//
//  Note.h
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/21/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Note : NSObject <NSCoding>


@property NSString *note;
@property NSString *time;
@property NSString *date;

+ (UITableView *)getTable;
+ (void)setTable:(UITableView *)t;
+ (void)saveNotes;
+ (void)loadNotes;
+ (NSInteger)getCurrentNoteIndex;
+ (void)setCurrentNoteIndex:(NSInteger)index;
+ (NSMutableArray *)getAllNotes;

@end

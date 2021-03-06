//
//  Card.h
//  MyMatchIsMo
//
//  Created by Dailey on 2015/2/22.
//  Copyright (c) 2015年 ClaytonDailey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;


@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)matched:(NSArray *)otherCards;

@end

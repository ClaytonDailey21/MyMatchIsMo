//
//  PlayingCard.h
//  MyMatchIsMo
//
//  Created by Dailey on 2015/2/22.
//  Copyright (c) 2015年 ClaytonDailey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSInteger rank;
@end

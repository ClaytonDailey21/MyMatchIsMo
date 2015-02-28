//
//  CardMatchingGame.h
//  MyMatchIsMo
//
//  Created by Dailey on 2015/2/23.
//  Copyright (c) 2015年 ClaytonDailey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//
// Add following public methods to your CardMatchingGame
//
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) NSInteger Score;
@end

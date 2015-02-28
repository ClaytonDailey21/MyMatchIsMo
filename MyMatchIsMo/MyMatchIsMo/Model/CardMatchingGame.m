//
//  CardMatchingGame.m
//  MyMatchIsMo
//
//  Created by Dailey on 2015/2/23.
//  Copyright (c) 2015年 ClaytonDailey. All rights reserved.
//

#import "CardMatchingGame.h"

//
// Heer we put proviate property below, and it's called "Class Extension".
//

// - Class Extension Area start
@interface CardMatchingGame ()

@property (nonatomic, readwrite) NSInteger Score;

//
// Our game needs keep track of the cards, so we need a private @property to do that
//
@property (strong,nonatomic) NSMutableArray *cards; // of Card
@end
// - Class Extension Area end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS      = 4;
static const int COST_TO_CHOOSE   = 1;

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            //
            // if the card is already chosen, we need to "unchoose" it.
            //
            card.chosen = NO;
        } else {
            //match against other chosen card.
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card matched:@[otherCard]];
                    
                    if (matchScore) {
                        self.Score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched      = YES;
                    } else {
                        self.Score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    self.Score -= COST_TO_CHOOSE;
                    break;
                }
            }
            card.chosen = YES;
        }
    }

}
@end

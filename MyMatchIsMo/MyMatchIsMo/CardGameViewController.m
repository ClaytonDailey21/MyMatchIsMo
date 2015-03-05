//
//  CardGameViewController.m
//  MyMatchIsMo
//
//  Created by Dailey on 2015/2/19.
//  Copyright (c) 2015年 ClaytonDailey. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *reDeal;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectNumberOfCards;
@property (weak, nonatomic) IBOutlet UISlider *sliderHistory;
@property (nonatomic) int flipCounts;
@property (strong,nonatomic) NSMutableArray *recordHistory;
@property (weak, nonatomic) IBOutlet UILabel *historyLable;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (NSMutableArray *)recordHistory
{
    if(!_recordHistory) {
        _recordHistory = [[NSMutableArray alloc] init];
        [self.recordHistory addObject:[NSString stringWithFormat:@"0. Game Start!"]];
    }
    return _recordHistory;
}

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    //
    // We don't need any of this anymore, because our Model is going to handle it.
    //
/*
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        Card *randomCard = [self.deck drawRandomCard];
        
        if (randomCard) {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
            [sender setTitle:randomCard.contents forState:UIControlStateNormal];
        }
    }
*/
    //
    // CardMatchingGame will notw handle all the effects of choosing a card.
    //
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    self.flipCounts++;
    [self updateUI];
}

- (void)updateUI
{
    Card *chosenCard = nil;
    
    for (UIButton *cardButton in self.cardButtons) {
        NSString *textDescription =@"";
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;


        if (card.chosen && !card.matched) {
            textDescription = [textDescription stringByAppendingString:[NSString stringWithFormat:@"%ld. Flip %@.", (long)self.flipCounts, card.contents]];
            [self.sliderHistory setValue:(float)self.flipCounts animated:YES];
            [self.recordHistory addObject:textDescription];
            self.historyLable.text = textDescription;
            
        } else if (card.chosen && card != chosenCard){
            //
            // Record chosen card for history.
            //
            if (chosenCard != nil && [self.recordHistory count] == self.flipCounts) {
                

//            textDescription = [textDescription stringByAppendingString:[NSString stringWithFormat:@"%ld. Flip %@.", (long)self.flipCounts, card.contents]];
     
                textDescription = [textDescription stringByAppendingString:[NSString stringWithFormat:@"%ld. Flip %@ and %@. Score %ld.", (long)self.flipCounts, card.contents, chosenCard.contents, (long)self.game.matchScore]];
                [self.sliderHistory setValue:(float)self.flipCounts animated:YES];
                [self.recordHistory addObject:textDescription];
                self.historyLable.text = textDescription;
            } else {
                chosenCard = card;
            }
        }

        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.Score];
    }
    chosenCard = nil;
    self.sliderHistory.maximumValue = self.flipCounts;
    self.sliderHistory.Value = self.flipCounts;


}

- (IBAction)viewHistory:(UISlider *)sender {
    int sliderValue = (int) sender.value;
    NSString *text  = @"";
    
    if (self.flipCounts) {
        self.historyLable.text = [text stringByAppendingString:[self.recordHistory objectAtIndex:sliderValue]];
    } else {
        [self.sliderHistory setValue:0 animated:NO];
    }
    return;
}


- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}
@end

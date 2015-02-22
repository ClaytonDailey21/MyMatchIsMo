//
//  CardGameViewController.m
//  MyMatchIsMo
//
//  Created by Dailey on 2015/2/19.
//  Copyright (c) 2015年 ClaytonDailey. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()

@end

@implementation CardGameViewController

- (IBAction)touchCardButton:(UIButton *)sender {
    
    [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
}


@end

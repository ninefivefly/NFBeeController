//
//  NFFirstViewController.m
//  NFBeeController
//
//  Created by jiangpengcheng on 14/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#import "NFFirstViewController.h"
#import "NFSecondViewController.h"

@implementation NFFirstViewController

- (IBAction)didTapedPresentButton:(id)sender{
    [self performSegueWithIdentifier:@"CustomTransition" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"CustomTransition"]) {
        NFSecondViewController* second = (id)segue.destinationViewController;
        second.presentTransitionStyleCoverHorizontal = YES;
    }
}

@end

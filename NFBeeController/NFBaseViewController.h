//
//  NFBaseViewController.h
//  NFBeeController
//
//  Created by jiangpengcheng on 8/7/16.
//  Copyright © 2016年 ninefivefly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFBaseViewController : UIViewController

/**
 *  When the view controller is presented, its view slides up from the 
 *  right of the screen. When the view controller is presented, 
 *  its view slides up from the bottom of the screen. 
 *  On dismissal, the view slides back right.
 */
@property(nonatomic)BOOL presentTransitionStyleCoverHorizontal;

@end

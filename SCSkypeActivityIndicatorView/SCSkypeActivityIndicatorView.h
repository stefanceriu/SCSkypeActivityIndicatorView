//
//  SCSkypeActivityIndicatorView.h
//  SCSkypeActivityIndicatorView
//
//  Created by Stefan Ceriu on 12/01/2014.
//  Copyright (c) 2014 Stefan Ceriu. All rights reserved.
//

@interface SCSkypeActivityIndicatorView : UIView

@property (nonatomic, assign) NSUInteger numberOfBubbles;

@property (nonatomic, strong) UIColor *bubbleColor;

@property (nonatomic, assign) CGSize bubbleSize;

@property (nonatomic, assign) NSTimeInterval animationDuration;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end

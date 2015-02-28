//
//  SCSkypeActivityIndicatorView.m
//  SCSkypeActivityIndicatorView
//
//  Created by Stefan Ceriu on 12/01/2014.
//  Copyright (c) 2014 Stefan Ceriu. All rights reserved.
//

#import "SCSkypeActivityIndicatorView.h"

static NSString * const kSkypeCurveAnimationKey = @"kSkypeCurveAnimationKey";
static NSString * const kSkypeScaleAnimationKey = @"kSkypeScaleAnimationKey";

@interface SCSkypeActivityIndicatorBubbleView : UIView

@property (nonatomic, strong) UIColor *color;

@end

@interface SCSkypeActivityIndicatorView ()

@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation SCSkypeActivityIndicatorView

- (instancetype)init
{
	if(self = [super init]) {
		[self _commonInit];
	}
	
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	if(self = [super initWithFrame:frame]) {
		[self _commonInit];
	}
	
	return self;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self _commonInit];
}

- (void)_commonInit
{
	self.numberOfBubbles = 5;
	self.animationDuration = 1.5f;
	self.bubbleSize = CGSizeMake(CGRectGetWidth(self.bounds) / 10.0f, CGRectGetHeight(self.bounds) / 10.0f);
	self.bubbleColor = [UIColor whiteColor];
}

#pragma mark - SCSkypeActivityIndicatorViewProtocol

- (void)startAnimating
{
	if(self.isAnimating) {
		return;
	}
	
	self.isAnimating = YES;
	
	
	for(NSUInteger i=0; i<self.numberOfBubbles; i++) {
		CGFloat x = i * (1.0f / self.numberOfBubbles);
		SCSkypeActivityIndicatorBubbleView *bubbleView = [self bubbleWithTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.5f :(0.1f + x) :0.25f :1.0f]
																		   initialScale:1.0f - x
																			 finalScale:0.2f + x];
		[bubbleView setAlpha:0.0f];
		[self addSubview:bubbleView];
		
		[UIView animateWithDuration:0.25f animations:^{
			[bubbleView setAlpha:1.0f];
		}];
	}
}

- (void)stopAnimating
{
	if(!self.isAnimating) {
		return;
	}
	
	for(UIView *bubble in self.subviews) {
		[UIView animateWithDuration:0.25f animations:^{
			
			[bubble setAlpha:0.0f];
		} completion:^(BOOL finished) {
			[bubble.layer removeAllAnimations];
			[bubble removeFromSuperview];
		}];
	}
	
	self.isAnimating = NO;
}

- (SCSkypeActivityIndicatorBubbleView *)bubbleWithTimingFunction:(CAMediaTimingFunction *)timingFunction initialScale:(CGFloat)initialScale finalScale:(CGFloat)finalScale
{
    SCSkypeActivityIndicatorBubbleView *bubbleView = [[SCSkypeActivityIndicatorBubbleView alloc] initWithFrame:CGRectMake(0, 0, self.bubbleSize.width, self.bubbleSize.height)];
	[bubbleView setColor:self.bubbleColor];
	
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = self.animationDuration;
    pathAnimation.repeatCount = CGFLOAT_MAX;
    pathAnimation.timingFunction = timingFunction;
	pathAnimation.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
														radius:MIN(self.bounds.size.width - bubbleView.bounds.size.width, self.bounds.size.height - bubbleView.bounds.size.height)/2
													startAngle:3 * M_PI / 2
															endAngle:3 * M_PI / 2 + 2 * M_PI
													 clockwise:YES].CGPath;
	
    [bubbleView.layer addAnimation:pathAnimation forKey:kSkypeCurveAnimationKey];
	
	
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	scaleAnimation.duration = self.animationDuration;
	scaleAnimation.repeatCount = CGFLOAT_MAX;
    scaleAnimation.fromValue = @(initialScale);
    scaleAnimation.toValue = @(finalScale);
	
    if(initialScale > finalScale) {
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    } else {
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    }
    
    [bubbleView.layer addAnimation:scaleAnimation forKey:kSkypeScaleAnimationKey];
	
	return bubbleView;
}

@end

@implementation SCSkypeActivityIndicatorBubbleView

- (id)initWithFrame:(CGRect)frame
{
	if(self = [super initWithFrame:frame]) {
		[self setBackgroundColor:[UIColor clearColor]];
	}
	
	return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClearRect(context, rect);
	CGContextAddEllipseInRect(context, self.bounds);
	CGContextSetFillColorWithColor(context, self.color.CGColor);
	CGContextFillPath(context);
}

@end

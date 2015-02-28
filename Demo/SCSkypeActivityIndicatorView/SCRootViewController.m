//
//  SCRootViewController.m
//  SCSkypeActivityIndicatorView
//
//  Created by Stefan Ceriu on 12/01/2014.
//  Copyright (c) 2014 Stefan Ceriu. All rights reserved.
//

#import "SCRootViewController.h"

#import "SCSkypeActivityIndicatorView.h"

@interface SCRootViewController ()

@property (nonatomic, strong) IBOutlet SCSkypeActivityIndicatorView *activityIndicatorView;

@end

@implementation SCRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Defaults
	//[self.activityIndicatorView setNumberOfBubbles:5];
	//[self.activityIndicatorView setAnimationDuration:1.5f];
	//[self.activityIndicatorView setBubbleSize:CGSizeMake(20.0f, 20.0f)];
	
	[self.activityIndicatorView startAnimating];
	
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
	[self.view addGestureRecognizer:tapGesture];
}

- (void)onTap:(UIGestureRecognizer *)tapGestureRecognizer
{
	if([self.activityIndicatorView isAnimating]) {
		[self.activityIndicatorView stopAnimating];
	} else {
		[self.activityIndicatorView startAnimating];
	}
}

@end

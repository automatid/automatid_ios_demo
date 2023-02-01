//
//  AutomatIDPressableButton.m
//  AutomatID_Example
//
//  Created by Silvio D'Angelo on 15/11/22.
//  Copyright © 2022 opentech.com. All rights reserved.
//

#import "AutomatIDPressableButton.h"

@implementation AutomatIDPressableButton
@synthesize titlePlaceholder = _titlePlaceholder;

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addTarget:self
                 action:@selector(onTouchDown)
       forControlEvents:UIControlEventTouchDown];
        [self addTarget:self
                 action:@selector(onTouchCancel)
       forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchCancel|UIControlEventTouchDragExit|UIControlEventTouchDragOutside];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self
                 action:@selector(onTouchDown)
       forControlEvents:UIControlEventTouchDown];
        [self addTarget:self
                 action:@selector(onTouchCancel)
       forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchCancel|UIControlEventTouchDragExit|UIControlEventTouchDragOutside];
    }
    return self;
}


-(NSString *)titlePlaceholder
{
    return self.titleLabel.text;
}

-(void)setTitlePlaceholder:(NSString *)titlePlaceholder
{
    _titlePlaceholder = titlePlaceholder;
    NSString * _Nonnull localyzedTitle = NSLocalizedString(titlePlaceholder, @"");
    if (titlePlaceholder) {

        dispatch_async(dispatch_get_main_queue(), ^{
            [self setTitle:localyzedTitle forState:UIControlStateNormal];
        });
    }
}


-(void) onTouchDown
{
    self.alpha = 0.6;
    if (_titlePlaceholder) {
        [self setTitle:NSLocalizedString(_titlePlaceholder, @"") forState:UIControlStateNormal];
    }
}


-(void) onTouchCancel
{
    self.alpha = 1.0;
    if (_titlePlaceholder) {
        [self setTitle:NSLocalizedString(_titlePlaceholder, @"") forState:UIControlStateNormal];
    }
}

@end

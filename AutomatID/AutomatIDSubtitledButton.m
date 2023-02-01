//
//  AutomatIDSubtitledButton.m
//  AutomatID_Example
//
//  Created by Silvio D'Angelo on 15/11/22.
//  Copyright © 2022 opentech.com. All rights reserved.
//

#import "AutomatIDSubtitledButton.h"

@interface AutomatIDSubtitledButton ()

@end

@implementation AutomatIDSubtitledButton 


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


-(void) onTouchDown
{
    self.alpha = 0.6;
}


-(void) onTouchCancel
{
    self.alpha = 1.0;
}

@end

//
//  CommonCardView.m
//  Machismo2
//
//  Created by Ariel Imber on 12/11/2020.
//

#import "CommonCardView.h"

@implementation CommonCardView

- (CGFloat)cornerScaleFactor {
  return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRadius {
  return CORNER_RADIUS * [self cornerScaleFactor];
}


- (void)drawRect:(CGRect)rect {
  
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
  
  [roundedRect addClip];
  
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
}

- (void)tapAnimationWithCompletion:(void (^)(BOOL))completion {
  
}

- (void)tap:(UITapGestureRecognizer *)gesture {
  [self tapAnimationWithCompletion:nil];
}

#pragma mark - Initialization
- (void)setup {
  
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
  self.matched = NO;
//  [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]){
    [self setup];
    
  }
  return self;
}

@end

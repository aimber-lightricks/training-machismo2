//
//  CardsView.m
//  Machismo2
//
//  Created by Ariel Imber on 10/11/2020.
//

#import "CardsView.h"

@implementation CardsView

#pragma mark - Initialization
- (void)setup {
  
  self.backgroundColor = [UIColor whiteColor];
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;

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

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
}

@end

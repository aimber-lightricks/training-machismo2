//
//  DeckView.m
//  Machismo2
//
//  Created by Ariel Imber on 18/11/2020.
//

#import "DeckView.h"

@implementation DeckView

- (void)drawRect:(CGRect)rect {

  [super drawRect:rect];
  
  [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    
  
}
@end

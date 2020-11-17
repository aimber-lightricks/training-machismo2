//
//  PlayingCardView.m
//  Machismo2
//
//  Created by Ariel Imber on 10/11/2020.
//

#import "PlayingCardView.h"

#import "PlayngCard.h"

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90
#define PIP_FONT_SCALE_FACTOR 0.012
#define PIP_HOFFSET_PECENTAGE 0.165
#define PIP_VOFFSET1_PECENTAGE 0.090
#define PIP_VOFFSET2_PECENTAGE 0.175
#define PIP_VOFFSET3_PECENTAGE 0.270

@interface PlayingCardView ()

@property (nonatomic) CGFloat faceCardScaleFactor;

@end

@implementation PlayingCardView

#pragma mark - properties
- (void)setRank:(NSUInteger)rank {
  _rank = rank;
  [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit {
  _suit = suit;
  [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
  _faceUp = faceUp;
  [self setNeedsDisplay];
}

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (CGFloat)faceCardScaleFactor {
  if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
  return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
  _faceCardScaleFactor = faceCardScaleFactor;
  [self setNeedsDisplay];
  
}

- (NSString *)rankAsString {
  return [PlayngCard rankStrings][self.rank];
}


#pragma mark - Drawing

- (CGFloat)cornerOffset {
  return [self cornerRadius] / 3.0;
  
}

- (void)drawRect:(CGRect)rect {

  [super drawRect:rect];
  
  if (self.faceUp) {
    UIImage * faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
    if (faceImage) {
      CGFloat insetScaleFactor = 1.0 - self.faceCardScaleFactor;
      CGRect imageRect  = CGRectInset(self.bounds,
                                      self.bounds.size.width * insetScaleFactor,
                                      self.bounds.size.height * insetScaleFactor);
      [faceImage drawInRect:imageRect];
    } else {
      [self drawPips];
    }
    
    [self drawCorners];
  } else {
    [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    
  }
}


- (void) drawPipsWithHrizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                          upsideDown:(BOOL)upsideDown {
  if (upsideDown) {
    [self pushContextAndRotateUpsideDown];
  }
  CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
  UIFont *pipFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  pipFont = [pipFont fontWithSize:[pipFont pointSize] * self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
  NSAttributedString *attributedSuit = [[NSAttributedString alloc]
                                        initWithString:self.suit
                                        attributes:@{ NSFontAttributeName : pipFont}];
  CGSize pipSize = [attributedSuit size];
  CGPoint pipOrigin = CGPointMake(
                                  middle.x - pipSize.width/2.0 - hoffset * self.bounds.size.width,
                                  middle.y - pipSize.height/2.0 - voffset * self.bounds.size.height);
  [attributedSuit drawAtPoint:pipOrigin];
  if (hoffset) {
    pipOrigin.x += hoffset * 2.0 * self.bounds.size.width;
    [attributedSuit drawAtPoint:pipOrigin];
  }
  if (upsideDown) {
    [self popContext];
  }
    
}

 - (void)drawPipsWithHrizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                          mirroredVerticaly:(BOOL)mirroredVerticaly {
 [self drawPipsWithHrizontalOffset:hoffset
                    verticalOffset:voffset
                        upsideDown:NO];
   if (mirroredVerticaly){
     [self drawPipsWithHrizontalOffset:hoffset
                        verticalOffset:voffset
                            upsideDown:YES];
   }
 
 
 }

- (void)pushContextAndRotateUpsideDown {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
}

- (void)popContext {
  CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (void) drawPips {
  // single pip in the middle
  if ((self.rank == 1) || (self.rank == 5) || (self.rank == 9) || (self.rank == 3)) {
    [self drawPipsWithHrizontalOffset:0
                       verticalOffset:0
                    mirroredVerticaly:NO];
  }
  
  //two pips around the horizontal middle
  if ((self.rank == 6) || (self.rank == 7) || (self.rank == 8)) {
    [self drawPipsWithHrizontalOffset:PIP_HOFFSET_PECENTAGE
                       verticalOffset:0
                    mirroredVerticaly:NO];
  }
  
  //two pips on vertical middle
  if ((self.rank == 2) || (self.rank == 3) || (self.rank == 7) || (self.rank == 8) || (self.rank == 10)) {
    [self drawPipsWithHrizontalOffset:0
                       verticalOffset:PIP_VOFFSET2_PECENTAGE
                    mirroredVerticaly:(self.rank != 7)];
  }

  //4 pips in 4 corrners
  if ((self.rank == 4) || (self.rank == 5) || (self.rank == 6) || (self.rank == 7)
      || (self.rank == 8) || (self.rank == 7) || (self.rank == 8)) {
    [self drawPipsWithHrizontalOffset:PIP_HOFFSET_PECENTAGE
                       verticalOffset:PIP_VOFFSET3_PECENTAGE
                    mirroredVerticaly:YES];

  }
  if ((self.rank == 9) || (self.rank == 10) ) {
    [self drawPipsWithHrizontalOffset:PIP_HOFFSET_PECENTAGE
                       verticalOffset:PIP_VOFFSET1_PECENTAGE
                    mirroredVerticaly:YES];
  }
}


- (void)drawCorners {
  
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.alignment = NSTextAlignmentCenter;
  
  UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
  
  NSAttributedString *corrnerText = [[NSAttributedString alloc]
                                     initWithString:[NSString stringWithFormat:@"%@\n%@",
                                                     [self rankAsString], self.suit]
                                     attributes : @{NSFontAttributeName : cornerFont,
                                                    NSParagraphStyleAttributeName : paragraphStyle}];
  CGRect textBounds;
  textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
  textBounds.size = [corrnerText size];
  [corrnerText drawInRect:textBounds];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
  [corrnerText drawInRect:textBounds];
}

- (void)tapAnimationWithCompletion:(void (^ __nullable)(BOOL finished))completion {
  [UIView transitionWithView:self duration:1.0
                     options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionBeginFromCurrentState
                  animations:^{ self.faceUp = !self.faceUp; } completion:completion];
}

- (BOOL)isEqual:(id)object {
  if (![object isKindOfClass:[self class]]) {
    return NO;
  }
  PlayingCardView *otherPlayingCardView = (PlayingCardView *)object;
  return (self.rank == otherPlayingCardView.rank) &&
  ([self.suit isEqual:otherPlayingCardView.suit]) &&
  (self.faceUp = otherPlayingCardView.faceUp);
}

@end

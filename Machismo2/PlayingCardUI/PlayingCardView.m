//
//  PlayingCardView.m
//  Machismo2
//
//  Created by Ariel Imber on 10/11/2020.
//

#import "PlayingCardView.h"

#import "PlayngCard.h"

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define  CORNER_RADIUS 12.0
#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

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
- (CGFloat)cornerScaleFactor {
  return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRadius {
  return CORNER_RADIUS * [self cornerScaleFactor];
}

- (CGFloat)cornerOffset {
  return [self cornerRadius] / 3.0;
  
}

- (void)drawRect:(CGRect)rect {

  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
  
  [roundedRect addClip];
  
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  
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

- (void) drawPips {
  
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

- (void)tap:(UITapGestureRecognizer *)gesture {
  
  [UIView transitionWithView:self duration:1.0
                     options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionBeginFromCurrentState 
                  animations:^{ self.faceUp = !self.faceUp; } completion:nil];
}




#pragma mark - Initialization
- (void)setup {
  
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
  [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self setup];
}


@end

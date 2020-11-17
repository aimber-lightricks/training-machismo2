//
//  SetCardView.m
//  Machismo2
//
//  Created by Ariel Imber on 11/11/2020.
//

#import "SetCardView.h"
#import "SetShape.h"
#import "OvalShape.h"
#import "SquiggleShape.h"
#import "DimondShape.h"

#define SHAPE_HEIGHT_SCALE_FACTOR 0.2
#define SHAPE_HORIZONTAL_INSET_FACTOR 2.0/11.0
#define VERTICAL_INSET_SCALE_FACTOR 0.4

@interface SetCardView ()
@property (nonatomic) BOOL selected;
@property (strong ,nonatomic)SetShape *setShapeBase;
@property (strong, nonatomic, readonly)UIColor *cardUIColor;

@end




@implementation SetCardView


- (UIColor *)cardUIColor {
  switch (self.cardColor) {
    case GREEN:
      return [UIColor greenColor];
    case PURPEL:
      return [UIColor purpleColor];
    case RED:
      return [UIColor redColor];
    default:
      break;
  }
  return nil;
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  [self drawShape];
}

- (void) drawShape {
  CGFloat horizontalInset = self.bounds.size.width * SHAPE_HORIZONTAL_INSET_FACTOR;
  
  CGFloat shapeWidth = self.bounds.size.width - 2 * horizontalInset;
  CGFloat shapeHeight = self.bounds.size.height * SHAPE_HEIGHT_SCALE_FACTOR;
  CGFloat verticalInset = shapeHeight * VERTICAL_INSET_SCALE_FACTOR;
  //  CGFloat widthCenter = self.bounds.size.width / 2.0;
  CGFloat heightCenter = self.bounds.size.height / 2.0;
  switch (self.numberOfShapes) {
    case ONE:
      
      [self addSingleShape:CGRectMake(horizontalInset,
                                      heightCenter - (shapeHeight / 2.0),
                                      shapeWidth,
                                      shapeHeight)];
      break;
    case TWO:
      //Upper shape
      [self addSingleShape:CGRectMake(horizontalInset,
                                      heightCenter - shapeHeight - verticalInset,
                                      shapeWidth,
                                      shapeHeight)];
      //Lower shape
      [self addSingleShape:CGRectMake(horizontalInset,
                                      heightCenter + verticalInset,
                                      shapeWidth,
                                      shapeHeight)];
      break;

    case THREE:
      //Upper shape
      [self addSingleShape:CGRectMake(horizontalInset,
                                      heightCenter - (shapeHeight / 2.0) - shapeHeight - verticalInset,
                                      shapeWidth,
                                      shapeHeight)];
      //Middle shape
      [self addSingleShape:CGRectMake(horizontalInset,
                                      heightCenter - (shapeHeight / 2.0),
                                      shapeWidth,
                                      shapeHeight)];
      //Lower shape
      [self addSingleShape:CGRectMake(horizontalInset,
                                      heightCenter + (shapeHeight / 2.0) + verticalInset ,
                                      shapeWidth,
                                      shapeHeight)];

      break;
    default:
      break;
  }
}

- (void) addSingleShape:(CGRect)rect {
  SetShape *shape;
  switch (self.cardShape) {
    case OVAL:
      shape = [[OvalShape alloc] initWithFrame:rect];
      break;
    case SQUIGGLE:
      shape = [[SquiggleShape alloc] initWithFrame:rect];
      break;
    case DIMOND:
      shape = [[DimondShape alloc] initWithFrame:rect];
      break;

    default:
      break;
  }
  shape.shapeColor = self.cardUIColor;
  shape.shapeFillPattern = self.cardFillPattern;
  [self addSubview:shape];
  
}


@synthesize selected = _selected;
- (void)setSelected:(BOOL)selected {
  _selected = selected;
  if (selected) {
    self.alpha = 0.7;
  } else {
    self.alpha = 1.0;
  }
  
}

- (void)tapAnimationWithCompletion:(void (^)(BOOL))completion {
  [UIView animateWithDuration:1.0
                   animations:^{self.selected = !self.selected;}
                   completion:completion];

}

- (void)setup {
  [super setup];
  self.selected = NO;
}

- (BOOL)isEqual:(id)object {
  if (![object isKindOfClass:[self class]]) {
    return NO;
  }
  SetCardView *otherSetCardView = (SetCardView *)object;
  return (self.cardColor == otherSetCardView.cardColor) &&
  (self.cardShape == otherSetCardView.cardShape) &&
  (self.cardFillPattern == otherSetCardView.cardFillPattern) &&
  (self.numberOfShapes == otherSetCardView.numberOfShapes);
}

@end

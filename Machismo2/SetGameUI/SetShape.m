//
//  SetShape.m
//  Machismo2
//
//  Created by Ariel Imber on 12/11/2020.
//

#import "SetShape.h"
#define DELTA_X 6
#define LINE_WIDTH DELTA_X/2.0

@implementation SetShape

- (UIBezierPath *)shapePath {
  return nil;
}


- (void)drawRect:(CGRect)rect {
  // get the bounding rectangle for the outline shape
   CGRect bounds = self.shapePath.bounds;

  // set color for all aoperations
  [self.shapeColor set];

  if (self.shapeFillPattern == STRIPED) {
     // create a UIBezierPath for the fill pattern
     UIBezierPath *stripes = [UIBezierPath bezierPath];
     for ( int x = 0; x < bounds.size.width; x += DELTA_X )
     {
         [stripes moveToPoint:CGPointMake( bounds.origin.x + x, bounds.origin.y )];
         [stripes addLineToPoint:CGPointMake( bounds.origin.x + x, bounds.origin.y + bounds.size.height )];
     }
     [stripes setLineWidth:LINE_WIDTH];

     CGContextRef context = UIGraphicsGetCurrentContext();

     // draw the fill pattern first, using the outline to clip
     CGContextSaveGState( context );         // save the graphics state
     [self.shapePath addClip];               // use the outline as the clipping path
     [stripes stroke];                       // draw the stripes
     CGContextRestoreGState( context );      // restore the graphics state, removes the clipping path
  } else if (self.shapeFillPattern == SOLID) {
    [self.shapeColor setFill];
    [self.shapePath fill];
    
  }
   // draw the outline of the shape
   [self.shapePath stroke];
}

#pragma mark - Initialization
- (void)setup {
  
  self.backgroundColor = nil;
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

  


@end

//
//  SquiggleShape.m
//  Machismo2
//
//  Created by Ariel Imber on 12/11/2020.
//

#import "SquiggleShape.h"

#define SYMBOL_WIDTH_RATIO 0.5
#define SYMBOL_HEIGHT_RATIO 0.5

@implementation SquiggleShape

- (UIBezierPath *)shapePath {
  return [self squiggleAtPoint:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0)];
}

- (UIBezierPath *)squiggleAtPoint:(CGPoint)point
{
    CGSize size = CGSizeMake(self.bounds.size.width * SYMBOL_WIDTH_RATIO, self.bounds.size.height * SYMBOL_HEIGHT_RATIO);

    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(104, 15)];
    [path addCurveToPoint:CGPointMake(63, 54) controlPoint1:CGPointMake(112.4, 36.9) controlPoint2:CGPointMake(89.7, 60.8)];
    [path addCurveToPoint:CGPointMake(27, 53) controlPoint1:CGPointMake(52.3, 51.3) controlPoint2:CGPointMake(42.2, 42)];
    [path addCurveToPoint:CGPointMake(5, 40) controlPoint1:CGPointMake(9.6, 65.6) controlPoint2:CGPointMake(5.4, 58.3)];
    [path addCurveToPoint:CGPointMake(36, 12) controlPoint1:CGPointMake(4.6, 22) controlPoint2:CGPointMake(19.1, 9.7)];
    [path addCurveToPoint:CGPointMake(89, 14) controlPoint1:CGPointMake(59.2, 15.2) controlPoint2:CGPointMake(61.9, 31.5)];
    [path addCurveToPoint:CGPointMake(104, 15) controlPoint1:CGPointMake(95.3, 10) controlPoint2:CGPointMake(100.9, 6.9)];

    [path applyTransform:CGAffineTransformMakeScale(0.9524*size.width/100, 0.9524*size.height/50)];
    [path applyTransform:CGAffineTransformMakeTranslation(point.x - size.width/2 - 3 * size.width /100, point.y - size.height/2 - 8 * size.height/50)];

    return path;
}

@end

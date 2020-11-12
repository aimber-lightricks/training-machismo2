//
//  DimondShape.m
//  Machismo2
//
//  Created by Ariel Imber on 12/11/2020.
//

#import "DimondShape.h"

@implementation DimondShape

- (UIBezierPath *)shapePath {
  UIBezierPath *dimondPath = [UIBezierPath bezierPath];
  CGFloat frameWidth = self.frame.size.width;
  CGFloat frameHeight = self.frame.size.height;
  CGFloat frameHeightCenter = frameHeight/2;
  CGFloat frameWidthCenter = frameWidth/2;
  [dimondPath moveToPoint:CGPointMake(frameWidthCenter, 0)];
  [dimondPath addLineToPoint:CGPointMake(frameWidth, frameHeightCenter)];
  [dimondPath addLineToPoint:CGPointMake(frameWidthCenter, frameHeight)];
  [dimondPath addLineToPoint:CGPointMake(0, frameHeightCenter)];
  [dimondPath closePath];
  return dimondPath;
}

@end

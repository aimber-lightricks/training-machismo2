//
//  OvalShape.m
//  Machismo2
//
//  Created by Ariel Imber on 12/11/2020.
//

#import "OvalShape.h"

@implementation OvalShape

- (UIBezierPath *)shapePath {
  UIBezierPath *ovalPath = [UIBezierPath bezierPath];
  CGFloat frameWidth = self.frame.size.width;
  CGFloat frameHeight = self.frame.size.height;
  CGFloat frameHeightCenter = frameHeight/2;

  // First arc
  CGPoint arcCenter = CGPointMake(frameHeightCenter, frameHeightCenter);
  [ovalPath addArcWithCenter:arcCenter radius:frameHeightCenter startAngle:-M_PI/2 endAngle:M_PI/2 clockwise:NO];
  // Line from arc to arc
  [ovalPath addLineToPoint:CGPointMake(frameWidth - frameHeightCenter, frameHeight)];
  //Second arc
  arcCenter = CGPointMake(frameWidth - frameHeightCenter, frameHeightCenter);
  [ovalPath addArcWithCenter:arcCenter radius:frameHeightCenter startAngle:M_PI/2 endAngle:-M_PI/2 clockwise:NO];
  // Second line from arc to arc
  [ovalPath closePath];
  
  return ovalPath;
}

@end

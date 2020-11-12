//
//  SetShape.h
//  Machismo2
//
//  Created by Ariel Imber on 12/11/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
  SOLID,
  STRIPED,
  UNFILLED,
} ShapeFillPattern;



@interface SetShape : UIView
@property (strong, nonatomic, readonly)UIBezierPath *shapePath; //abstract
@property (nonatomic)UIColor* shapeColor;
@property (nonatomic)ShapeFillPattern shapeFillPattern;


@end

NS_ASSUME_NONNULL_END

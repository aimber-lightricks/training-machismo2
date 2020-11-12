//
//  SetCardView.h
//  Machismo2
//
//  Created by Ariel Imber on 11/11/2020.
//

#import "CommonCardView.h"

#import "SetShape.h"

typedef enum : NSUInteger {
  GREEN,
  RED,
  PURPEL,
} CardColor;


typedef enum : NSUInteger {
  OVAL,
  SQUIGGLE,
  DIMOND,
} CardShape;


typedef enum : NSUInteger {
  ONE,
  TWO,
  THREE,
} NumberOfShapes;

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView : CommonCardView

@property (nonatomic) CardColor cardColor;
@property (nonatomic) CardShape cardShape;
@property (nonatomic) ShapeFillPattern cardFillPattern;
@property (nonatomic) NumberOfShapes numberOfShapes;


@end

NS_ASSUME_NONNULL_END

//
//  CommonCardView.h
//  Machismo2
//
//  Created by Ariel Imber on 12/11/2020.
//

#import <UIKit/UIKit.h>

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define  CORNER_RADIUS 12.0

NS_ASSUME_NONNULL_BEGIN

@interface CommonCardView : UIView

- (void)awakeFromNib;
- (instancetype)initWithFrame:(CGRect)frame;
- (CGFloat)cornerRadius;
- (CGFloat)cornerScaleFactor;
- (void)setup;
- (void)tap:(UITapGestureRecognizer *)gesture; //abstract

@end

NS_ASSUME_NONNULL_END

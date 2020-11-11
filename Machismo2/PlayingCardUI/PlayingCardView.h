//
//  PlayingCardView.h
//  Machismo2
//
//  Created by Ariel Imber on 10/11/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;



@end

NS_ASSUME_NONNULL_END

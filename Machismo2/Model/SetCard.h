//
//  SetCard.h
//  Machismo
//
//  Created by Ariel Imber on 04/11/2020.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card


- (instancetype) initWithShape:(NSInteger)shape
                     withColor:(NSInteger)color
                 withStripping:(NSInteger)stripping;


@property (nonatomic, readonly) NSInteger shape;
@property (nonatomic, readonly) NSInteger color;
@property (nonatomic, readonly) NSInteger stripping;

@end

NS_ASSUME_NONNULL_END

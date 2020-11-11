//
//  SetCard.h
//  Machismo
//
//  Created by Ariel Imber on 04/11/2020.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card


- (instancetype) initWithShape:(NSUInteger)shape
                     withColor:(NSUInteger)color
                 withStripping:(NSUInteger)stripping;


@property (nonatomic, readonly) NSUInteger shape;
@property (nonatomic, readonly) NSUInteger color;
@property (nonatomic, readonly) NSUInteger stripping;

@end

NS_ASSUME_NONNULL_END

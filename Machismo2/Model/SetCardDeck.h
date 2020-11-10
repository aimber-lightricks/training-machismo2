//
//  SetCardDeck.h
//  Machismo
//
//  Created by Ariel Imber on 04/11/2020.
//

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardDeck : Deck
- (instancetype) initWithNumberOfShapes:(NSInteger)numberOfShapes
                     withNumberOfColors:(NSInteger)numberOfColors
                 withNumberOfStrippings:(NSInteger)numberOfStrippings;

@end

NS_ASSUME_NONNULL_END

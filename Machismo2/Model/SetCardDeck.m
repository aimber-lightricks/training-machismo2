//
//  SetCardDeck.m
//  Machismo
//
//  Created by Ariel Imber on 04/11/2020.
//

#import "SetCardDeck.h"

#import "SetCard.h"

@implementation SetCardDeck

- (instancetype) initWithNumberOfShapes:(NSInteger)numberOfShapes
                     withNumberOfColors:(NSInteger)numberOfColors
                 withNumberOfStrippings:(NSInteger)numberOfStrippings {

    self = [super init];
    if (self){
      for (NSInteger shape = 0; shape < numberOfShapes; shape++){
        for (NSInteger color = 0; color < numberOfColors; color++){
          for (NSInteger stripping = 0; stripping < numberOfStrippings; stripping++){
                SetCard *card = [[SetCard alloc] initWithShape:shape withColor:color withStripping:stripping];
                [self addCard:card];
            }
          }
        }
    }
    return self;
}
@end

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
                 withNumberOfStrippings:(NSInteger)numberOfStrippings withMaxNumberOfShapes:(NSUInteger)maxNumberOfShapes{
  
  self = [super init];
  if (self){
    for (NSInteger shape = 0; shape < numberOfShapes; shape++) {
      for (NSInteger color = 0; color < numberOfColors; color++) {
        for (NSInteger stripping = 0; stripping < numberOfStrippings; stripping++) {
          for (NSUInteger numberOfShapes = 0; numberOfShapes < maxNumberOfShapes; numberOfShapes++) {
            SetCard *card = [[SetCard alloc] initWithShape:shape withColor:color withStripping:stripping withNumberOfShapes:numberOfShapes];
            
            [self addCard:card];
          }
        }
      }
    }
  }
  return self;
}
@end

//
//  SetGameViewController.m
//  Machismo2
//
//  Created by Ariel Imber on 12/11/2020.
//

#import "SetGameViewController.h"

#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetCardView.h"

#define NUMBER_OF_CARDS_TO_MATCH 3
#define NUMBER_OF_CARDS_IN_A_SET_GAME 12

#define NUMBER_OF_SHAPES_TYPES 3
#define NUMBER_OF_COLORS 3
#define NUMBER_OF_STRIPPINGS 3
#define MAX_NUMBER_OF_SHAPES 3
#define CARDS_TO_ADD 3

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (NSInteger)numberOfMatchesMode {
  return NUMBER_OF_CARDS_TO_MATCH;
}

- (NSInteger)numberOfCardsInGame {
return NUMBER_OF_CARDS_IN_A_SET_GAME;
}

- (NSInteger)numberOfCardsToAdd {
  return CARDS_TO_ADD;
}

- (Deck *)createDeck {
  return [[SetCardDeck alloc] initWithNumberOfShapes:NUMBER_OF_SHAPES_TYPES
                                  withNumberOfColors:NUMBER_OF_COLORS
                              withNumberOfStrippings:NUMBER_OF_STRIPPINGS
                               withMaxNumberOfShapes:MAX_NUMBER_OF_SHAPES];
}

- (CommonCardView *)getNewCardView:(CGRect)rect forCard:(Card*)card {
  SetCardView * setCardView = [[SetCardView alloc] initWithFrame:rect];
  SetCard *setCard = (SetCard*)card;
  
  setCardView.cardColor = setCard.color;
  setCardView.cardShape = setCard.shape;
  setCardView.cardFillPattern = setCard.stripping;
  setCardView.numberOfShapes = setCard.numberOfShapes;
  
  return setCardView;
  
}

- (void)animateCardViewRemove:(CommonCardView *)cardView {
  [UIView animateWithDuration:3.0
                   animations:^{
    int x = (arc4random()%(int)(self.view.bounds.size.width * 5 )) - (int)self.view.bounds.size.width * 2;
    int y = self.view.bounds.size.height;
    cardView.center = CGPointMake(x, y);
    
  } completion:^(BOOL finished) {
    [cardView removeFromSuperview];
  }
   ];
}

- (void)viewDidLoad {
  [super viewDidLoad];
}


@end

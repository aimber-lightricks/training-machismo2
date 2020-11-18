//
//  PlayingCardViewController.m
//  Machismo2
//
//  Created by Ariel Imber on 10/11/2020.
//

#import "PlayingCardViewController.h"
#import "PlayingCardView.h"
#import "PlayngCardDeck.h"
#import "PlayngCard.h"

#define NUMBER_OF_CARDS_TO_MATCH 2
#define NUMBER_OF_CARDS_IN_A_MATCHING_GAME 30

@interface PlayingCardViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end

@implementation PlayingCardViewController

- (NSInteger)numberOfMatchesMode {
  return NUMBER_OF_CARDS_TO_MATCH;
}

- (NSInteger)numberOfCardsInGame {
return NUMBER_OF_CARDS_IN_A_MATCHING_GAME;
}

- (NSInteger)numberOfCardsToAdd {
  return 0;
}

- (Deck *)createDeck {
  return [[PlayngCardDeck alloc] init];
}

- (CommonCardView *)getNewCardView:(CGRect)rect forCard:(Card*)card {
  PlayingCardView * playingCardView = [[PlayingCardView alloc] initWithFrame:rect];
  PlayngCard *playingCard = (PlayngCard *)card;
  
  playingCardView.rank = playingCard.rank;
  playingCardView.suit = playingCard.suit;
  playingCardView.faceUp = playingCard.chosen;
  playingCardView.alpha = 0;
  
  return playingCardView;
  
}

- (void)animateCardViewRemove:(CommonCardView *)cardView
               withComplition:(void (^ __nullable)(BOOL finished))completion {
  [UIView animateWithDuration:1.0 animations:^{cardView.alpha = 0.7;} completion:completion];
}


- (BOOL)drawMatchedCards {
  return YES;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}
@end

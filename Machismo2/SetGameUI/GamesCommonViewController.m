//
//  GamesCommonViewController.m
//  Machismo2
//
//  Created by Ariel Imber on 12/11/2020.
//

#import "GamesCommonViewController.h"
#import "CardMatchingGame.h"
#import "Grid.h"

#define REAL_CARD_WIDTH_CM 5.55
#define REAL_CARD_HEIGHT_CM 8.65
#define CELL_ASSPECT_RATIO REAL_CARD_WIDTH_CM/REAL_CARD_HEIGHT_CM

@interface GamesCommonViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableArray *cardsViews;
@property (strong, nonatomic) Grid *cardsGrid;
@end

@implementation GamesCommonViewController


- (CardMatchingGame *)game{
    if (!_game) _game = [self createNewGame];
    return _game;
}

- (CardMatchingGame *)createNewGame{
    return [[CardMatchingGame alloc] initWithCardCount:self.numberOfCardsInGame
                                             usingDeck:[self createDeck]
            matchingNumberOfCards:self.numberOfMatchesMode];
}

- (Deck *)createDeck {
  return nil;
}



- (IBAction)restartGameButton:(UIButton *)sender {
    self.game = [self createNewGame];
    [self updateUI];
  
}

- (void)updateUI {
  [self.cardsViews enumerateObjectsUsingBlock:^(CommonCardView *cardView, NSUInteger index, BOOL *stop) {
    [cardView removeFromSuperview];
  }];
  self.cardsViews = [[NSMutableArray alloc] init];
  NSUInteger cardIndex = 0;
  Card *card = [self.game cardAtIndex:cardIndex];
  while (card) {
    [self drawCard:card atIndex:cardIndex];
    cardIndex++;
    card = [self.game cardAtIndex:cardIndex];
    
    }
    self.scoreLable.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];

}

- (void) drawCard:(Card*)card atIndex:(NSUInteger)cardIndex {
  if (card.matched) return;
//  NSInteger numberOfRows = self.cardsGrid.rowCount;
  NSInteger numberOfColumns = self.cardsGrid.columnCount;
  NSInteger cardViewRow = cardIndex / numberOfColumns;
  NSInteger cardViewColumn = cardIndex % numberOfColumns;
  CommonCardView *cardView = [self  getNewCardView:[self.cardsGrid frameOfCellAtRow:cardViewRow inColumn:cardViewColumn] forCard:card];
    cardIndex++;
  [self.cardsView addSubview:cardView];
  [self.cardsViews addObject:cardView];
  }

- (CommonCardView *)getNewCardView:(CGRect)rect forCard:(Card*)card {
  return nil;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self setupCardsGrid];
  [self updateUI];
}

- (void) setupCardsGrid {
  self.cardsGrid = [[Grid alloc] init];
//  self.cardsView.clipsToBounds = YES;
  self.cardsGrid.size = CGSizeMake(self.cardsView.frame.size.width, self.cardsView.frame.size.height);
  self.cardsGrid.cellAspectRatio = CELL_ASSPECT_RATIO;
  self.cardsGrid.minimumNumberOfCells = self.numberOfCardsInGame;
  [self.cardsGrid inputsAreValid];
  
}

- (void)animateCardViewRemove:(CommonCardView *)cardView{
 
}

- (void)removeMatchedCardsViews:(NSArray *)cardsToRemove {
  for (Card* card in cardsToRemove) {
    CommonCardView *cardToRemoveView = [self getNewCardView:CGRectZero forCard:card];
    for (CommonCardView *cardView in self.cardsViews) {
      if ([cardToRemoveView isEqual:cardView]) {
        [self animateCardViewRemove:cardView];
        [self.cardsViews removeObject:cardView];
        
      }
    }
  }
  
}

- (void)dealNewCards {
  NSUInteger numberOfCardsAdded = [self.game addCardsFromDeck:self.numberOfCardsToAdd];
  self.cardsGrid.minimumNumberOfCells += numberOfCardsAdded;
  [self updateUI];
}

- (void)didNotMatchMove:(NSArray *)moveCards {
  for (Card* card in moveCards) {
    CommonCardView *cardToRemoveView = [self getNewCardView:CGRectZero forCard:card];
    for (CommonCardView *cardView in self.cardsViews) {
      if ([cardToRemoveView isEqual:cardView]) {
        [cardView tapAnimationWithCompletion:nil];
      }
    }
  }

}

- (IBAction)cardsViewTap:(UITapGestureRecognizer *)sender {
  CGPoint touchPoint = [sender locationInView:self.cardsView];
  NSUInteger cardIndex = 0;
  for (CommonCardView *cardView in self.cardsViews) {
    if (CGRectContainsPoint(cardView.frame, touchPoint)) {
      struct MoveResult moveResult = [self.game chooseCardAtIndex:cardIndex];
      [cardView tapAnimationWithCompletion:^(BOOL finished) {
        switch (moveResult.moveOutcome) {
          case FlippedCard:
            break;
          case Matched:
            [self removeMatchedCardsViews:moveResult.moveCards];
            [self dealNewCards];
          case AlreadyMatched:
            break;
          case DidNotMatch:
            [self didNotMatchMove:moveResult.moveCards];
            break;

          default:
            break;
        }
        [self updateUI];
      }];

      break;
    }
    cardIndex ++;
  }
  
}


- (void)viewDidLoad {
  [super viewDidLoad];
  [self.cardsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cardsViewTap:)]];

}


@end

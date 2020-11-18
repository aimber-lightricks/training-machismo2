//
//  GamesCommonViewController.m
//  Machismo2
//
//  Created by Ariel Imber on 12/11/2020.
//

#import "GamesCommonViewController.h"
#import "DeckView.h"

#define REAL_CARD_WIDTH_CM 5.55
#define REAL_CARD_HEIGHT_CM 8.65
#define CELL_ASSPECT_RATIO REAL_CARD_WIDTH_CM/REAL_CARD_HEIGHT_CM

@interface GamesCommonViewController ()
@property (strong, nonatomic) Deck *deck;
@property (nonatomic) CGSize currentCardsViewsSize;
@property (nonatomic) NSUInteger currentNumberOfActiveCards;
@property (strong, nonatomic) DeckView *deckViewCard;
//@property (strong, nonatomic) Deck *deckView;
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
  [self addFirstCardsViews];
  [self setupCardsGrid];
  [self updateUI];
  
}


- (void)updateUI {
  NSUInteger cardsDrawnIndex = 0;
  for (CommonCardView *cardView in self.cardsViews) {
    if (!cardView.matched) {
      [self drawCardView:cardView atIndex:cardsDrawnIndex];
      cardsDrawnIndex++;
    }
  }

  [self updateScoreLabel];
}

- (void)updateScoreLabel {
  self.scoreLable.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
}

- (void)updateUIwithMoveResult:(struct MoveResult)moveResult withLastCardViewSelected:(CommonCardView *)selectedCardView {
  if (selectedCardView) {
    [self handleLastMove:moveResult withLastCardViewSelected:selectedCardView];
  }
}

- (void) drawCardView:(CommonCardView *)cardView atIndex:(NSUInteger)cardIndex {
  if (!self.drawMatchedCards && cardView.matched) return;
  NSInteger numberOfColumns = self.cardsGrid.columnCount;
  NSInteger cardViewRow = cardIndex / numberOfColumns;
  NSInteger cardViewColumn = cardIndex % numberOfColumns;
  [UIView animateWithDuration:1.0
                   animations:^{
    cardView.frame = [self.cardsGrid frameOfCellAtRow:cardViewRow inColumn:cardViewColumn];
    cardView.alpha = 1;
  }
                   completion:nil];
  
}

//- (void) drawCard:(Card*)card atIndex:(NSUInteger)cardIndex {
//  if (card.matched) return;
//  //  NSInteger numberOfRows = self.cardsGrid.rowCount;
//  NSInteger numberOfColumns = self.cardsGrid.columnCount;
//  NSInteger cardViewRow = cardIndex / numberOfColumns;
//  NSInteger cardViewColumn = cardIndex % numberOfColumns;
//  CommonCardView *cardView = [self  getNewCardView:[self.cardsGrid frameOfCellAtRow:cardViewRow inColumn:cardViewColumn] forCard:card];
//  [self.cardsView addSubview:cardView];
//  [self.cardsViews addObject:cardView];
//}

- (CommonCardView *)getNewCardView:(CGRect)rect forCard:(Card*)card {
  return nil;
}

- (void)setupCardsGrid {
  self.cardsGrid = [[Grid alloc] init];
  //  self.cardsView.clipsToBounds = YES;
  self.cardsGrid.size = self.cardsView.frame.size;
  self.cardsGrid.cellAspectRatio = CELL_ASSPECT_RATIO;
  self.cardsGrid.minimumNumberOfCells = self.currentNumberOfActiveCards;
  [self.cardsGrid inputsAreValid];
  
}

#pragma - Card Selection
- (void)animateCardViewRemove:(CommonCardView *)cardView
               withComplition:(void (^ __nullable)(BOOL finished))completion {
  
}



- (void)removeMatchedCardsViews:(NSArray *)cardsToRemove
                 withCompletion:(void (^ __nullable)(BOOL finished))completion {
  NSUInteger cardsRemoved = 0;
  for (Card* card in cardsToRemove) {
    CommonCardView *cardToRemoveView = [self getNewCardView:CGRectZero forCard:card];
    NSUInteger cardViewIndex = 0;
    for (CommonCardView *cardView in [self.cardsViews copy]) {
      if ([cardToRemoveView isEqual:cardView]) {
        cardView.matched = YES;
        cardsRemoved++;
        self.cardsGrid.minimumNumberOfCells -= 1;
        self.currentNumberOfActiveCards -= 1;
        BOOL isLastCardView = cardsRemoved == [cardsToRemove count];
        [self animateCardViewRemove:cardView
                     withComplition:isLastCardView ? completion : nil];

      }
      cardViewIndex++;
    }
  }
  
}

- (void)didNotMatchMove:(NSArray *)moveCards
         withCompletion:(void (^ __nullable)(BOOL finished))completion {
  for (Card* card in moveCards) {
    CommonCardView *cardToRemoveView = [self getNewCardView:CGRectZero forCard:card];
    NSUInteger cardViewsCounter = 0;
    for (CommonCardView *cardView in self.cardsViews) {
      if ([cardToRemoveView isEqual:cardView]) {
        [cardView tapAnimationWithCompletion:cardViewsCounter == [moveCards count] ? completion : nil]; //lat card will activate completion
      }
    }
  }
  
}

- (void)addFirstCardsViews {
  if (self.cardsViews) {
    [self.cardsViews enumerateObjectsUsingBlock:^(CommonCardView *cardView, NSUInteger index, BOOL *stop) {
      [cardView removeFromSuperview];
    }];
    self.currentNumberOfActiveCards = 0;
  }
  self.cardsViews = [[NSMutableArray alloc] init];
  for (NSUInteger cardIndex = 0; cardIndex < [self.game numberOfCards]; cardIndex++) {
    Card *card = [self.game cardAtIndex:cardIndex];
    CommonCardView *cardView = [self  getNewCardView:self.deckView.frame forCard:card];
    [self.cardsView addSubview:cardView];
    [self.cardsViews addObject:cardView];
    self.currentNumberOfActiveCards += 1;

  }
}


- (void)dealNewCards:(NSUInteger) numberOfCardsToDeal {
  
  if (numberOfCardsToDeal) {
    while (numberOfCardsToDeal) {
      NSUInteger numberOfCardsAdded = [self.game addCardsFromDeck:1];
      if (!numberOfCardsAdded) return;
      Card *card = [self.game cardAtIndex:[self.game numberOfCards] - 1];
      CommonCardView *cardView = [self  getNewCardView:self.deckView.frame forCard:card];
      [self.cardsView addSubview:cardView];
      [self.cardsViews addObject:cardView];
      numberOfCardsToDeal--;
      self.cardsGrid.minimumNumberOfCells += 1;
      self.currentNumberOfActiveCards += 1;
    }
    [self updateUI];
  }
}


- (void)handleLastMove:(struct MoveResult)moveResult withLastCardViewSelected:(CommonCardView *)selectedCardView {
  if (moveResult.moveOutcome != AlreadyMatched) {
 
    [selectedCardView tapAnimationWithCompletion:^(BOOL finished) {
      switch (moveResult.moveOutcome) {
        case NoMatchingRequired:
        case FlippedCard:
          [self updateScoreLabel];
          break;
        case Matched: {
          [self removeMatchedCardsViews:moveResult.moveCards withCompletion:^(BOOL finished) {
            [self dealNewCards:self.numberOfCardsToAdd];
          }];
          break;
        }
        case DidNotMatch: {
          [self didNotMatchMove:moveResult.moveCards withCompletion:nil] ;
          break;
        }
        default:
          break;
      }
      
    }];
  }
}


- (IBAction)cardsViewTap:(UITapGestureRecognizer *)sender {
  CGPoint touchPoint = [sender locationInView:self.cardsView];
  NSUInteger cardIndex = 0;
  for (CommonCardView *cardView in self.cardsViews) {
    if (CGRectContainsPoint(cardView.frame, touchPoint)) {
      struct MoveResult moveResult = [self.game chooseCardAtIndex:cardIndex];
      [self updateUIwithMoveResult:moveResult withLastCardViewSelected:cardView];
      break;
    };
    cardIndex ++;
  }
  
}

#pragma - View Life Cycle
- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  // when we come from viewDidLoad
  if (CGSizeEqualToSize(self.currentCardsViewsSize, CGSizeZero)) {
    self.currentCardsViewsSize = self.cardsView.frame.size;
//    self.deckViewCard = [[DeckView alloc] initWithFrame:self.deckView.frame];
//    [self.deckView addSubview:self.deckViewCard];
    [self addFirstCardsViews];
    [self setupCardsGrid];
    [self updateUI];
  }
  // if cardsViews size changed
  if (!CGSizeEqualToSize(self.currentCardsViewsSize, self.cardsView.frame.size)) {
    [self setupCardsGrid];
    [self updateUI];
  }
}


- (void)viewDidLoad {
  [super viewDidLoad];
  [self.cardsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cardsViewTap:)]];
  self.currentCardsViewsSize = CGSizeZero;
  self.currentNumberOfActiveCards = 0;
  

  
}

@end

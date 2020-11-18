//
//  GamesCommonViewController.h
//  Machismo2
//
//  Created by Ariel Imber on 12/11/2020.
//


#import <UIKit/UIKit.h>

#import "Deck.h"
#import "CommonCardView.h"
#import "CardMatchingGame.h"
#import "Grid.h"
#import "DeckView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GamesCommonViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *cardsView;
@property (nonatomic, readonly) NSInteger numberOfMatchesMode;
@property (nonatomic, readonly) NSInteger numberOfCardsInGame;
@property (nonatomic, readonly) NSInteger numberOfCardsToAdd;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (strong, nonatomic) NSMutableArray *cardsViews;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) Grid *cardsGrid;
@property (nonatomic, readonly) BOOL drawMatchedCards;
@property (weak, nonatomic) IBOutlet DeckView *deckView;




- (IBAction)restartGameButton:(UIButton *)sender;//abstract
- (Deck *)createDeck; //abstract
- (CommonCardView *)getNewCardView:(CGRect)rect forCard:(Card*)card; //abstract
- (IBAction)cardsViewTap:(UITapGestureRecognizer *)sender; //abstract
- (void)animateCardViewRemove:(CommonCardView *)cardView
               withComplition:(void (^ __nullable)(BOOL finished))completion; //abstract
@end

NS_ASSUME_NONNULL_END

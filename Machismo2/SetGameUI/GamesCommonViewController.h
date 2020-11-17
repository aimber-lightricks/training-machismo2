//
//  GamesCommonViewController.h
//  Machismo2
//
//  Created by Ariel Imber on 12/11/2020.
//


#import <UIKit/UIKit.h>

#import "Deck.h"
#import "CommonCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GamesCommonViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *cardsView;
@property (nonatomic, readonly) NSInteger numberOfMatchesMode;
@property (nonatomic, readonly) NSInteger numberOfCardsInGame;
@property (nonatomic, readonly) NSInteger numberOfCardsToAdd;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;

- (IBAction)restartGameButton:(UIButton *)sender;//abstract
- (Deck *)createDeck; //abstract
- (CommonCardView *)getNewCardView:(CGRect)rect forCard:(Card*)card; //abstract
- (IBAction)cardsViewTap:(UITapGestureRecognizer *)sender; //abstract
- (void)animateCardViewRemove:(CommonCardView *)cardView; //abstract

@end

NS_ASSUME_NONNULL_END

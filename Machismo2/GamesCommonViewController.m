//
//  ViewController.m
//  Machismo2
//
//  Created by Ariel Imber on 10/11/2020.
//

#import "GamesCommonViewController.h"
#import "PlayingCardView.h"

@interface GamesCommonViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end

@implementation GamesCommonViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.playingCardView.rank = 13;
  self.playingCardView.suit = @"♥️";
  self.playingCardView.faceUp = YES;
  // Do any additional setup after loading the view.
}


@end

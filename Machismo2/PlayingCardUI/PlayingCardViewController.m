//
//  PlayingCardViewController.m
//  Machismo2
//
//  Created by Ariel Imber on 10/11/2020.
//

#import "PlayingCardViewController.h"
#import "PlayingCardView.h"

@interface PlayingCardViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end

@implementation PlayingCardViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.playingCardView.rank = 2;
  self.playingCardView.suit = @"♥️";
  self.playingCardView.faceUp = YES;

    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

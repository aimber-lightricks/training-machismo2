//
//  SetGameViewController.m
//  Machismo2
//
//  Created by Ariel Imber on 12/11/2020.
//

#import "SetGameViewController.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.setCardView = [[SetCardView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 8, self.view.bounds.size.height / 8, self.view.bounds.size.width  * 0.4, self.view.bounds.size.width * 0.4 * 1.57)];
  [self.view addSubview:self.setCardView];
  
  
  
  
//                      CGRectMake(self.view.bounds.size.width / 8, self.view.bounds.size.height / 8, self.view.bounds.size.width  * 0.4, self.view.bounds.size.width * 0.4 * 1.57)];
  self.setCardView.cardColor = RED;
  self.setCardView.cardShape = DIMOND;
  self.setCardView.cardFillPattern = SOLID;
  self.setCardView.numberOfShapes = THREE;
  
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

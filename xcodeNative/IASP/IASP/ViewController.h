//
//  ViewController.h
//  IASP
//
//  Created by Heberti Almeida on 03/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableViewMenu;
@property (strong, nonatomic) IBOutlet UIView *buttons;

- (IBAction)didTouchOnButton:(UIButton *)sender;

@end

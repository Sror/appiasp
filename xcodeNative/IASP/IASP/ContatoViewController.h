//
//  ContatoViewController.h
//  IASP
//
//  Created by Heberti Almeida on 08/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContatoViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)submitAction:(id)sender;

@end

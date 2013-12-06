//
//  RevistasViewController.h
//  IASP
//
//  Created by Heberti Almeida on 06/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoboReader.h"

@interface RevistasViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, RoboViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

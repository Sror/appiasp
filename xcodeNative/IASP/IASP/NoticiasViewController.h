//
//  NoticiasViewController.h
//  IASP
//
//  Created by Heberti Almeida on 03/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticiasViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableViewNoticias;

@end

//
//  NoticiasViewController.m
//  IASP
//
//  Created by Heberti Almeida on 03/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import "NoticiasViewController.h"

@interface NoticiasViewController ()

@end


@implementation NoticiasViewController

#pragma mark - View life cicle
#
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:36/255.0 green:74/255.0 blue:128/255.0 alpha:1.0];
    [[self navigationController] setNavigationBarHidden:NO animated:animated];
}

#pragma mark - StatusBar White
#
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark - TableView DataSource
#
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    // Line
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    line.backgroundColor = [UIColor whiteColor];
    line.alpha = 0.3;
    [cell addSubview:line];
    
    // Cell style
    cell.textLabel.text = @"Noticia";
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:19];
//    cell.textLabel.textAlignment = NSTextAlignmentCenter;
//    cell.textLabel.textColor = [UIColor whiteColor];
    
//    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


#pragma mark - TableView Delegate
#
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index %i", indexPath.row);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
//            [self performSegueWithIdentifier:@"noticias" sender:nil];
            break;
        case 2:
            
            break;
        case 3:
            
            break;
            
        default:
            break;
    }
}


@end

//
//  ViewController.m
//  IASP
//
//  Created by Heberti Almeida on 03/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *menuItems;

@end


@implementation ViewController

#pragma mark - View life cicle
#
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _menuItems = @[@"Revistas", @"Notícias", @"Notas e Faltas", @"Contato"];
    _tableViewMenu.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ([self hasFourInchDisplay]) {
            NSLog(@"4inc");
            _tableViewMenu.frame = CGRectMake(0, 394, 320, 174);
        } else {
            _tableViewMenu.frame = CGRectMake(0, 305, 320, 174);
            
            CGRect frame = _buttons.frame;
            frame.origin.y = frame.origin.y - 90;
            _buttons.frame = frame;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)hasFourInchDisplay {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0);
}

#pragma mark - TableView DataSource
#
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    // Line
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    line.backgroundColor = [UIColor whiteColor];
    line.alpha = 0.3;
    [cell addSubview:line];
    
    // Cell style
    cell.textLabel.text = _menuItems[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:19];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


#pragma mark - TableView Delegate
#
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index %li", (long)indexPath.row);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"revistas" sender:nil];
            break;
        case 1:
            [self performSegueWithIdentifier:@"noticias" sender:nil];
            break;
        case 2:
            [self openThisURL:@"https://sigaweb.iasp.br/aluno/"];
            break;
        case 3:
            [self performSegueWithIdentifier:@"contato" sender:nil];
            break;
            
        default:
            break;
    }
}


#pragma mark - Storyboard Segue
#
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"noticias"]){
//        NSIndexPath *indexPath = (NSIndexPath *)sender;
//        UIViewController *noticias = segue.destinationViewController;
    }
    
    // Back button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
}

- (IBAction)didTouchOnButton:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
            [self openThisURL:@"fb://profile/100736133344698" withFallback:@"https://www.facebook.com/face.iasp"];
            break;
        case 2:
            [self openThisURL:@"twitter://user?screen_name=iasp_unasp" withFallback:@"https://twitter.com/iasp_unasp"];
            break;
        case 3:
            [self openThisURL:@"pinterest://user/unaspht/" withFallback:@"http://www.pinterest.com/unaspht/"];
            break;
        case 4:
            [self openThisURL:@"instagram://user?username=iaspht" withFallback:@"http://instagram.com/iaspht"];
            break;
            
        default:
            break;
    }
}

- (void)openThisURL:(NSString *)launchUrl withFallback:(NSString *)fallback
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:launchUrl]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:launchUrl]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:fallback]];
    }
}

- (void)openThisURL:(NSString *)launchUrl
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:launchUrl]];
}

@end

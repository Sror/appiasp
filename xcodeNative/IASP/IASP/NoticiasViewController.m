//
//  NoticiasViewController.m
//  IASP
//
//  Created by Heberti Almeida on 03/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import "NoticiasViewController.h"
#import "NoticiasViewCell.h"
#import "NoticiasDetailsViewController.h"

#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface NoticiasViewController ()

@property (nonatomic, strong) NSArray *apiData;

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
    
//    NSURL *URL = [NSURL URLWithString:@"http://iasp.br/appios/ws/?function=GetLastsNoticiasByCategory&categoryId=2"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
//                                         initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:nil];
//    [operation start];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:animated];
    
    _tableViewNoticias.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getNews];
}

- (void)getNews
{
    NSString *getNews = @"http://iasp.br/appios/ws/?function=GetLastsNoticiasByCategory&categoryId=2";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:getNews parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
        _apiData = (NSArray *)responseObject;
        [self.tableViewNoticias reloadData];
        
    } failure:nil];
}

#pragma mark - TableView DataSource
#
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_apiData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *news = _apiData[indexPath.row];
    
    NSString *text = news[@"title"];
    NSString *preview = news[@"preview"];
    CGSize constraint = CGSizeMake(self.view.frame.size.width - (15 * 2), 20000.0f);
    CGSize sizeText = [text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]
                       constrainedToSize:constraint
                           lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat heightText = MAX(sizeText.height, 25.0f);
    
    //
    CGSize sizePreview = [preview sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]
                             constrainedToSize:constraint
                                 lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat heightPreview = MAX(sizePreview.height, 44.0f);
    
    return heightText + heightPreview + 356;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"Cell";
    NoticiasViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[NoticiasViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    // Line
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    line.backgroundColor = [UIColor whiteColor];
    line.alpha = 0.3;
    [cell addSubview:line];
    
    NSDictionary *news = _apiData[indexPath.row];
    
    // Date
    cell.labelDate.text = news[@"date"];
    
    // Image
    [cell.imagePreview setImageWithURL:[NSURL URLWithString:news[@"image"]]];
    
    // Title
    CGSize constraint = CGSizeMake(self.view.frame.size.width - (15 * 2), 20000.0f);
    CGSize sizeText = [news[@"title"] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]
                                 constrainedToSize:constraint
                                     lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat heightText = MAX(sizeText.height, 25.0f);
    cell.labelTitle.text = news[@"title"];
    
    CGRect titleFrame = cell.labelTitle.frame;
    titleFrame.size.height = heightText;
    cell.labelTitle.frame = titleFrame;
    
    
    // Preview
    cell.labelPreview.frame = CGRectMake(15, CGRectGetHeight(cell.labelTitle.frame)+cell.labelTitle.frame.origin.y+18,
                                         CGRectGetWidth(cell.frame)-30,50);
    cell.labelPreview.text = news[@"preview"];
    [cell.labelPreview sizeToFit];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - TableView Delegate
#
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index %i", indexPath.row);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"noticiasDetails" sender:[NSString stringWithFormat:@"%i", indexPath.row]];
}


#pragma mark - Storyboard Segue
#
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"noticiasDetails"]){
        NoticiasDetailsViewController *noticiasDetails = segue.destinationViewController;
        noticiasDetails.noticiaId = (NSNumber *)sender;
        
        // Back button
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:nil
                                                                                action:nil];
    }
}


@end

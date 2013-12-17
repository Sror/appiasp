//
//  RevistasViewController.m
//  IASP
//
//  Created by Heberti Almeida on 06/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import "RevistasViewController.h"
#import "RevistasViewCell.h"

@interface RevistasViewController ()

@property (nonatomic, strong) NSArray *apiData;
@property (nonatomic, strong) RoboViewController *roboViewController;

@end

@implementation RevistasViewController

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
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    
    // Load local JSON file
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"revistas" ofType:@"json"];
    NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    _apiData = [NSJSONSerialization JSONObjectWithData:[fileContent dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:animated];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_apiData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RevistasViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[RevistasViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSLog(@"%@", _apiData);
    
    NSDictionary *magazine = _apiData[indexPath.row];
    cell.labelTitle.text = magazine[@"title"];
    cell.labelSubtitle.text = magazine[@"subtitle"];
    cell.imagePreview.image = [UIImage imageNamed:magazine[@"cover"]];
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 177;
}


#pragma mark - TableView Delegate
#
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index %li", (long)indexPath.row);
    
    NSDictionary *magazine = _apiData[indexPath.row];
    NSArray *fileName = [magazine[@"pdf"] componentsSeparatedByString:@"."];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName[0] ofType:fileName[1]];
    assert(filePath != nil);
    
    RoboDocument *document = [RoboDocument withDocumentFilePath:filePath password:nil];
    
    if (document != nil) {
        _roboViewController = [[RoboViewController alloc] initWithRoboDocument:document];
        _roboViewController.delegate = self;
        _roboViewController.title = magazine[@"title"];
        
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
        [self.navigationController pushViewController:_roboViewController animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - RoboReader delegate
#
- (void)dismissRoboViewController:(RoboViewController *)viewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end

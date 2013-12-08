//
//  ContatoViewController.m
//  IASP
//
//  Created by Heberti Almeida on 08/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import "ContatoViewController.h"
#import "ContatoViewCell.h"

@interface ContatoViewController ()

@property (nonatomic, strong) NSArray *fields;
@property (nonatomic, strong) NSArray *placeHolders;

@end

@implementation ContatoViewController

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
    
    _fields = @[@"NOME", @"E-MAIL", @"MENSAGEM"];
    _placeHolders = @[@"Escreva seu nome", @"Escreva seu e-mail", @"Escreva sua mensagem"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:animated];
    
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self getNews];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_fields count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ContatoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ContatoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.label.text = _fields[indexPath.row];
    cell.textfield.placeholder = _placeHolders[indexPath.row];
    
    NSDictionary *attibutes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:199/255.0 green:199/255.0 blue:205/255.0 alpha:1], NSFontAttributeName: cell.textView.font};
    NSAttributedString *attbPlaceholder = [[NSAttributedString alloc] initWithString:_placeHolders[indexPath.row] attributes:attibutes];
    cell.textView.attributedPlaceholder = attbPlaceholder;
    
    if (indexPath.row == 2) {
        cell.textView.hidden = NO;
        cell.textfield.hidden = YES;
//        CGRect frame = cell.textView.frame;
//        frame.size.height = 230;
//        cell.textView.frame = frame;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1)
        return 80;
    else
        return 270;
}


#pragma mark - TableView Delegate
#
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"index %i", indexPath.row);
//    
//    NSDictionary *magazine = _apiData[indexPath.row];
//    NSArray *fileName = [magazine[@"pdf"] componentsSeparatedByString:@"."];
//    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName[0] ofType:fileName[1]];
//    assert(filePath != nil);
//    
//    RoboDocument *document = [RoboDocument withDocumentFilePath:filePath password:nil];
//    
//    if (document != nil) {
//        _roboViewController = [[RoboViewController alloc] initWithRoboDocument:document];
//        _roboViewController.delegate = self;
//        _roboViewController.title = magazine[@"title"];
//        
//        [[self navigationController] setNavigationBarHidden:YES animated:YES];
//        [self.navigationController pushViewController:_roboViewController animated:YES];
//    }
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}


- (void)keyboardWasShown:(NSNotification *)notification
{
    
    // Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect frame = _tableView.frame;
    frame.size.height = _tableView.frame.size.height - keyboardSize.height;
    _tableView.frame = frame;
}

@end

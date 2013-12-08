//
//  ContatoViewController.m
//  IASP
//
//  Created by Heberti Almeida on 08/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import "ContatoViewController.h"
#import "ContatoViewCell.h"

#import <ViewUtils/ViewUtils.h>
#import <TSMessages/TSMessage.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>

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
    
    [TSMessage setDefaultViewController:self.navigationController];
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
    cell.textfield.tag = indexPath.row+1;
    
    NSDictionary *attibutes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:199/255.0 green:199/255.0 blue:205/255.0 alpha:1], NSFontAttributeName: cell.textView.font};
    NSAttributedString *attbPlaceholder = [[NSAttributedString alloc] initWithString:_placeHolders[indexPath.row] attributes:attibutes];
    cell.textView.attributedPlaceholder = attbPlaceholder;
    
    if (indexPath.row == 2) {
        
    }
    
    switch (indexPath.row) {
        case 0:
//            cell.textfield.returnKeyType = UIReturnKeyNext;
//            [cell.textfield becomeFirstResponder];
            break;
        case 1:
            cell.textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
            cell.textfield.keyboardType = UIKeyboardTypeEmailAddress;
//            cell.textfield.returnKeyType = UIReturnKeyNext;
            break;
        case 2:
            cell.textView.hidden = NO;
            cell.textfield.hidden = YES;
//            cell.textView.returnKeyType = UIReturnKeyDone;
            break;
            
        default:
            break;
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


//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
//    
//    return YES;
//}

#pragma mark - Keyboard show notification
#
- (void)keyboardWasShown:(NSNotification *)notification
{
    NSLog(@"keyboard");
    
    // Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect frame = _tableView.frame;
    frame.size.height = _tableView.frame.size.height - keyboardSize.height - 64;
    _tableView.frame = frame;
}


#pragma mark - Submit data
#
- (IBAction)submitAction:(id)sender
{
    NSMutableArray *form = [[NSMutableArray alloc] init];
    
    // Get form data
    for (int i = 0; i < [_fields count]; i++) {
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        NSString *field;
        
        if (i == 2) {
            SAMTextView *textview = (id)[cell viewOfClass:[SAMTextView class]];
            field = textview.text;
        } else {
            UITextField *textField = (id)[cell viewOfClass:[UITextField class]];
            field = textField.text;
        }
        
        if ([self validateNotEmpty:field])
            [form addObject:field];
    }
    
    NSLog(@"FORM: %@", form);
    
    if ([form count] == [_fields count]) {
        if ([self validateEmail:form[1]]) {
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSDictionary *parameters = @{
                                         @"name": form[0],
                                         @"email": form[1],
                                         @"message": form[2]
                                         };
            NSLog(@"envia form %@", parameters);
            
            [manager POST:@"http://iasp.br/appios/ws/?function=Contact" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
//                if ([responseObject isEqualToString:@"Enviado com sucesso"]) {
                    [TSMessage showNotificationWithTitle:responseObject
                                                subtitle:nil
                                                    type:TSMessageNotificationTypeSuccess];
//                } else {
//                    [TSMessage showNotificationWithTitle:responseObject
//                                                subtitle:nil
//                                                    type:TSMessageNotificationTypeError];
//                }
                
                NSLog(@"JSON: %@", responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"ERROR: %@", error);
                
                [TSMessage showNotificationWithTitle:@"Erro ao enviar, tente novamente."
                                            subtitle:nil
                                                type:TSMessageNotificationTypeError];
            }];
        }
        else {
            [TSMessage showNotificationWithTitle:@"E-mail inválido"
                                        subtitle:nil
                                            type:TSMessageNotificationTypeError];
        }
    }
    else {
        [TSMessage showNotificationWithTitle:@"Você precisa preencher tudo"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
    }
}

#pragma Validation
#
- (BOOL)validateEmail:(NSString *)candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

- (BOOL)validateNotEmpty:(NSString *)candidate {
    return ([candidate length] == 0) ? NO : YES;
}
@end

//
//  ContatoViewCell.h
//  IASP
//
//  Created by Heberti Almeida on 08/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SAMTextView/SAMTextView.h>

@interface ContatoViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, strong) SAMTextView *textView;

@end

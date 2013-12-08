//
//  ContatoViewCell.m
//  IASP
//
//  Created by Heberti Almeida on 08/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import "ContatoViewCell.h"

@implementation ContatoViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, self.frame.size.width-(15*2), 20)];
        self.label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
        self.label.textColor = [UIColor colorWithRed:13/255.0 green:99/255.0 blue:154/255.0 alpha:1.0];
        
        //
        self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(15, 40, self.frame.size.width-(15*2), 28)];
        self.textfield.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        self.textfield.textColor = [UIColor colorWithRed:79/255.0 green:79/255.0 blue:79/255.0 alpha:1.0];
        self.textfield.tintColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        
        //
        self.textView = [[SAMTextView alloc] initWithFrame:CGRectMake(10, 40, self.frame.size.width-(10*2), 230)];
        self.textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        self.textView.textColor = [UIColor colorWithRed:79/255.0 green:79/255.0 blue:79/255.0 alpha:1.0];
        self.textView.tintColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        self.textView.hidden = YES;
        
        
        [self addSubview:self.label];
        [self addSubview:self.textView];
        [self addSubview:self.textfield];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  NoticiasViewCell.m
//  IASP
//
//  Created by Heberti Almeida on 04/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import "NoticiasViewCell.h"

@implementation NoticiasViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.labelDate = [[UILabel alloc] initWithFrame:CGRectMake(15, 34, CGRectGetWidth(self.frame)-30, 25)];
        self.labelDate.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        self.labelDate.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
        
        //
        self.imagePreview = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                          CGRectGetHeight(self.labelDate.frame)+44,
                                                                          CGRectGetWidth(self.frame),
                                                                          212)];
        self.imagePreview.backgroundColor = [UIColor lightGrayColor];
        
        //
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetHeight(self.imagePreview.frame)+self.imagePreview.frame.origin.y+20, CGRectGetWidth(self.frame)-30, 30)];
        self.labelTitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        self.labelTitle.textColor = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1];
        self.labelTitle.numberOfLines = 0;
        self.labelTitle.lineBreakMode = NSLineBreakByWordWrapping;
        
        
        //
        self.labelPreview = [[UILabel alloc] initWithFrame:CGRectMake(15,
                                                                      CGRectGetHeight(self.labelTitle.frame)+self.labelTitle.frame.origin.y+18,
                                                                      CGRectGetWidth(self.frame)-30,
                                                                      50)];
        self.labelPreview.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        self.labelPreview.textColor = [UIColor colorWithRed:94/255.0 green:94/255.0 blue:94/255.0 alpha:1];
        self.labelPreview.numberOfLines = 0;
        
        
        
        // Separator
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 1, CGRectGetWidth(self.frame), 26)];
        separator.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"separator"]];

        [self addSubview:separator];
        [self addSubview:self.labelDate];
        [self addSubview:self.labelTitle];
        [self addSubview:self.labelPreview];
        [self addSubview:self.imagePreview];
        
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.imagePreview.image = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

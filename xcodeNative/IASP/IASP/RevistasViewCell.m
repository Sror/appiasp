//
//  RevistasViewCell.m
//  IASP
//
//  Created by Heberti Almeida on 06/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import "RevistasViewCell.h"

@implementation RevistasViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(126, 70, 190, 28)];
        self.labelTitle.font = [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:22];
        self.labelTitle.textColor = [UIColor colorWithRed:79/255.0 green:79/255.0 blue:79/255.0 alpha:1.0];
        
        //
        self.labelSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(126, 96, 190, 28)];
        self.labelSubtitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        self.labelSubtitle.textColor = [UIColor colorWithRed:79/255.0 green:79/255.0 blue:79/255.0 alpha:1.0];
        
        //
        self.imagePreview = [[UIImageView alloc] initWithFrame:CGRectMake(18, 18, 100, 141)];
        self.imagePreview.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:self.labelTitle];
        [self addSubview:self.labelSubtitle];
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

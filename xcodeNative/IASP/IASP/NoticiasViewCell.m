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
        
        self.labelDate = [[UILabel alloc] initWithFrame:CGRectMake(15, 34, 290, 25)];
        self.labelDate.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        self.labelDate.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
        
        //
        self.imagePreview = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                          CGRectGetHeight(self.labelDate.frame)+54,
                                                                          CGRectGetWidth(self.frame),
                                                                          212)];
        self.imagePreview.backgroundColor = [UIColor redColor];
        
        //
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15,
                                                                    CGRectGetHeight(self.imagePreview.frame)+self.imagePreview.frame.origin.y+25,
                                                                    290,
                                                                    50)];
        self.labelTitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        self.labelTitle.textColor = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1.0];
        self.labelTitle.numberOfLines = 0;
        
        
        
        
//        UILabel *question = [[UILabel alloc] initWithFrame:CGRectMake(0, ansSpace + 10, CGRectGetWidth(scrollView.frame), 50)];
//        question.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
//        question.text = [wrongAnswer valueForKeyPath:@"data.title"];
//        question.textColor = [UIColor whiteColor];
//        question.lineBreakMode = NSLineBreakByWordWrapping;
//        question.backgroundColor = [UIColor clearColor];
//        question.textAlignment = NSTextAlignmentLeft;
//        question.numberOfLines = 0;
//        [question sizeToFit];
//        CGRect myFrame = question.frame;
//        myFrame = CGRectMake(myFrame.origin.x, myFrame.origin.y, CGRectGetWidth(scrollView.frame), myFrame.size.height);
//        question.frame = myFrame;
        
        [self addSubview:self.labelDate];
        [self addSubview:self.labelTitle];
        [self addSubview:self.imagePreview];
        
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
//    self.moviePosterImage.image = nil;
//    self.movieCollected.image = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

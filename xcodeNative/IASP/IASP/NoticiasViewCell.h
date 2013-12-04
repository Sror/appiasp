//
//  NoticiasViewCell.h
//  IASP
//
//  Created by Heberti Almeida on 04/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticiasViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *labelDate;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelPreview;
@property (nonatomic, strong) UIImageView *imagePreview;

@end

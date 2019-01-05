//
//  FilmStripCell.h
//  RFI Manager by CMiC
//
//  Created by Pulkit Rohilla on 28/10/15.
//  Copyright © 2015 CMiC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleView.h"

@interface FilmStripCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLeading;

@property (weak, nonatomic) IBOutlet CircleView *circleViewCheckMark;

-(void)setSelected:(BOOL)selected;

@end

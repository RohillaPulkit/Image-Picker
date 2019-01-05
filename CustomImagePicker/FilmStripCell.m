//
//  FilmStripCell.m
//  RFI Manager by CMiC
//
//  Created by Pulkit Rohilla on 28/10/15.
//  Copyright © 2015 CMiC. All rights reserved.
//

#import "FilmStripCell.h"

@implementation FilmStripCell

@synthesize constraintTop, constraintBottom, constraintLeading, constraintTrailing,
    circleViewCheckMark;

int margin = 2;

-(void)setSelected:(BOOL)selected{

    if (selected) {
        
        [constraintTop setConstant:margin];
        [constraintBottom setConstant:margin];
        [constraintLeading setConstant:margin];
        [constraintTrailing setConstant:margin];
        [circleViewCheckMark setHidden:NO];
    }
    else{
     
        [constraintTop setConstant:0];
        [constraintBottom setConstant:0];
        [constraintLeading setConstant:0];
        [constraintTrailing setConstant:0];
        [circleViewCheckMark setHidden:YES];
    }
}

@end

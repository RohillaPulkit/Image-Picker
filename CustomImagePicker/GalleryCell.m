//
//  GalleryCell.m
//
//  Created by Pulkit Rohilla on 28/10/15.
//  Copyright © 2015 CMiC. All rights reserved.
//

#import "GalleryCell.h"
#import "FilmStripCell.h"

@implementation GalleryCell{
    
    NSMutableArray *selectedIndexes;
}

@synthesize arrayImages;

- (void)awakeFromNib {
    // Initialization code
    [self.collectionView setAllowsMultipleSelection:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UICollectionView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [arrayImages count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FilmStripCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    NSDictionary *imageDictionary = [arrayImages objectAtIndex:indexPath.row];
    cell.imageView.image = [imageDictionary valueForKey:@"thumbnail"];
    
    if ([selectedIndexes containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
        
        [cell setSelected:YES];
    }
    else
    {
        [cell setSelected:NO];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!selectedIndexes) {
        
        selectedIndexes = [NSMutableArray new];
    }
    
    if ([selectedIndexes containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
        
        [selectedIndexes removeObject:[NSNumber numberWithInteger:indexPath.row]];
    }
    else
    {
        [selectedIndexes addObject:[NSNumber numberWithInteger:indexPath.row]];
    }
    
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    [self.delegate didChangeSelectedIndexes:selectedIndexes];
}

-(void)reloadGallery{
    
    [self.collectionView reloadData];
}

@end

//
//  GalleryCell.h
//
//  Created by Pulkit Rohilla on 28/10/15.
//  Copyright © 2015 CMiC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GalleryDelegate <NSObject>

-(void)didChangeSelectedIndexes:(NSArray *)indexes;

@end

@interface GalleryCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>

@property (assign) id<GalleryDelegate> delegate;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arrayImages;

-(void)reloadGallery;

@end

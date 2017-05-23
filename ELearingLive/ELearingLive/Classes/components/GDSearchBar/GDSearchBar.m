//
//  GDSearchBar.m
//  GDMall
//
//  Created by 陆存璐 on 16/10/31.
//  Copyright © 2016年 guandaokeji. All rights reserved.
//

#import "GDSearchBar.h"
@interface GDSearchBar () <UISearchBarDelegate>

@end

@implementation GDSearchBar

+ (GDSearchBar *)searchBarWithPlaceholder:(NSString *)placeholder {
    GDSearchBar *searchBar = [[GDSearchBar alloc] init];
    searchBar.delegate = searchBar;
    searchBar.placeholder = placeholder;
    searchBar.tintColor = [UIColor lightGrayColor];
    searchBar.contentMode = UIViewContentModeLeft;
    [searchBar setImage:[UIImage imageNamed:@"searchIcon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    UIView *searchBarSub = searchBar.subviews[0];
    
    for (UIView *subView in searchBarSub.subviews) {
        
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            [subView setBackgroundColor:RGB(247, 247, 240)];
        }
        
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subView removeFromSuperview];
        }
    }
    return searchBar;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    !self.searchBarShouldBeginEditingBlock ? : self.searchBarShouldBeginEditingBlock();
    return NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    !self.searchBarTextDidChangedBlock ? : self.searchBarTextDidChangedBlock();
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    !self.searchBarDidSearchBlock ? : self.searchBarDidSearchBlock();
}

@end


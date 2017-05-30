//
//  UISearchBar+Expand.m
//  GDMall
//
//  Created by pc on 16/2/26.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "UISearchBar+Expand.h"

@implementation UISearchBar (Expand)

+ (UISearchBar *)searchBarOfGeneralNavWithPlaceholder:(NSString *)placeholder delegate:(id)delegate canEdit:(BOOL)isEdit
{
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 64)];
    
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.delegate = delegate;
    searchBar.placeholder = placeholder;
    
    for (UIView * subView in  [[searchBar.subviews lastObject] subviews]) {
        
        if ([subView isKindOfClass:[UITextField class]]) {
            subView.backgroundColor = [UIColor colorWithRed:226/255.f green:226/255.f blue:226/255.f alpha:1];
            subView.layer.borderColor = [UIColor colorWithRed:220/255.f green:220/255.f blue:220/255.f alpha:1].CGColor;
            subView.layer.borderWidth = 1;
            subView.layer.cornerRadius = 5;
            subView.layer.masksToBounds = YES;
            
            if (!isEdit) {
                UITextField * textField = (UITextField *)subView;
                textField.enabled = isEdit;
                [textField setValue:[UIColor colorWithRed:55/255.f green:55/255.f blue:55/255.f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
            }
            
            break;
        }
    }
    
    return searchBar;
}


@end

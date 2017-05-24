//
//  THSegmentedPager.m
//  THSegmentedPager
//
//  Created by Hannes Tribus on 25/07/14.
//  Copyright (c) 2014 3Bus. All rights reserved.
//

#import "THSegmentedPager.h"
#import "THSegmentedPageViewControllerDelegate.h"


@interface THSegmentedPager ()

@end

@implementation THSegmentedPager

@synthesize pageViewController = _pageViewController;
@synthesize pages = _pages;

- (NSMutableArray *)pages {
    if (!_pages)_pages = [NSMutableArray new];
    return _pages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Init PageViewController
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.view.frame = CGRectMake(0, 0, self.contentContainer.frame.size.width, self.contentContainer.frame.size.height);
    
    if (!self.disableSlide) {
        [self.pageViewController setDataSource:self];
    }
    
    [self.pageViewController setDelegate:self];
    
    [self.pageViewController.view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [self addChildViewController:self.pageViewController];
    [self.contentContainer addSubview:self.pageViewController.view];
    
    [self.pageControl addTarget:self
                         action:@selector(pageControlValueChanged:)
               forControlEvents:UIControlEventValueChanged];
    
    self.pageControl.backgroundColor = [UIColor whiteColor];
    
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName]=[UIColor blackColor];
    textAttrs[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    [self.pageControl setTitleTextAttributes:textAttrs];
    
    NSMutableDictionary *textAttrsSel=[NSMutableDictionary dictionary];
    textAttrsSel[NSForegroundColorAttributeName]= [UIColor colorWithRed:0.820 green:0.161 blue:0.176 alpha:1.00];;
    textAttrsSel[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
    textAttrsSel[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    [self.pageControl setSelectedTitleTextAttributes:textAttrsSel];
    //self.pageControl.textColor = [UIColor darkTextColor];
   // self.pageControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
   // self.pageControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : WAWA_COLOR_RED};
    self.pageControl.selectionIndicatorColor = [UIColor colorWithRed:0.820 green:0.161 blue:0.176 alpha:1.00];;
    self.pageControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
   // self.pageControl.selectedTextColor = WAWA_COLOR_RED;
    self.pageControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.pageControl.selectionIndicatorHeight = 2;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.pages count]>0) {
        [self setSelectedPageIndex:[self.pageControl selectedSegmentIndex] animated:animated];
    }
    [self updateTitleLabels];
}

#pragma mark - Cleanup

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setup

- (void)setupPagesFromStoryboardWithIdentifiers:(NSArray *)identifiers {
    if (self.storyboard) {
        for (NSString *identifier in identifiers) {
            UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
            if (viewController) {
                [self.pages addObject:viewController];
            }
        }
    }
}

- (void)updateTitleLabels {
    [self.pageControl setSectionTitles:[self titleLabels]];
}

- (NSArray *)titleLabels {
    NSMutableArray *titles = [NSMutableArray new];
    for (UIViewController *vc in self.pages) {
        if ([vc conformsToProtocol:@protocol(THSegmentedPageViewControllerDelegate)] && [vc respondsToSelector:@selector(viewControllerTitle)] && [((UIViewController<THSegmentedPageViewControllerDelegate> *)vc) viewControllerTitle]) {
            [titles addObject:[((UIViewController<THSegmentedPageViewControllerDelegate> *)vc) viewControllerTitle]];
        } else {
            [titles addObject:vc.title ? vc.title : NSLocalizedString(@"NoTitle",@"")];
        }
    }
    return [titles copy];
}

- (void)setPageControlHidden:(BOOL)hidden animated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.25f : 0.f animations:^{
        if (hidden) {
            self.pageControl.alpha = 0.0f;
        } else {
            self.pageControl.alpha = 1.0f;
        }
    }];
    [self.pageControl setHidden:hidden];
    [self.view setNeedsLayout];
}

- (UIViewController *)selectedController {
    
    return self.pages[[self.pageControl selectedSegmentIndex]];
}

- (void)setSelectedPageIndex:(NSUInteger)index animated:(BOOL)animated {
    if (index < [self.pages count]) {
        [self.pageControl setSelectedSegmentIndex:index animated:animated];
        [self.pageViewController setViewControllers:@[self.pages[index]]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:animated
                                         completion:NULL];
    }
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (self.disableSlide) {
        return nil;
    }
    
    NSUInteger index = [self.pages indexOfObject:viewController];
    
    if ((index == NSNotFound) || (index == 0)) {
        return nil;
    }
    
    return self.pages[--index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (self.disableSlide) {
        return nil;
    }
    
    NSUInteger index = [self.pages indexOfObject:viewController];
    
    if ((index == NSNotFound)||(index+1 >= [self.pages count])) {
        return nil;
    }
    
    return self.pages[++index];
}

- (void)pageViewController:(UIPageViewController *)viewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (!completed){
        return;
    }
    
    [self.pageControl setSelectedSegmentIndex:[self.pages indexOfObject:[viewController.viewControllers lastObject]] animated:YES];
}

#pragma mark - Callback

- (void)pageControlValueChanged:(id)sender {
    UIPageViewControllerNavigationDirection direction = [self.pageControl selectedSegmentIndex] > [self.pages indexOfObject:[self.pageViewController.viewControllers lastObject]] ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    [self.pageViewController setViewControllers:@[[self selectedController]]
                                      direction:direction
                                       animated:YES
                                     completion:NULL];
}

@end
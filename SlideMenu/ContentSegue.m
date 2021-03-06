//
//  ContentSegue.m
//  SlideMenu
//
//  Created by Lin Dennis on 13/8/7.
//  Copyright (c) 2013年 Lin Dennis. All rights reserved.
//

#import "ContentSegue.h"
#import "MenuRootViewController.h"
#import "ContentControllerDelegate.h"
@implementation ContentSegue

-(void)perform
{
    MenuRootViewController *rootController = self.sourceViewController;
    UIViewController *contentController = self.destinationViewController;
    UIViewController *tmpController = rootController.CurrentContentController;
    
    if(tmpController != nil)
    {
        contentController.view.frame = CGRectMake(tmpController.view.frame.origin.x, tmpController.view.frame.origin.y,tmpController.view.frame.size.width, tmpController.view.frame.size.height);
        for(int i = 0;i < tmpController.view.gestureRecognizers.count;i++)
            [tmpController.view removeGestureRecognizer:tmpController.view.gestureRecognizers[i]];
    }
    else
    {
        CGRect bounds = rootController.view.bounds;
        contentController.view.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    }
    [contentController willMoveToParentViewController:rootController];
    [rootController addChildViewController:contentController];
    [rootController.view addSubview:contentController.view];
    [contentController didMoveToParentViewController:rootController];
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:rootController action:@selector(panContentView:)];
    [contentController.view addGestureRecognizer:gesture];
    
    [rootController setCurrentContentController:contentController];
    
    if([contentController respondsToSelector:@selector(setParentViewController:)])
    {
        [contentController performSelector:@selector(setParentViewController:) withObject:rootController];
    }
    
    if(tmpController != nil)
    {
        [tmpController.view removeFromSuperview];
        [tmpController removeFromParentViewController];
    }
    
    [rootController closeMenu];
}

@end

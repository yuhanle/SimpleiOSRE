//
//  IQYUITabbarViewHook.m
//  antreesDylib
//
//  Created by yuhanle on 2018/4/23.
//  Copyright © 2018年 tilink. All rights reserved.
//

#import "antreesDylib.h"

@interface TabbarView

@property (nonatomic, strong) NSString * tabbarImageArray;
@property (nonatomic, strong) NSString * tabbarTitleArray;

@end

CHDeclareClass(TabbarView)

CHOptimizedMethod0(self, NSArray*, TabbarView, tabbarImageArray){
    //get origin value
    NSMutableArray* originArray = CHSuper(0, TabbarView, tabbarImageArray).mutableCopy;
    
    [originArray removeLastObject];
    
    //change the value
    return originArray.copy;
}

CHOptimizedMethod0(self, NSArray*, TabbarView, tabbarTitleArray){
    //get origin value
    NSMutableArray* originArray = CHSuper(0, TabbarView, tabbarTitleArray).mutableCopy;
    
    [originArray removeLastObject];
    
    //change the value
    return originArray.copy;
}

CHConstructor {
    CHLoadLateClass(TabbarView);
    CHHook0(TabbarView, tabbarImageArray);
    CHHook0(TabbarView, tabbarTitleArray);
}

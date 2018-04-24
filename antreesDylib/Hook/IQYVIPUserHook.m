//
//  IQYVIPUserHook.m
//  antreesDylib
//
//  Created by yuhanle on 2018/4/23.
//  Copyright © 2018年 tilink. All rights reserved.
//

#import "antreesDylib.h"

@interface PumaPlayerViewController

- (void)setAdSDKState:(int)arg1 isVertical:(BOOL)arg2;
- (void)OnAdReadyWithAdId:(int)arg1;

- (void)jumpAd;
- (void)onAdJump;
- (void)OnAdPrepared;

- (void)updateAdProgress:(int)arg1 progress:(unsigned int)arg2;

@end

CHDeclareClass(PumaPlayerViewController)
CHOptimizedMethod2(self, void, PumaPlayerViewController, setAdSDKState, int, arg1, isVertical, BOOL, arg2){
    NSLog(@"设置广告事件: state=%@, arg2=%@", @(arg1), @(arg2));
    CHSuper2(PumaPlayerViewController, setAdSDKState, 0, isVertical, arg2);
}

CHOptimizedMethod1(self, void, PumaPlayerViewController, OnAdReadyWithAdId, int, arg1){
    NSLog(@"获取广告标识: %@", @(arg1));
    CHSuper1(PumaPlayerViewController, OnAdReadyWithAdId, arg1);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self jumpAd];
    });
}

CHOptimizedMethod0(self, void, PumaPlayerViewController, jumpAd){
    CHSuper0(PumaPlayerViewController, jumpAd);
}

CHOptimizedMethod0(self, void, PumaPlayerViewController, onAdJump){
    NSLog(@"用户点击跳过广告");
    CHSuper0(PumaPlayerViewController, onAdJump);
}

CHOptimizedMethod0(self, void, PumaPlayerViewController, OnAdPrepared){
    NSLog(@"广告准备好播放");
    CHSuper0(PumaPlayerViewController, OnAdPrepared);
    CHSuper0(PumaPlayerViewController, jumpAd);
}

CHOptimizedMethod2(self, void, PumaPlayerViewController, updateAdProgress, int, arg1, progress, int, arg2){
    NSLog(@"正在播放广告: 广告进度=%@, 进度=%@", @(arg1), @(arg2));
    CHSuper2(PumaPlayerViewController, updateAdProgress, arg1, progress, arg2);
}

CHConstructor{
    CHLoadLateClass(PumaPlayerViewController);
    CHHook2(PumaPlayerViewController, setAdSDKState, isVertical);
    CHHook1(PumaPlayerViewController, OnAdReadyWithAdId);
    CHHook0(PumaPlayerViewController, jumpAd);
    CHHook0(PumaPlayerViewController, onAdJump);
    CHHook0(PumaPlayerViewController, OnAdPrepared);
    CHHook2(PumaPlayerViewController, updateAdProgress, progress);
}

@interface PlayerController

- (void)setAdSDKState:(int)arg1 isVertical:(BOOL)arg2;

@end

CHDeclareClass(PlayerController)
CHOptimizedMethod2(self, void, PlayerController, setAdSDKState, int, arg1, isVertical, BOOL, arg2){
    NSLog(@"更新广告事件: state=%@, arg2=%@", @(arg1), @(arg2));
    CHSuper2(PlayerController, setAdSDKState, 0, isVertical, arg2);
}

CHConstructor{
    CHLoadLateClass(PlayerController);
    CHHook2(PlayerController, setAdSDKState, isVertical);
}

@interface QYAVPlayerController

- (void)setAdSDKState;
- (void)jumpAd;

@end

CHDeclareClass(QYAVPlayerController)
CHOptimizedMethod0(self, void, QYAVPlayerController, setAdSDKState){
    NSLog(@"更新广告事件");
    CHSuper0(QYAVPlayerController, setAdSDKState);

    [self jumpAd];
}

CHOptimizedMethod0(self, void, QYAVPlayerController, jumpAd){
    CHSuper0(QYAVPlayerController, jumpAd);
}

CHConstructor{
    CHLoadLateClass(QYAVPlayerController);
    CHHook0(QYAVPlayerController, setAdSDKState);
    CHHook0(QYAVPlayerController, jumpAd);
}

@interface UserInfo

@property (nonatomic, assign) BOOL isVIP;

@end

CHDeclareClass(UserInfo)
CHOptimizedMethod0(self, BOOL, UserInfo, isVIP){
    //get origin value
    BOOL originValue = CHSuper(0, UserInfo, isVIP);
    NSLog(@"初始会员值：%@", originValue ? @"大会员" : @"穷逼");
    //change the value
    return YES;
}

CHConstructor{
    CHLoadLateClass(UserInfo);
    CHHook0(UserInfo, isVIP);
}

@interface LCBPlayerCommon

@property (nonatomic, assign) BOOL isVIP;

@end

CHDeclareClass(LCBPlayerCommon)
CHOptimizedMethod0(self, BOOL, LCBPlayerCommon, isVIP){
    //get origin value
    BOOL originValue = CHSuper(0, LCBPlayerCommon, isVIP);
    NSLog(@"初始会员值：%@", originValue ? @"大会员" : @"穷逼");
    //change the value
    return YES;
}

CHConstructor{
    CHLoadLateClass(LCBPlayerCommon);
    CHHook0(LCBPlayerCommon, isVIP);
}

@interface QYOfflineBaseCommonUtil

@property (nonatomic, assign) BOOL isVIP;

@end

CHDeclareClass(QYOfflineBaseCommonUtil)
CHOptimizedMethod0(self, BOOL, QYOfflineBaseCommonUtil, isVIP){
    //get origin value
    BOOL originValue = CHSuper(0, QYOfflineBaseCommonUtil, isVIP);
    NSLog(@"初始会员值：%@", originValue ? @"大会员" : @"穷逼");
    //change the value
    return YES;
}

CHConstructor{
    CHLoadLateClass(QYOfflineBaseCommonUtil);
    CHHook0(QYOfflineBaseCommonUtil, isVIP);
}

@interface QYPushVideoPlayerDMCProxy

@property (nonatomic, assign) BOOL isVIP;

@end

CHDeclareClass(QYPushVideoPlayerDMCProxy)
CHOptimizedMethod0(self, BOOL, QYPushVideoPlayerDMCProxy, isVIP){
    //get origin value
    BOOL originValue = CHSuper(0, QYPushVideoPlayerDMCProxy, isVIP);
    NSLog(@"初始会员值：%@", originValue ? @"大会员" : @"穷逼");
    //change the value
    return YES;
}

CHConstructor{
    CHLoadLateClass(QYPushVideoPlayerDMCProxy);
    CHHook0(QYPushVideoPlayerDMCProxy, isVIP);
}

@interface QRVIPUserInfoModel

@property (nonatomic, assign) long long VIPLevel;
@property (nonatomic, assign) BOOL isVIP;

@end

CHDeclareClass(QRVIPUserInfoModel)
CHOptimizedMethod0(self, BOOL, QRVIPUserInfoModel, isVIP){
    //get origin value
    BOOL originValue = CHSuper(0, QRVIPUserInfoModel, isVIP);
    NSLog(@"初始会员值：%@", originValue ? @"大会员" : @"穷逼");
    //change the value
    return YES;
}
CHOptimizedMethod0(self, long long, QRVIPUserInfoModel, VIPLevel){
    //get origin value
    BOOL originValue = CHSuper(0, QRVIPUserInfoModel, VIPLevel);
    NSLog(@"初始会员值：%@", originValue ? @"大会员" : @"穷逼");
    //change the value
    return 3;
}

CHConstructor{
    CHLoadLateClass(QRVIPUserInfoModel);
    CHHook0(QRVIPUserInfoModel, isVIP);
    CHHook0(QRVIPUserInfoModel, VIPLevel);
}

@interface QYOfflineBaseModelUtil

@property (nonatomic, assign) BOOL isVIP;

@end

CHDeclareClass(QYOfflineBaseModelUtil)
CHOptimizedMethod0(self, BOOL, QYOfflineBaseModelUtil, isVIP){
    //get origin value
    BOOL originValue = CHSuper(0, QYOfflineBaseModelUtil, isVIP);
    NSLog(@"初始会员值：%@", originValue ? @"大会员" : @"穷逼");
    //change the value
    return YES;
}

CHConstructor{
    CHLoadLateClass(QYOfflineBaseModelUtil);
    CHHook0(QYOfflineBaseModelUtil, isVIP);
}

@interface QYOfflineCellInfoView

@property (nonatomic, assign) BOOL isVIP;

@end

CHDeclareClass(QYOfflineCellInfoView)
CHOptimizedMethod0(self, BOOL, QYOfflineCellInfoView, isVIP){
    //get origin value
    BOOL originValue = CHSuper(0, QYOfflineCellInfoView, isVIP);
    NSLog(@"初始会员值：%@", originValue ? @"大会员" : @"穷逼");
    //change the value
    return YES;
}

CHConstructor{
    CHLoadLateClass(QYOfflineCellInfoView);
    CHHook0(QYOfflineCellInfoView, isVIP);
}

@interface QYOfflineParallelListModel

@property (nonatomic, assign) BOOL isVIP;

@end

CHDeclareClass(QYOfflineParallelListModel)
CHOptimizedMethod0(self, BOOL, QYOfflineParallelListModel, isVIP){
    //get origin value
    BOOL originValue = CHSuper(0, QYOfflineParallelListModel, isVIP);
    NSLog(@"初始会员值：%@", originValue ? @"大会员" : @"穷逼");
    //change the value
    return YES;
}

CHConstructor{
    CHLoadLateClass(QYOfflineParallelListModel);
    CHHook0(QYOfflineParallelListModel, isVIP);
}

@interface QYOfflineProgressView

@property (nonatomic, assign) BOOL isVIP;

@end

CHDeclareClass(QYOfflineProgressView)
CHOptimizedMethod0(self, BOOL, QYOfflineProgressView, isVIP){
    //get origin value
    BOOL originValue = CHSuper(0, QYOfflineProgressView, isVIP);
    NSLog(@"初始会员值：%@", originValue ? @"大会员" : @"穷逼");
    //change the value
    return YES;
}

CHConstructor{
    CHLoadLateClass(QYOfflineProgressView);
    CHHook0(QYOfflineProgressView, isVIP);
}

@interface QYPPPGCCircleData

@property (nonatomic, assign) BOOL isVIP;

@end

CHDeclareClass(QYPPPGCCircleData)
CHOptimizedMethod0(self, BOOL, QYPPPGCCircleData, isVIP){
    //get origin value
    BOOL originValue = CHSuper(0, QYPPPGCCircleData, isVIP);
    NSLog(@"初始会员值：%@", originValue ? @"大会员" : @"穷逼");
    //change the value
    return YES;
}

CHConstructor{
    CHLoadLateClass(QYPPPGCCircleData);
    CHHook0(QYPPPGCCircleData, isVIP);
}

@interface QYSVODTipView

@property (nonatomic, assign) BOOL isVIP;

@end

CHDeclareClass(QYSVODTipView)
CHOptimizedMethod0(self, BOOL, QYSVODTipView, isVIP){
    //get origin value
    BOOL originValue = CHSuper(0, QYSVODTipView, isVIP);
    NSLog(@"初始会员值：%@", originValue ? @"大会员" : @"穷逼");
    //change the value
    return YES;
}

CHConstructor{
    CHLoadLateClass(QYSVODTipView);
    CHHook0(QYSVODTipView, isVIP);
}

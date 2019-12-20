//
//  UIDevice+FMInfo.h
//  JYExtension
//
//  Created by Dely on 2017/8/9.
//  Copyright © 2017年 Dely. All rights reserved.
//

/*
 *获取设备信息的相关方法
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NetworkType) {
    NetworkTypeUnknown = -1, //
    NetworkType2G = 0,
    NetworkType3G,
    NetworkType4G,
    NetworkTypeWifi,
    NetworkTypeLTE
};

@interface UIDevice (FMInfo)


// 设备的名称
+ (NSString *)fm_getDeviceName;

// 设备类型 iPhone 7 Plus 等等
+ (NSString *)fm_getDeviceTypeName;

// 获取BundleID
+ (NSString *)fm_getBundleID;

// app版本号
+ (NSString *)fm_getAPPVerion;

// app_build版本号
+ (NSString *)fm_getAPPBuildVersion;

// app名字
+ (NSString *)fm_getAPPName;

// 设备UUID
+ (NSString *)fm_getiPhoneUUID;

// 设备系统版本
+ (NSString *)fm_getSystemVersion;

// 获取电池剩余电量
+ (CGFloat)fm_getBatteryLevel;

// 获取手机IP
+ (NSString *)fm_getDeviceIPAdress;

// 获取总内存大小(单位：字节 B)
+ (long long)fm_getTotalMemorySize;

// 获取当前可用内存(单位：字节 B)
+ (long long)fm_getAvailableMemorySize;

// 获取总磁盘容量(单位：字节 B)
+ (long long)fm_getTotalDiskSize;

// 获取可用磁盘容量(单位：字节 B)
+ (long long)fm_getAvailableDiskSize;

// 获取精准电池电量
+ (CGFloat)fm_getCurrentBatteryLevel;

// 获取当前语言
+ (NSString *)fm_getDeviceLanguage;

// 获取运营商名称
+ (NSString *)fm_getCarrierName;

// 获取网络类型(确保statusbar没有隐藏，否则获取不到）
+ (NetworkType)fm_getNetworkType;

// 获取网络类型名称(确保statusbar没有隐藏，否则获取不到）
+ (NSString *)fm_getNetworkTypeName;

/** mac地址 */
+ (NSString *)fm_macAddress;

/** ram的size */
+ (NSUInteger)fm_ramSize;

/** cpu个数 */
+ (NSUInteger)fm_cpuNumber;

/** 系统的版本号 */
+ (NSString *)fm_systemVersion;

/** 是否有摄像头 */
+ (BOOL)fm_hasCamera;

/** 获取手机内存总量, 返回的是字节数 */
+ (NSUInteger)fm_totalMemoryBytes;

/** 获取手机可用内存, 返回的是字节数 */
+ (NSUInteger)fm_freeMemoryBytes;

/** 获取手机硬盘总空间, 返回的是字节数 */
+ (NSUInteger)fm_totalDiskSpaceBytes;

/** 获取手机硬盘空闲空间, 返回的是字节数 */
+ (NSUInteger)fm_freeDiskSpaceBytes;
/// 判断刘海屏，返回YES表示是刘海屏
+ (BOOL)fm_isNotchScreen;
@end

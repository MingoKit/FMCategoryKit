//
//  UIDevice+FMInfo.m
//  JYExtension
//
//  Created by Dely on 2017/8/9.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "UIDevice+FMInfo.h"
#import "sys/utsname.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <mach/mach.h>
#import <objc/runtime.h>
#import <sys/mount.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#include <sys/types.h>
#include <sys/sysctl.h>
#import <sys/socket.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/stat.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>

@implementation UIDevice (FMInfo)


// 设备的名称
+ (NSString*)fm_getDeviceName {
    return [UIDevice currentDevice].name;
}

// 设备类型
+ (NSString *)fm_getDeviceTypeName{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])    return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"])    return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"])    return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,6"])    return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone12,1"])    return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"])    return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"])    return @"iPhone 11 Pro Max";

    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (Cellular)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7-inch (WiFi)";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7-inch (Cellular)";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9-inch (WiFi)";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9-inch (Cellular)";
    
    if ([platform isEqualToString:@"i386"])         return [UIDevice currentDevice].model;
    if ([platform isEqualToString:@"x86_64"])       return [UIDevice currentDevice].model;
    
    return platform;
}

// 获取BundleID
+ (NSString*)fm_getBundleID{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

// 获取app版本号
+ (NSString*)fm_getAPPVerion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

// app_build版本号
+ (NSString*)fm_getAPPBuildVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

// app名字
+ (NSString*)fm_getAPPName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

// 设备UUID
+ (NSString*)fm_getiPhoneUUID{
    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
}
// 设备操作系统版本
+ (NSString*)fm_getSystemVersion{
    return [[UIDevice currentDevice] systemVersion];
}

// 获取电池剩余电量
+ (CGFloat)fm_getBatteryLevel {
    return [UIDevice currentDevice].batteryLevel;
}

// 获取手机IP
+ (NSString*)fm_getDeviceIPAdress {
    NSString *address;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) { // 0 表示获取成功
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

// 获取总内存大小
+ (long long)fm_getTotalMemorySize {
    return [NSProcessInfo processInfo].physicalMemory;
}

// 获取当前可用内存
+ (long long)fm_getAvailableMemorySize {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

// 获取总磁盘容量
+ (long long)fm_getTotalDiskSize{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0){
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace;
}

// 获取可用磁盘容量
+ (long long)fm_getAvailableDiskSize{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0){
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}

// 获取精准电池电量
+ (CGFloat)fm_getCurrentBatteryLevel {
    UIApplication *app = [UIApplication sharedApplication];
    if (app.applicationState == UIApplicationStateActive||app.applicationState==UIApplicationStateInactive) {
        Ivar ivar=  class_getInstanceVariable([app class],"_statusBar");
        id status  = object_getIvar(app, ivar);
        for (id aview in [status subviews]) {
            int batteryLevel = 0;
            for (id bview in [aview subviews]) {
                if ([NSStringFromClass([bview class]) caseInsensitiveCompare:@"UIStatusBarBatteryItemView"] == NSOrderedSame&&[[[UIDevice currentDevice] systemVersion] floatValue] >=6.0) {
                    
                    Ivar ivar=  class_getInstanceVariable([bview class],"_capacity");
                    if(ivar) {
                        batteryLevel = ((int (*)(id, Ivar))object_getIvar)(bview, ivar);
                        if (batteryLevel > 0 && batteryLevel <= 100) {
                            return batteryLevel;
                            
                        } else {
                            return 0;
                        }
                    }
                }
            }
        }
    }
    return 0;
}

// 获取当前语言
+ (NSString*)fm_getDeviceLanguage {
    NSArray *languageArray = [NSLocale preferredLanguages];
    return [languageArray firstObject];
}

// 获取运营商名称
+ (NSString*)fm_getCarrierName {
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    return  [carrier carrierName];
}

// 获取网络类型
+ (NetworkType)fm_getNetworkType {
    
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue]) {
        case 0:
            return NetworkTypeUnknown;
            break;
            
        case 1:
            return NetworkType2G;
            break;
            
        case 2:
            return NetworkType3G;
            break;
            
        case 3:
            return NetworkType4G;
            break;
            
        case 4:
            return NetworkTypeLTE;
            break;
            
        case 5:
            return NetworkTypeWifi;
            break;
    }
    
    return NetworkTypeUnknown;
}

// 获取网络类型名称
+ (NSString*)fm_getNetworkTypeName{
    NetworkType type = [UIDevice fm_getNetworkType];
    if (type == NetworkType4G) {
        return @"4G";
    }else if (type == NetworkTypeWifi) {
        return @"Wifi";
    }else if (type == NetworkType2G) {
        return @"2G";
    }else if (type == NetworkType3G) {
        return @"3G";
    }else if (type == NetworkTypeLTE) {
        return @"LTE";
    }
    return @"无服务";
}

+ (NSString *)fm_macAddress {
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (NSString *)fm_systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
+ (BOOL)fm_hasCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (NSUInteger)getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

+ (NSUInteger)fm_ramSize {
    return [self getSysInfo:HW_MEMSIZE];
}

+ (NSUInteger)fm_cpuNumber {
    return [self getSysInfo:HW_NCPU];
}


+ (NSUInteger)fm_totalMemoryBytes
{
    return [self getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)fm_freeMemoryBytes
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}

+ (NSUInteger)fm_freeDiskSpaceBytes
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *number = attributes[NSFileSystemFreeSize];
    return [number unsignedIntegerValue];
}

+ (NSUInteger)fm_totalDiskSpaceBytes
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *number = attributes[NSFileSystemSize];
    return [number unsignedIntegerValue];
}


/// 判断刘海屏，返回YES表示是刘海屏
+ (BOOL)fm_isNotchScreen  {
    /*
    https://kangzubin.com/iphonex-detect/
    iPhone X 对应的 device mode 为 iPhone10,3 和 iPhone10,6，而今年最新发布 iPhone XS 对应 iPhone11,2，iPhone XS Max 对应 iPhone11,4 和 iPhone11,6，iPhone XR 对应 iPhone11,8，完整的 device mode 数据参考这里：
     https://www.theiphonewiki.com/wiki/Models
    */
    static BOOL isiPhoneX = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
#if TARGET_IPHONE_SIMULATOR
        // 获取模拟器所对应的 device model
        NSString *model = NSProcessInfo.processInfo.environment[@"SIMULATOR_MODEL_IDENTIFIER"];
#else
        // 获取真机设备的 device model
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *model = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
#endif
        // 判断 device model 是否为 "iPhone10,3" 和 "iPhone10,6" 或者以 "iPhone11," 开头
        // 如果是，就认为是 iPhone X
        isiPhoneX = [model isEqualToString:@"iPhone10,3"] || [model isEqualToString:@"iPhone10,6"] || [model hasPrefix:@"iPhone11,"];
    });
    
    return isiPhoneX;
}

@end

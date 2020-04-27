//
//  UIViewController+FMAdd.m
//  FMCategoryKit
//
//  Created by mingo on 2019/4/13.
//

#import "UIViewController+FMAdd.h"
#define kNavigationBarDefaultTitleColor [UIColor whiteColor]
#define kNavigationBarDefaultTitleFont  [UIFont systemFontOfSize:16.0f]
static NSString *ktypeKey = @"ktypeKey"; //那么的key
static NSString *knameKey = @"knameKey"; //那么的key

#import <objc/runtime.h>

typedef void (^ActionBlock)(void);
@interface UIButton (ZPButton)
/**
 *  UIButton+Block
 *  @param controlEvent 触摸事件
 *  @param action 执行的方法
 */
- (void)handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;
@end

static char overviewKey;
@implementation UIButton (ZPButton)
- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}
- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}
@end


@implementation UIViewController (FMAdd)

#pragma mark - 获取当前屏幕显示的VC
+ (UIViewController *)fm_getCurrentViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    }else if([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    }else{
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}


- (void)setLeftNavigationBarToBack {
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
}

/**
 *  设置左侧Navigationbar为“返回”(使用leftbarbutton)
 *
 *  @param block 点击时执行的block代码
 */
- (void)setLeftNavigationBarToBackWithBlock:(void (^)(void))block {
    [self setNavigationBar:NavigationBarPositionLeft withImageName:@"nav_icon_return" touched:^{
        if (block) {
            block();
        }
    }];
}

/**
 *  为左侧后退Navigationbar增加确认提示框
 */
- (void)setLeftNavigationBarToBackWithConfirmDialog {
    __weak typeof(self) weakself = self;
    [self setNavigationBar:NavigationBarPositionLeft withImageName:@"nav_icon_return" touched:^{
        [weakself.view endEditing:YES];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确认要放弃编辑吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }]];
        
        [weakself presentViewController:alert animated:YES completion:nil];
    }];
}

- (void)setNavigationBar:(NavigationBarPosition)position withText:(NSString *)text touched:(void (^)(void))block {
    [self setNavigationBar:position withText:text withColor:kNavigationBarDefaultTitleColor touched:block];
}

- (void)setNavigationBar:(NavigationBarPosition)position withText:(NSString *)text withColor:(UIColor *)color touched:(void (^)(void))block {
    [self setNavigationBar:position withText:text withColor:color withFont:kNavigationBarDefaultTitleFont touched:block];
}

- (void)setNavigationBar:(NavigationBarPosition)position withText:(NSString *)text withColor:(UIColor *)color withFont:(UIFont *)font touched:(void (^)(void))block {
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateNormal];
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    CGSize size = CGSizeMake(MAXFLOAT, statusBarRect.size.height + 44.0);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:btn.titleLabel.font,NSFontAttributeName,nil];
    CGSize  actualsize =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    
    btn.frame = CGRectMake(0.0f, 0.0f, actualsize.width+16, 30);
    
    if (block) {
        [btn handleControlEvent:UIControlEventTouchUpInside withBlock:block];
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-15;
    
    if (NavigationBarPositionRight == position) {
        self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:negativeSpacer,item, nil];
    }
    else if(NavigationBarPositionLeft == position){
        self.navigationItem.leftBarButtonItems=[NSArray arrayWithObjects:negativeSpacer,item, nil];
    }
}

/**
 *  设置NavigationBar（图片）
 *
 *  @param position  位置
 *  @param imageName 图片名称
 *  @param block     点击后执行的代码
 */
- (void)setNavigationBar:(NavigationBarPosition)position withImageName:(NSString *)imageName touched:(void (^)(void))block {
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *img = [UIImage imageNamed:imageName];
    [btn setImage:img forState:UIControlStateNormal];
    
    CGFloat width = MAX(img.size.width, 22);
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    btn.frame = CGRectMake(0.0f, 0.0f, width, statusBarRect.size.height + 44.0);
    
    if (block) {
        [btn handleControlEvent:UIControlEventTouchUpInside withBlock:block];
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -8;
    
    if (NavigationBarPositionRight == position) {
        self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:negativeSpacer,item, nil];
    }
    else if(NavigationBarPositionLeft == position){
        self.navigationItem.leftBarButtonItems=[NSArray arrayWithObjects:negativeSpacer,item, nil];
    }
}
/**
 *  设置NavigationBar（图片）
 *
 *  @param position  位置
 *  @param imageName 图片名称
 *  @param block     点击后执行的代码
 */
- (void)setNavigationBar:(NavigationBarPosition)position withImageName:(NSString *)imageName spacing:(NSInteger)spacing touched:(void (^)(void))block {
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    btn.frame = CGRectMake(0.0f, 0.0f, 44.0f, statusBarRect.size.height + 44.0);
    
    if (block) {
        [btn handleControlEvent:UIControlEventTouchUpInside withBlock:block];
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    negativeSpacer.width=-7;
    negativeSpacer.width = -(spacing);
    
    if (NavigationBarPositionRight == position) {
        self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:negativeSpacer,item, nil];
    }
    else if(NavigationBarPositionLeft == position){
        self.navigationItem.leftBarButtonItems=[NSArray arrayWithObjects:negativeSpacer,item, nil];
    }
}

/**
 *  设置NavigationBar隐藏或显示
 *
 *  @param position 位置
 *  @param hidden   YES：隐藏 NO：显示
 */
- (void)hiddenNavigationBar:(NavigationBarPosition)position hidden:(BOOL)hidden {
    NSArray *buttonArray = nil;
    
    if (NavigationBarPositionLeft == position) {
        buttonArray = self.navigationItem.leftBarButtonItems;
        self.navigationItem.hidesBackButton = hidden;
    }else if(NavigationBarPositionRight == position){
        buttonArray = self.navigationItem.rightBarButtonItems;
    }
    
    if (buttonArray != nil && buttonArray.count > 0) {
        for (UIBarButtonItem *btn in buttonArray) {
            btn.customView.hidden = hidden;
        }
    }
}

- (void)popToViewController:(Class)viewControllerClass {
    NSArray *arr = self.navigationController.viewControllers;
    for (int i=0;i<arr.count;i++) {
        UIViewController *v = [self.navigationController.viewControllers objectAtIndex:i];
        if([v isKindOfClass:viewControllerClass])
        {
            [self.navigationController popToViewController:v animated:YES];
            break;
        }
    }
}
/**
 *  移除navigationbutton
 *
 *  @param position 位置
 */
- (void)removeNavigationBarBar:(NavigationBarPosition)position {
    NSArray *buttonArray = nil;
    if (NavigationBarPositionLeft == position) {
        
        self.navigationItem.leftBarButtonItems = buttonArray;
        
    }else if(NavigationBarPositionRight == position){
        
        self.navigationItem.rightBarButtonItems = buttonArray;
        
    }
}


/**
 *  NavigationController里上一个ViewController
 *
 */
- (UIViewController *)previosViewController {
    
    NSUInteger index = [self.navigationController.viewControllers indexOfObject:self];
    if (index >= 1) {
        
        return [self.navigationController.viewControllers objectAtIndex:(index-1)];
    }
    
    return nil;
}

/**
 *  移除当前NavigationController里ViewController的上一个ViewController
 */
- (void)removePreviosViewControllerInNavigationControllers {
    
    NSUInteger index = [self.navigationController.viewControllers indexOfObject:self];
    if (index > 1) {
        
        NSMutableArray *navigationArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        if (navigationArray.count >1) {
            [navigationArray removeObjectAtIndex:index-1];
        }
        self.navigationController.viewControllers = navigationArray;
    }
}

/**
 *  添加多个按钮时
 *
 *  @param position 位置
 *  @param array    buttonImageNameAndButtonTypeArray
 *  @param target   目标
 *  @param selector 响应方法
 */
- (void) setNavigationBar:(NavigationBarPosition)position withImageNameAndButtonTypeArray:(NSArray *)array target:(id)target selectors:(SEL)selector{
    
    NSMutableArray * items = [[NSMutableArray alloc]init];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -19;
    [items addObject:negativeSpacer];
    for (int i = 0; i <array.count; i++) {
        NSDictionary * model = [array objectAtIndex:i];
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:[model objectForKey:@"image"]] forState:UIControlStateNormal];
        CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
        btn.frame = CGRectMake(0.0f, 0.0f, 44.0f, statusBarRect.size.height + 44.0);
        btn.tag = [[model objectForKey:@"tag"] integerValue];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        [items addObject:item];
        if (i > 0) {
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -30)];
        }
    }
    if (NavigationBarPositionRight == position) {
        self.navigationItem.rightBarButtonItems= items;
    }
    else if(NavigationBarPositionLeft == position){
        self.navigationItem.leftBarButtonItems= items;
    }
}

#pragma mark - StoryBoard
/**
 *  从storyboard中初始化ViewController
 *
 *  @param storyBoardName storyboard名称
 *  @param identifier     ViewController标识符
 *
 *  @return ViewController实例
 */
+ (instancetype)viewControllerFromStoryBoard:(NSString *)storyBoardName withIdentifier:(NSString *)identifier {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    if (identifier.length) {
        return [sb instantiateViewControllerWithIdentifier:identifier];
    }
    else {
        return [sb instantiateInitialViewController];
    }
}

#pragma mark - 设置状态栏（通知栏）颜色
- (void)fm_setStatusBarBackgroundColor:(UIColor *)color {

    if (@available(iOS 13.0, *)) {
        NSInteger ios13tag = 1300;
        UIView *statusBar  = [[UIApplication sharedApplication].keyWindow viewWithTag:ios13tag];
        if (!statusBar) {
            statusBar = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame] ;
            statusBar.tag = ios13tag;
            [[UIApplication sharedApplication].keyWindow addSubview:statusBar];
        }
        statusBar.backgroundColor = color;

    } else {
        // Fallback on earlier versions
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            statusBar.backgroundColor = color;
        }
    }
    if ([color isEqual:UIColor.whiteColor]) {
        if (@available(iOS 13.0, *)) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
        } else {
            // Fallback on earlier versions
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}

-(void)fm_backToController:(NSString *)controllerName animated:(BOOL)animaed{
    if (self.navigationController) {
        NSArray *controllers = self.navigationController.viewControllers;
        NSArray *result = [controllers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject isKindOfClass:NSClassFromString(controllerName)];
        }]];
        if (result.count > 0) {
            [self.navigationController popToViewController:result[0] animated:YES];
        }
    }
}

/// 移除某个控制器
-(void)fm_removeController:(NSString *)controllerName {
    [self fm_removeControllers:@[controllerName].mutableCopy];
}

/// 移除多个控制器
-(void)fm_removeControllers:(NSMutableArray <NSString *>*)controllers {
    if (self.navigationController) {
        NSMutableArray *vcArr = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
        NSMutableArray *vcin = [NSMutableArray array];
        for (NSString *vcstr in controllers) {
            for (UIViewController *vc in vcArr) {
                if ([vc isKindOfClass:[NSClassFromString(vcstr) class]]) {
                    [vcin addObject:vc];
                }
            }
        }
        for (UIViewController *x in vcin) {
            [vcArr removeObject:x];
        }
        self.navigationController.viewControllers = vcArr;
    }
}

@end

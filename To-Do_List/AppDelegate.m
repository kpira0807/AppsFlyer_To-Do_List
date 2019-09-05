#import "AppDelegate.h"
#import <AppsFlyerLib/AppsFlyerTracker.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AppsFlyerTracker sharedTracker].appsFlyerDevKey = @"2012121277";
    [AppsFlyerTracker sharedTracker].appleAppID = @"2012121277";
    
    [AppsFlyerTracker sharedTracker].delegate = self;
    
    /* Set isDebud to true to see AppsFlyer debug logs */
    [AppsFlyerTracker sharedTracker].isDebug = true;
    

    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        
        UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
        
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
        
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[AppsFlyerTracker sharedTracker] trackAppLaunch];
    application.applicationIconBadgeNumber = 0;
    [[AppsFlyerTracker sharedTracker] trackEvent: AFEventPurchase
                                      withValues:@{
                                                   AFEventParamContentId:@"2012121277",
                                                   AFEventParamContentType : @"category_a",
                                                   AFEventParamRevenue: @1.99,
                                                   AFEventParamCurrency:@"USD"
                                                   }];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)onConversionDataReceived:(NSDictionary*) installData {
    //Handle Conversion Data (Deferred Deep Link)
    
}

-(void)onConversionDataRequestFailure:(NSError *) error {
    
    NSLog(@"%@",error);
}


- (void) onAppOpenAttribution:(NSDictionary*) attributionData {
    
    //Handle Deep Link
}

- (void) onAppOpenAttributionFailure:(NSError *)error {
    NSLog(@"%@",error);
}

// Reports app open from a Universal Link for iOS 9 or above
- (BOOL) application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> *restorableObjects))restorationHandler {
    [[AppsFlyerTracker sharedTracker] continueUserActivity:userActivity restorationHandler:restorationHandler];
    return YES;
}

// Reports app open from deep link from apps which do not support Universal Links (Twitter) and for iOS8 and below
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation {
    [[AppsFlyerTracker sharedTracker] handleOpenURL:url sourceApplication:sourceApplication withAnnotation:annotation];
    return YES;
}
// Reports app open from deep link for iOS 10
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
            options:(NSDictionary *) options {
    [[AppsFlyerTracker sharedTracker] handleOpenUrl:url options:options];
    return YES;
}


@end

#import "CodePush.h"

@implementation CodePushConfig {
    NSMutableDictionary *_configDictionary;
}

static CodePushConfig *_currentConfig;

static NSString * const AppVersionConfigKey = @"appVersion";
static NSString * const BuildVersionConfigKey = @"buildVersion";
static NSString * const DeploymentKeyConfigKey = @"deploymentKey";
static NSString * const ServerURLConfigKey = @"serverUrl";

+ (instancetype)current
{
    return _currentConfig;
}

+ (void)initialize
{
    _currentConfig = [[CodePushConfig alloc] init];
}

- (instancetype)init
{
    self = [super init];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];

    NSString *appVersion = [infoDictionary objectForKey:(NSString *)kCFBundleVersionKey];
    NSString *buildVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *deploymentKey = [infoDictionary objectForKey:@"CodePushDeploymentKey"];
    NSString *serverURL = [infoDictionary objectForKey:@"CodePushServerURL"];

    if (!serverURL) {
        serverURL = @"https://codepush.azurewebsites.net/";
    }

    _configDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            appVersion,AppVersionConfigKey,
                            buildVersion,BuildVersionConfigKey,
                            serverURL,ServerURLConfigKey,
                            deploymentKey,DeploymentKeyConfigKey,
                            nil];

    return self;
}

- (NSString *)appVersion
{
    return [_configDictionary objectForKey:AppVersionConfigKey];
}

- (NSString *)buildVersion
{
    return [_configDictionary objectForKey:BuildVersionConfigKey];
}

- (NSDictionary *)configuration
{
    return _configDictionary;
}

- (NSString *)deploymentKey
{
    return [_configDictionary objectForKey:DeploymentKeyConfigKey];
}

- (NSString *)serverURL
{
    return [_configDictionary objectForKey:ServerURLConfigKey];
}

- (void)setDeploymentKey:(NSString *)deploymentKey
{
    [_configDictionary setValue:deploymentKey forKey:DeploymentKeyConfigKey];
}

- (void)setServerURL:(NSString *)serverURL
{
    [_configDictionary setValue:serverURL forKey:ServerURLConfigKey];
}

@end

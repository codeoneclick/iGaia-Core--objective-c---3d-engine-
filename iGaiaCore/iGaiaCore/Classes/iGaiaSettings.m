//
//  iGaiaSettings.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 11/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSettings.h"
#import "iGaiaLogger.h"

#define kPreferencesResolution @"igaia_resolution_preferences"
#define kPreferencesOrientation @"igaia_orientation_preferences"

enum E_RESOLUTION { E_RESOLUTION_320x480 = 0, E_RESOLUTION_640x960 };
enum E_ORIENTATION { E_ORIENTATION_LANDSCAPE = 0, E_ORIENTATION_PORTRAIT };

@implementation iGaiaSettings

+ (CGRect)frame
{
    return CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
}

+ (CGSize)resolution
{
    return CGSizeMake(240, 160);
}

+ (CGRect)retriveFrameRect
{
    /*NSNumber* resolution = [[NSUserDefaults standardUserDefaults] objectForKey:kPreferencesResolution];
    NSNumber* orientation = [[NSUserDefaults standardUserDefaults] objectForKey:kPreferencesOrientation];

    CGRect rect;

    switch ([resolution integerValue])
    {
        case E_RESOLUTION_320x480:
        {
            if([orientation integerValue] == E_ORIENTATION_LANDSCAPE)
            {
                rect = CGRectMake(0, 0, 480, 320);
            }
            else if([orientation integerValue] == E_ORIENTATION_PORTRAIT)
            {
                rect = CGRectMake(0, 0, 320, 480);
            }
        }
            break;
        case E_RESOLUTION_640x960:
        {
            if([orientation integerValue] == E_ORIENTATION_LANDSCAPE)
            {
                rect = CGRectMake(0, 0, 960, 640);
            }
            else if([orientation integerValue] == E_ORIENTATION_PORTRAIT)
            {
                rect = CGRectMake(0, 0, 640, 960);
            }
        }
            break;
        default:
            break;
    }
    return rect;*/
    return CGRectMake(0, 0, 480, 320);
}

+ (void)registerDefaultsFromSettingsBundle
{
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle)
    {
        iGaiaLog(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];

    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences)
    {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key)
        {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
}


@end

//
//  iGaiaSoundMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 22/05/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVAudioPlayer.h>

#define kMaxSources 32

@interface iGaiaSoundMgr : NSObject

- (void)createSoundFromFile:(NSString*)name withExtension:(NSString*)extension withKey:(NSString*)key withFrequency:(NSUInteger)frequency;
- (void)createBackgroundMusicFromFile:(NSString*)name withExtension:(NSString*)extension withKey:(NSString*)key;

- (NSUInteger)playSoundWithKey:(NSString*)key withGain:(ALfloat)gain withPitch:(ALfloat)pitch shouldLoop:(BOOL)loop;
- (void)playMusicWithKey:(NSString*)key timesToRepeat:(NSUInteger)timesToRepeat;
- (void)stopPlayingMusic;

@end

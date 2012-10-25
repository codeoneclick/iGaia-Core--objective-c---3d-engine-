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

+ (SingletonSoundManager *)sharedSoundManager;

- (id)init;
- (NSUInteger) playSoundWithKey:(NSString*)theSoundKey gain:(ALfloat)theGain pitch:(ALfloat)thePitch location:(Vector2f)theLocation shouldLoop:(BOOL)theShouldLoop;
- (void) loadSoundWithKey:(NSString*)theSoundKey fileName:(NSString*)theFileName fileExt:(NSString*)theFileExt frequency:(NSUInteger)theFrequency;
- (void) playMusicWithKey:(NSString*)theMusicKey timesToRepeat:(NSUInteger)theTimesToRepeat;
- (void) loadBackgroundMusicWithKey:(NSString*)theMusicKey fileName:(NSString*)theFileName fileExt:(NSString*)theFileExt;
- (void) setBackgroundMusicVolume:(ALfloat)theVolume;
- (void) shutdownSoundManager;

@end

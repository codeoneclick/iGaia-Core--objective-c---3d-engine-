//
//  iGaiaSoundMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 22/05/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "iGaiaSoundMgr.h"
#import "iGaiaLogger.h"

@interface iGaiaSoundMgr()

@property(nonatomic, assign) ALCcontext* m_context;
@property(nonatomic, assign) ALCdevice* m_device;

@property(nonatomic, strong) NSMutableArray* m_sources;

@property(nonatomic, strong) NSMutableDictionary* m_sounds;
@property(nonatomic, strong) NSMutableDictionary* m_music;

@property(nonatomic, strong) AVAudioPlayer* m_backgroundAudio;
@property(nonatomic, assign) ALfloat m_backgroundVolume;

@end


@implementation iGaiaSoundMgr

- (id)init
{
	if(self = [super init])
    {
		_m_sources = [NSMutableArray new];
		_m_sounds = [NSMutableDictionary new];
		_m_music = [NSMutableDictionary new];
		
		_m_backgroundVolume = 1.0f;

        _m_device = alcOpenDevice(NULL);
        if(_m_device)
        {
            _m_context = alcCreateContext(_m_device, NULL);
            alcMakeContextCurrent(_m_context);
            NSUInteger sourceId;
            for(int index = 0; index < kMaxSources; index++)
            {
                alGenSources(1, &sourceId);
                [_m_sources addObject:[NSNumber numberWithUnsignedInt:sourceId]];
            }
            return self;
        }
	}
    self = nil;
	return nil;
}

- (NSUInteger)retriveAvailableSource
{
	NSInteger sourceState;
	for(NSNumber *sourceNumber in _m_sources)
    {
		alGetSourcei([sourceNumber unsignedIntValue], AL_SOURCE_STATE, &sourceState);
		if(sourceState != AL_PLAYING)
        {
            return [sourceNumber unsignedIntValue];
        }
	}

	NSInteger looping;
	for(NSNumber *sourceNumber in _m_sources)
    {
		alGetSourcei([sourceNumber unsignedIntValue], AL_LOOPING, &looping);
		if(!looping)
        {
			NSUInteger sourceId = [sourceNumber unsignedIntValue];
			alSourceStop(sourceId);
			return sourceId;
		}
	}

	NSUInteger sourceId = [[_m_sources objectAtIndex:0] unsignedIntegerValue];
	alSourceStop(sourceId);
	return sourceId;
}

- (void)createSoundFromFile:(NSString*)name withExtension:(NSString*)extension withKey:(NSString*)key withFrequency:(NSUInteger)frequency
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:extension];

    AudioFileID soundId;

	NSURL *url = [NSURL fileURLWithPath:path];
	OSStatus result = AudioFileOpenURL((__bridge CFURLRef)url, kAudioFileReadPermission, 0, &soundId);

	if(result != 0)
    {
		iGaiaLog(@"Cannot open file with name: %@", path);
        return;
	}

    UInt32 data = 0;
	UInt32 size = sizeof(UInt64);
	result = AudioFileGetProperty(soundId, kAudioFilePropertyAudioDataByteCount, &size, &data);
	if(result != 0)
    {
        iGaiaLog(@"Cannot get file size with name: %@", path);
        return;
    }

	unsigned char *soundData = malloc(data);

	result = AudioFileReadBytes(soundId, FALSE, 0, &data, soundData);
	AudioFileClose(soundId);

	if(result != 0)
    {
		iGaiaLog(@"Cannot load sound with name: %@", path);
		return;
	}

	NSUInteger bufferId;
	alGenBuffers(1, &bufferId);
	alBufferData(bufferId, AL_FORMAT_STEREO16, soundData, data, frequency);
	[_m_sounds setObject:[NSNumber numberWithUnsignedInt:bufferId] forKey:key];

	if(soundData)
    {
		free(soundData);
		soundData = NULL;
	}
}

- (void)createBackgroundMusicFromFile:(NSString*)name withExtension:(NSString*)extension withKey:(NSString*)key
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:extension];
	[_m_music setObject:path forKey:key];
}

- (NSUInteger)playSoundWithKey:(NSString*)key withGain:(ALfloat)gain withPitch:(ALfloat)pitch shouldLoop:(BOOL)loop
{
	ALenum error = alGetError();
	NSNumber *soundId = [_m_sounds objectForKey:key];
	if(soundId == nil)
    {
        iGaiaLog(@"Cannot play sound with key: %@", key);
        return 0;
    }
	NSUInteger bufferId = [soundId unsignedIntValue];
	NSUInteger sourceId = [self retriveAvailableSource];
	alSourcei(sourceId, AL_BUFFER, 0);
	alSourcei(sourceId, AL_BUFFER, bufferId);
	alSourcef(sourceId, AL_PITCH, pitch);
	alSourcef(sourceId, AL_GAIN, gain);
	
	if(loop)
    {
		alSourcei(sourceId, AL_LOOPING, AL_TRUE);
	}
    else
    {
		alSourcei(sourceId, AL_LOOPING, AL_FALSE);
	}
	
	error = alGetError();
	if(error != 0)
    {
        iGaiaLog(@"Cannot play sound with key: %@", key);
		return 0;
	}
	alSourcePlay(sourceId);

	return sourceId;
}

- (void)playMusicWithKey:(NSString*)key timesToRepeat:(NSUInteger)timesToRepeat
{
	__autoreleasing NSError *error;
	NSString *path = [_m_music objectForKey:key];
	
	if(!path)
    {
        iGaiaLog(@"Cannot play music with key: %@", key);
		return;
	}
	
	_m_backgroundAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
	if(!_m_backgroundAudio)
    {
		iGaiaLog(@"Cannot play music with key: %d", error);
		return;
	}		
	
	[_m_backgroundAudio setNumberOfLoops:timesToRepeat];
	[_m_backgroundAudio setVolume:_m_backgroundVolume];
	[_m_backgroundAudio play];
}


- (void)stopPlayingMusic
{
	[_m_backgroundAudio stop];
}

@end

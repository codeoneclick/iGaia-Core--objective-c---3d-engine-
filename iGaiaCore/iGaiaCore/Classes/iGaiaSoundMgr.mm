//
//  iGaiaSoundMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 22/05/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "iGaiaSoundMgr.h"
#import "iGaiaLogger.h"

iGaiaSoundMgr::iGaiaSoundMgr(void)
{
    m_backgroundVolume = 1.0f;

    m_device = alcOpenDevice(NULL);
    if(m_device)
    {
        m_context = alcCreateContext(m_device, NULL);
        alcMakeContextCurrent(m_context);
        ui32 sourceId;
        for(i32 index = 0; index < kMaxSources; ++index)
        {
            alGenSources(1, &sourceId);
            m_sources[index] = sourceId;
        }
    }
}

iGaiaSoundMgr::~iGaiaSoundMgr(void)
{
    
}

ui32 iGaiaSoundMgr::RetriveAvailableSource(void)
{
    i32 sourceState;
	for(i32 i = 0; i < kMaxSources; ++i)
    {
		alGetSourcei(m_sources[i], AL_SOURCE_STATE, &sourceState);
		if(sourceState != AL_PLAYING)
        {
            return m_sources[i];
        }
	}

	i32 looping;
	for(i32 i = 0; i < kMaxSources; ++i)
    {
		alGetSourcei(m_sources[i], AL_LOOPING, &looping);
		if(!looping)
        {
			ui32 sourceId = m_sources[i];
			alSourceStop(sourceId);
			return sourceId;
		}
	}

	ui32 sourceId = m_sources[0];
	alSourceStop(sourceId);
	return sourceId;
}

void iGaiaSoundMgr::CreateSound(const string& _name, const string& _extension, const string& _key, ui32 _frequency)
{
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithCString:_name.c_str() encoding:NSUTF8StringEncoding] ofType:[NSString stringWithCString:_extension.c_str() encoding:NSUTF8StringEncoding]];
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

	ui8* soundData = static_cast<ui8*>(malloc(data));

	result = AudioFileReadBytes(soundId, false, 0, &data, soundData);
	AudioFileClose(soundId);

	if(result != 0)
    {
		iGaiaLog(@"Cannot load sound with name: %@", path);
		return;
	}

	ui32 bufferId;
	alGenBuffers(1, &bufferId);
	alBufferData(bufferId, AL_FORMAT_STEREO16, soundData, data, _frequency);
    m_sounds[_key] = bufferId;

	if(soundData)
    {
		free(soundData);
		soundData = nullptr;
	}
}

void iGaiaSoundMgr::CreateMusic(const string& _name, const string& _extension, const string& _key)
{
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithCString:_name.c_str() encoding:NSUTF8StringEncoding] ofType:[NSString stringWithCString:_extension.c_str() encoding:NSUTF8StringEncoding]];
    m_music[_key] = string([path UTF8String]);
}

ui32 iGaiaSoundMgr::PlaySound(const string& _key, ALfloat _gain, ALfloat _pitch, bool _loop)
{
    ALenum error = alGetError();
	if(m_sounds.find(_key) == m_sounds.end())
    {
        iGaiaLog(@"Cannot play sound with key: %s", _key.c_str());
        return 0;
    }
    ui32 soundId = m_sounds.find(_key)->second;
	ui32 bufferId = soundId;
	ui32 sourceId = RetriveAvailableSource();
	alSourcei(sourceId, AL_BUFFER, 0);
	alSourcei(sourceId, AL_BUFFER, bufferId);
	alSourcef(sourceId, AL_PITCH, _pitch);
	alSourcef(sourceId, AL_GAIN, _gain);

	if(_loop)
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
        iGaiaLog(@"Cannot play sound with key: %s", _key.c_str());
		return 0;
	}
	alSourcePlay(sourceId);
	return sourceId;
}

void iGaiaSoundMgr::PlayMusic(const string& _key, ui32 _repeatCount)
{
    __autoreleasing NSError *error;
    NSString *path = [NSString stringWithCString:m_music.find(_key)->second.c_str() encoding:NSUTF8StringEncoding];

    if(!path)
    {
        iGaiaLog(@"Cannot play music with key: %@", _key.c_str());
        return;
    }

    m_backgroundAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
    if(!m_backgroundAudio)
    {
        iGaiaLog(@"Cannot play music with key: %d", error);
        return;
    }

    [m_backgroundAudio setNumberOfLoops:_repeatCount];
    [m_backgroundAudio setVolume:m_backgroundVolume];
    [m_backgroundAudio play];
}

void iGaiaSoundMgr::StopMusic(void)
{
    [m_backgroundAudio stop];
}

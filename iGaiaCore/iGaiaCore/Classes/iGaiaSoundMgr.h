//
//  iGaiaSoundMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 22/05/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#ifndef iGaiaSoundMgrClass
#define iGaiaSoundMgrClass

#include "iGaiaCommon.h"

#define kMaxSources 32

class iGaiaSoundMgr
{
private:
    ALCcontext* m_context;
    ALCdevice* m_device;

    ui32 m_sources[kMaxSources];
    map<string, ui32> m_sounds;
    map<string, string> m_music;

    AVAudioPlayer* m_backgroundAudio;
    ALfloat m_backgroundVolume;

    ui32 RetriveAvailableSource(void);
protected:

public:
    iGaiaSoundMgr(void);
    ~iGaiaSoundMgr(void);

    void CreateSound(const string& _name, const string& _extension, const string& _key, ui32 _frequency);
    void CreateMusic(const string& _name, const string& _extension, const string& _key);

    ui32 PlaySound(const string& _key, ALfloat _gain, ALfloat _pitch, bool _loop);
    void PlayMusic(const string& _key, ui32 _repeatCount);
    void StopMusic(void);
};

#endif
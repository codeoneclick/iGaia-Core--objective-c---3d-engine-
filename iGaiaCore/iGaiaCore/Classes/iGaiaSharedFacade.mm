//
//  iGaiaSharedFacade.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/6/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSharedFacade.h"

iGaiaSharedFacade::iGaiaSharedFacade(void)
{
    m_stageFabricator = new iGaiaStageFabricator();
    m_stageProcessor = new iGaiaStageProcessor();
    m_scriptMgr = new iGaiaScriptMgr();
    m_soundMgr = new iGaiaSoundMgr();
}

iGaiaSharedFacade::~iGaiaSharedFacade(void)
{
    
}

iGaiaSharedFacade* iGaiaSharedFacade::SharedInstance(void)
{
    static iGaiaSharedFacade *instance = nullptr;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = new iGaiaSharedFacade();
    });
    return instance;
}

iGaiaStageFabricator* iGaiaSharedFacade::Get_StageFabricator(void)
{
    return m_stageFabricator;
}

iGaiaStageProcessor* iGaiaSharedFacade::Get_StageProcessor(void)
{
    return m_stageProcessor;
}

iGaiaScriptMgr* iGaiaSharedFacade::Get_ScriptMgr(void)
{
    return m_scriptMgr;
}

iGaiaSoundMgr* iGaiaSharedFacade::Get_SoundMgr(void)
{
    return m_soundMgr;
}
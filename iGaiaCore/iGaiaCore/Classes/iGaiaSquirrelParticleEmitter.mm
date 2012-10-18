//
//  iGaiaSquirrelParticleEmitter.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/18/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSquirrelParticleEmitter.h"
#import "iGaiaStageMgr.h"
#import "iGaiaLogger.h"

@interface iGaiaSquirrelParticleEmitter()

@property(nonatomic, assign) iGaiaSquirrelCommon* m_commonWrapper;

@end

@implementation iGaiaSquirrelParticleEmitter

- (id)initWithCommonWrapper:(iGaiaSquirrelCommon *)commonWrapper
{
    self = [super init];
    if(self)
    {
        _m_commonWrapper = commonWrapper;
        [self bind];
    }
    return self;
}

- (void)bind
{
    [_m_commonWrapper registerClass:@"ParticleEmitterWrapper"];
}


@end

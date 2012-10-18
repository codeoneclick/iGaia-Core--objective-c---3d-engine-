//
//  iGaiaSquirrelObject3d.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSquirrelObject3d.h"
#import "iGaiaStageMgr.h"
#import "iGaiaLogger.h"

@interface iGaiaSquirrelObject3d()

@property(nonatomic, assign) iGaiaSquirrelCommon* m_commonWrapper;

@end


@implementation iGaiaSquirrelObject3d

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
    [_m_commonWrapper registerClass:@"Object3dWrapper"];
    [_m_commonWrapper registerFunction:sq_setPositionObject3d withName:@"setPositionObject3d" forClass:@"Object3dWrapper"];
    [_m_commonWrapper registerFunction:sq_getPositionObject3d withName:@"getPositionObject3d" forClass:@"Object3dWrapper"];
    [_m_commonWrapper registerFunction:sq_setRotationObject3d withName:@"setRotationObject3d" forClass:@"Object3dWrapper"];
    [_m_commonWrapper registerFunction:sq_getRotationObject3d withName:@"getRotationObject3d" forClass:@"Object3dWrapper"];
    [_m_commonWrapper registerFunction:sq_setShaderObject3d withName:@"setShader" forClass:@"Object3dWrapper"];
    [_m_commonWrapper registerFunction:sq_setTextureObject3d withName:@"setTexture" forClass:@"Object3dWrapper"];
}

SQInteger sq_getPositionObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        iGaiaShape3d* shape3d = nil;
        SQUserPointer ptr = [[iGaiaSquirrelCommon sharedInstance] retriveDataPtrValueWithIndex:2];
        shape3d = (__bridge iGaiaShape3d*)ptr;
        glm::vec3 position = shape3d.m_position;
        [[iGaiaSquirrelCommon sharedInstance] pushVector3dX:position.x Y:position.y Z:position.z];
        return YES;
    }
    iGaiaLog(@"Script call args NULL.");
    return NO;
}

SQInteger sq_setPositionObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        iGaiaShape3d* shape3d = nil;
        SQUserPointer ptr = [[iGaiaSquirrelCommon sharedInstance] retriveDataPtrValueWithIndex:2];
        shape3d = (__bridge iGaiaShape3d*)ptr;
        glm::vec3 position;
        [[iGaiaSquirrelCommon sharedInstance] popVector3dX:&position.x Y:&position.y Z:&position.z forIndex:3];
        shape3d.m_position = position;
        return YES;
    }
    iGaiaLog(@"Script call args NULL.");
    return NO;
}

SQInteger sq_getRotationObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        iGaiaShape3d* shape3d = nil;
        SQUserPointer ptr = [[iGaiaSquirrelCommon sharedInstance] retriveDataPtrValueWithIndex:2];
        shape3d = (__bridge iGaiaShape3d*)ptr;
        glm::vec3 rotation = shape3d.m_rotation;
        [[iGaiaSquirrelCommon sharedInstance] pushVector3dX:rotation.x Y:rotation.y Z:rotation.z];
        return YES;
    }
    iGaiaLog(@"Script call args NULL.");
    return NO;
}

SQInteger sq_setRotationObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        iGaiaShape3d* shape3d = nil;
        SQUserPointer ptr = [[iGaiaSquirrelCommon sharedInstance] retriveDataPtrValueWithIndex:2];
        shape3d = (__bridge iGaiaShape3d*)ptr;
        glm::vec3 rotation;
        [[iGaiaSquirrelCommon sharedInstance] popVector3dX:&rotation.x Y:&rotation.y Z:&rotation.z forIndex:3];
        shape3d.m_rotation = rotation;
        return YES;
    }
    iGaiaLog(@"Script call args NULL.");
    return NO;
}

SQInteger sq_setShaderObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        iGaiaShape3d* shape3d = nil;
        SQUserPointer ptr = [[iGaiaSquirrelCommon sharedInstance] retriveDataPtrValueWithIndex:2];
        shape3d = (__bridge iGaiaShape3d*)ptr;
        NSInteger shader = [[iGaiaSquirrelCommon sharedInstance] retriveIntegerValueWithIndex:3];
        NSInteger mode = [[iGaiaSquirrelCommon sharedInstance] retriveIntegerValueWithIndex:4];
        [shape3d setShader:(E_SHADER)shader forMode:mode];
        return YES;
    }
    iGaiaLog(@"Script call args NULL.");
    return NO;
}

SQInteger sq_setTextureObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        iGaiaShape3d* shape3d = nil;
        SQUserPointer ptr = [[iGaiaSquirrelCommon sharedInstance] retriveDataPtrValueWithIndex:2];
        shape3d = (__bridge iGaiaShape3d*)ptr;
        const SQChar* f_name = [[iGaiaSquirrelCommon sharedInstance] retriveStringValueWithIndex:3];
        NSInteger slot = [[iGaiaSquirrelCommon sharedInstance] retriveIntegerValueWithIndex:4];
        [shape3d setTextureWithFileName:[[NSString alloc] initWithUTF8String:f_name] forSlot:(E_TEXTURE_SLOT)slot withWrap:iGaiaTextureSettingValues.clamp];
        return YES;
    }
    iGaiaLog(@"Script call args NULL.");
    return NO;
}

@end

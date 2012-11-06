//
//  iGaiaIndexBufferObject.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaResource.h"

class iGaiaIndexBufferObject
{
private:
    ui32 m_handle;
    ui16* m_data;
    GLenum m_mode;
protected:
    
public:
    iGaiaIndexBufferObject(
};

@interface iGaiaIndexBufferObject : NSObject

@property(nonatomic, readonly) NSUInteger m_numIndexes;

- (id)initWithNumIndexes:(NSUInteger)numIndexes withMode:(GLenum)mode;

- (void)unload;

- (unsigned short*)lock;
- (void)unlock;

- (void)bind;
- (void)unbind;

@end

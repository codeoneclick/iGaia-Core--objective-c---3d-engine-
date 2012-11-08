//
//  iGaiaLoader_PVR.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaLoader_PVRClass
#define iGaiaLoader_PVRClass

#include "iGaiaLoader.h"
#include "iGaiaTexture.h"

class iGaiaLoader_PVR : public iGaiaLoader
{
private:
    GLenum m_format;
    i32 m_bytesPerPixel;
    vec2 m_size;
    bool m_compressed;
    i8* m_data;
    ui32 m_headerSize;
protected:

public:
    iGaiaLoader_PVR(void);
    ~iGaiaLoader_PVR(void);

    void ParseFileWithName(const string& _name);
    iGaiaResource* CommitToVRAM(void);
};

#endif
//
//  iGaiaTexture.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaTextureClass
#define iGaiaTextureClass

#import "iGaiaResource.h"

class iGaiaTexture : public iGaiaResource
{
public:
    struct iGaiaTextureWrapMode
    {
        string iGaiaTextureWrapModeRepeat;
        string iGaiaTextureWrapModeClamp;
        string iGaiaTextureWrapModeMirror;
    };

private:
    ui32 m_handle;
    ui16 m_width;
    ui16 m_height;
protected:
    
public:
    iGaiaTexture(ui32 _handle, ui16 _width, ui16 _height, const string& _name, iGaiaResource::iGaia_E_CreationMode _creationMode);
    ~iGaiaTexture(void);

    void Set_WrapMode(string const& _wrapMode);

    //map<ui32, ui32> Get_Settings(void);
    //void Set_Settings(const map<ui32, ui32>& _settings);
    
    ui32 Get_Handle(void);
    
    ui16 Get_Width(void);
    ui16 Get_Height(void);
    
    void Bind(void);
    void Unbind(void);
};

#endif
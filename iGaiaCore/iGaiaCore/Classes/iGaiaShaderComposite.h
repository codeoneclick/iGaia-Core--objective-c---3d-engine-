//
//  iGaiaShaderComposite.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaShader.h"

@interface iGaiaShaderComposite : NSObject

+ (iGaiaShaderComposite *)sharedInstance;

- (iGaiaShader*)getShader:(E_SHADER)shader;

@end

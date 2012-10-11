//
//  iGaiaOcean.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaObject3d.h"

@interface iGaiaOcean : iGaiaObject3d

@property(nonatomic, assign) iGaiaTexture* m_reflectionTexture;
@property(nonatomic, assign) iGaiaTexture* m_refractionTexture;

- (id)initWithWidth:(float)witdh withHeight:(float)height withAltitude:(float)altitude;

@end

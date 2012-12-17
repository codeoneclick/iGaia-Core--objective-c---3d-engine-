const char* ShaderOceanF = STRINGIFY(
                                                   varying highp vec4   OUT_TexCoordProj;
                                                   varying highp vec2   OUT_TexCoord;
                                                   varying highp vec3   OUT_Position;
                                                   uniform highp float  EXT_Timer;
                                                   uniform highp vec3   EXT_Center;
                                                   uniform sampler2D EXT_TEXTURE_01;
                                                   uniform sampler2D EXT_TEXTURE_02;
                                                   uniform sampler2D EXT_TEXTURE_03;
                                                   uniform sampler2D EXT_TEXTURE_04;                                       
void main(void)
{
    highp vec2 vTexCoordProj = OUT_TexCoordProj.xy;
	vTexCoordProj.x = 0.5 - 0.5 * vTexCoordProj.x / OUT_TexCoordProj.w;
	vTexCoordProj.y = 0.5 + 0.5 * vTexCoordProj.y / OUT_TexCoordProj.w;
	vTexCoordProj = clamp(vTexCoordProj, 0.001, 0.999);
    lowp vec4 vReflectionColor = texture2D(EXT_TEXTURE_01, vTexCoordProj);
    
    vTexCoordProj = OUT_TexCoordProj.xy;
    vTexCoordProj.x = 0.5 + 0.5 * vTexCoordProj.x / OUT_TexCoordProj.w;
    vTexCoordProj.y = 0.5 + 0.5 * vTexCoordProj.y / OUT_TexCoordProj.w;
    vTexCoordProj = clamp(vTexCoordProj, 0.001, 0.999);
    lowp vec4 vRefractionColor = texture2D(EXT_TEXTURE_02, vTexCoordProj);
    
    /*
    highp vec2 vTexCoord_01 = vec2(OUT_TexCoord.x * 8.0 + sin(EXT_Timer) * 0.33,
								   OUT_TexCoord.y * 8.0 + cos(EXT_Timer) * 0.66);
	
	highp vec2 vTexCoord_02 = vec2(OUT_TexCoord.x * 8.0 - sin(EXT_Timer) * 0.75,
								   OUT_TexCoord.y * 8.0 - cos(EXT_Timer) * 0.25);
                                   
    lowp vec4 vWaterColor = texture2D(EXT_TEXTURE_04, vTexCoord_01) + texture2D(EXT_TEXTURE_04, vTexCoord_02);
    lowp vec4 vDeepColor = texture2D(EXT_TEXTURE_03, OUT_TexCoord);
    vRefractionColor = mix(vRefractionColor, vWaterColor, vDeepColor.r);
    lowp vec4 vColor = mix(vRefractionColor, vReflectionColor, 0.25);*/
    
    highp vec2 vTexCoord_01 = vec2(OUT_TexCoord.x * 8.0 + sin(EXT_Timer) * 0.33,
								   OUT_TexCoord.y * 8.0 + cos(EXT_Timer) * 0.66);
	
	highp vec2 vTexCoord_02 = vec2(OUT_TexCoord.x * 8.0 - sin(EXT_Timer) * 0.75,
								   OUT_TexCoord.y * 8.0 - cos(EXT_Timer) * 0.25);
                                   
    lowp vec4 vWaterColor = texture2D(EXT_TEXTURE_03, vTexCoord_01) + texture2D(EXT_TEXTURE_03, vTexCoord_02);
    vReflectionColor = mix(vReflectionColor, vWaterColor, 0.5);
    vReflectionColor = mix(vRefractionColor, vReflectionColor, 0.75);
    vReflectionColor.a = 1.0 - clamp((length(OUT_Position - EXT_Center) - 32.0) / 64.0, 0.0, 1.0);
    gl_FragColor = vReflectionColor;
}
);

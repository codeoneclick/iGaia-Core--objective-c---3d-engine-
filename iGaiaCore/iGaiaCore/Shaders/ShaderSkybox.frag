const char* ShaderSkyboxF = STRINGIFY(                                  
                                                  varying highp vec2   OUT_TexCoord;
                                                  uniform sampler2D EXT_TEXTURE_01;
void main(void)
{
    lowp vec4 vColor = texture2D(EXT_TEXTURE_01, OUT_TexCoord);
    vColor.a = 1.0;
    gl_FragColor = mix(vColor, vec4(0.0, 0.0, 0.0, 0.0), 1.2 - OUT_TexCoord.y);
}
);

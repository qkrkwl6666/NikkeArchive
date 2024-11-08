//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "NK/Unlit/Field/NK_Field_SDToon" {
    Properties {
        _MainTex ("Texture", 2D) = "white" { }
        _RimTex ("Rim Light Texture", 2D) = "white" { }
        _RimDir ("Rim Light Dir", Vector) = (-1,1,0,0)
        _RimPower ("Rim Light Power", Range(0, 10)) = 1
        _LightColor ("Light Color", Vector) = (0.4705882,0.4,0.4005639,0)
        _LightDir ("Light Dir", Vector) = (-1,1,0,0)
        _LightPower ("Light Power", Range(0, 5)) = 0
        _DarkenColor ("Darken Color", Vector) = (0,0,0,0)
        _DarkenPower ("Darken Power", Range(0, 5)) = 0.5
        _LightRange ("Light Range", Vector) = (0,1,0,-1)
    }
    SubShader {
        LOD 200
        Tags { "RenderType" = "Opaque" }
        Pass {
            Name "FORWARD"
            LOD 200
            Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
            GpuProgramID 35719
            PlayerProgram "vp" {
                SubProgram "gles3 " {
                    Keywords { "DIRECTIONAL" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out highp vec4 vs_TEXCOORD5;
                    out highp vec4 vs_TEXCOORD6;
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    float u_xlat6;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
                        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat6 = inversesqrt(u_xlat6);
                        vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
                        vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
                        vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_texture_lod
                    #extension GL_EXT_shader_texture_lod : enable
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec3 _WorldSpaceCameraPos;
                    uniform 	mediump vec4 _WorldSpaceLightPos0;
                    uniform 	mediump vec4 unity_OcclusionMaskSelector;
                    uniform 	vec4 unity_SpecCube0_BoxMax;
                    uniform 	vec4 unity_SpecCube0_BoxMin;
                    uniform 	vec4 unity_SpecCube0_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube0_HDR;
                    uniform 	vec4 unity_SpecCube1_BoxMax;
                    uniform 	vec4 unity_SpecCube1_BoxMin;
                    uniform 	vec4 unity_SpecCube1_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube1_HDR;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    uniform 	mediump vec4 _LightColor0;
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform mediump samplerCube unity_SpecCube0;
                    UNITY_LOCATION(2) uniform mediump samplerCube unity_SpecCube1;
                    UNITY_LOCATION(3) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    vec3 u_xlat0;
                    vec3 u_xlat1;
                    vec3 u_xlat2;
                    vec4 u_xlat3;
                    mediump vec4 u_xlat16_3;
                    mediump vec3 u_xlat16_4;
                    mediump vec3 u_xlat16_5;
                    vec4 u_xlat6;
                    vec3 u_xlat7;
                    vec3 u_xlat8;
                    bvec3 u_xlatb9;
                    vec3 u_xlat10;
                    mediump vec3 u_xlat16_10;
                    mediump vec3 u_xlat16_11;
                    vec3 u_xlat12;
                    mediump vec3 u_xlat16_16;
                    float u_xlat24;
                    float u_xlat36;
                    float u_xlat37;
                    bool u_xlatb37;
                    float u_xlat38;
                    mediump float u_xlat16_40;
                    mediump float u_xlat16_41;
                    mediump float u_xlat16_46;
                    void main()
                    {
                        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb37){
                            u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat3.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
                            u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat3.xyz = (bool(u_xlatb37)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat37 = u_xlat3.y * 0.25 + 0.75;
                            u_xlat38 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                            u_xlat3.x = max(u_xlat37, u_xlat38);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
                            u_xlat16_3 = u_xlat3;
                        } else {
                            u_xlat16_3.x = float(1.0);
                            u_xlat16_3.y = float(1.0);
                            u_xlat16_3.z = float(1.0);
                            u_xlat16_3.w = float(1.0);
                        }
                        u_xlat16_4.x = dot(u_xlat16_3, unity_OcclusionMaskSelector);
                        u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
                        u_xlat16_16.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
                        u_xlat16_16.x = u_xlat16_16.x + u_xlat16_16.x;
                        u_xlat16_16.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_16.xxx) + (-u_xlat1.xyz);
                        u_xlat16_5.xyz = u_xlat16_4.xxx * _LightColor0.xyz;
                        u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
                        if(u_xlatb37){
                            u_xlat37 = dot(u_xlat16_16.xyz, u_xlat16_16.xyz);
                            u_xlat37 = inversesqrt(u_xlat37);
                            u_xlat6.xyz = vec3(u_xlat37) * u_xlat16_16.xyz;
                            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
                            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
                            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
                            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
                            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
                            {
                                vec3 hlslcc_movcTemp = u_xlat7;
                                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
                                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
                                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
                                u_xlat7 = hlslcc_movcTemp;
                            }
                            u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                            u_xlat37 = min(u_xlat7.z, u_xlat37);
                            u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
                            u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                        } else {
                            u_xlat6.xyz = u_xlat16_16.xyz;
                        }
                        u_xlat3 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
                        u_xlat16_4.x = u_xlat3.w + -1.0;
                        u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
                        u_xlat16_4.x = log2(u_xlat16_4.x);
                        u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.y;
                        u_xlat16_4.x = exp2(u_xlat16_4.x);
                        u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
                        u_xlat16_10.xyz = u_xlat3.xyz * u_xlat16_4.xxx;
                        u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
                        if(u_xlatb37){
                            u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
                            if(u_xlatb37){
                                u_xlat37 = dot(u_xlat16_16.xyz, u_xlat16_16.xyz);
                                u_xlat37 = inversesqrt(u_xlat37);
                                u_xlat6.xyz = vec3(u_xlat37) * u_xlat16_16.xyz;
                                u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
                                u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
                                u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
                                u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
                                u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
                                {
                                    vec3 hlslcc_movcTemp = u_xlat7;
                                    hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
                                    hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
                                    hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
                                    u_xlat7 = hlslcc_movcTemp;
                                }
                                u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                                u_xlat37 = min(u_xlat7.z, u_xlat37);
                                u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
                                u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                            } else {
                                u_xlat6.xyz = u_xlat16_16.xyz;
                            }
                            u_xlat6 = textureLod(unity_SpecCube1, u_xlat6.xyz, 6.0);
                            u_xlat16_16.x = u_xlat6.w + -1.0;
                            u_xlat16_16.x = unity_SpecCube1_HDR.w * u_xlat16_16.x + 1.0;
                            u_xlat16_16.x = log2(u_xlat16_16.x);
                            u_xlat16_16.x = u_xlat16_16.x * unity_SpecCube1_HDR.y;
                            u_xlat16_16.x = exp2(u_xlat16_16.x);
                            u_xlat16_16.x = u_xlat16_16.x * unity_SpecCube1_HDR.x;
                            u_xlat16_16.xyz = u_xlat6.xyz * u_xlat16_16.xxx;
                            u_xlat6.xyz = u_xlat16_4.xxx * u_xlat3.xyz + (-u_xlat16_16.xyz);
                            u_xlat10.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat16_16.xyz;
                            u_xlat16_10.xyz = u_xlat10.xyz;
                        }
                        u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
                        u_xlat37 = inversesqrt(u_xlat37);
                        u_xlat6.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
                        u_xlat16_4.xyz = u_xlat2.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = max(u_xlat36, 0.00100000005);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat36 = dot(u_xlat6.xyz, u_xlat1.xyz);
                        u_xlat1.x = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
                        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
                        u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
                        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
                        u_xlat16_40 = u_xlat0.x + u_xlat0.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat0.x + -0.5;
                        u_xlat16_41 = (-u_xlat1.x) + 1.0;
                        u_xlat16_46 = u_xlat16_41 * u_xlat16_41;
                        u_xlat16_46 = u_xlat16_46 * u_xlat16_46;
                        u_xlat16_41 = u_xlat16_41 * u_xlat16_46;
                        u_xlat16_41 = u_xlat16_40 * u_xlat16_41 + 1.0;
                        u_xlat16_46 = -abs(u_xlat36) + 1.0;
                        u_xlat16_11.x = u_xlat16_46 * u_xlat16_46;
                        u_xlat16_11.x = u_xlat16_11.x * u_xlat16_11.x;
                        u_xlat16_46 = u_xlat16_46 * u_xlat16_11.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_46 + 1.0;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_41;
                        u_xlat12.x = u_xlat1.x * u_xlat16_40;
                        u_xlat24 = abs(u_xlat36) + u_xlat1.x;
                        u_xlat24 = u_xlat24 + 9.99999975e-06;
                        u_xlat24 = 0.5 / u_xlat24;
                        u_xlat24 = u_xlat1.x * u_xlat24;
                        u_xlat24 = u_xlat24 * 0.999999881;
                        u_xlat16_11.xyz = u_xlat12.xxx * u_xlat16_5.xyz;
                        u_xlat12.xyz = u_xlat16_5.xyz * vec3(u_xlat24);
                        u_xlat16_40 = (-u_xlat0.x) + 1.0;
                        u_xlat16_5.x = u_xlat16_40 * u_xlat16_40;
                        u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_5.x;
                        u_xlat16_40 = u_xlat16_40 * 0.959999979 + 0.0399999991;
                        u_xlat0.xyz = u_xlat12.xyz * vec3(u_xlat16_40);
                        u_xlat0.xyz = u_xlat16_4.xyz * u_xlat16_11.xyz + u_xlat0.xyz;
                        u_xlat16_4.xyz = u_xlat16_10.xyz * vec3(0.5, 0.5, 0.5);
                        u_xlat16_40 = u_xlat16_46 * 2.23517418e-08 + 0.0399999991;
                        u_xlat0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_40) + u_xlat0.xyz;
                        SV_Target0.xyz = u_xlat0.xyz;
                        SV_Target0.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
                SubProgram "gles3 " {
                    Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	mediump vec4 unity_SHBr;
                    uniform 	mediump vec4 unity_SHBg;
                    uniform 	mediump vec4 unity_SHBb;
                    uniform 	mediump vec4 unity_SHC;
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out mediump vec3 vs_TEXCOORD3;
                    out highp vec4 vs_TEXCOORD5;
                    out highp vec4 vs_TEXCOORD6;
                    vec4 u_xlat0;
                    mediump vec4 u_xlat16_0;
                    vec4 u_xlat1;
                    mediump float u_xlat16_2;
                    mediump vec3 u_xlat16_3;
                    float u_xlat12;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
                        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat12 = inversesqrt(u_xlat12);
                        u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
                        vs_TEXCOORD1.xyz = u_xlat0.xyz;
                        u_xlat16_2 = u_xlat0.y * u_xlat0.y;
                        u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
                        u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
                        u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
                        u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
                        u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
                        vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
                        vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
                        vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_texture_lod
                    #extension GL_EXT_shader_texture_lod : enable
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec3 _WorldSpaceCameraPos;
                    uniform 	mediump vec4 _WorldSpaceLightPos0;
                    uniform 	mediump vec4 unity_SHAr;
                    uniform 	mediump vec4 unity_SHAg;
                    uniform 	mediump vec4 unity_SHAb;
                    uniform 	mediump vec4 unity_OcclusionMaskSelector;
                    uniform 	vec4 unity_SpecCube0_BoxMax;
                    uniform 	vec4 unity_SpecCube0_BoxMin;
                    uniform 	vec4 unity_SpecCube0_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube0_HDR;
                    uniform 	vec4 unity_SpecCube1_BoxMax;
                    uniform 	vec4 unity_SpecCube1_BoxMin;
                    uniform 	vec4 unity_SpecCube1_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube1_HDR;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    uniform 	mediump vec4 _LightColor0;
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform mediump samplerCube unity_SpecCube0;
                    UNITY_LOCATION(2) uniform mediump samplerCube unity_SpecCube1;
                    UNITY_LOCATION(3) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    in mediump vec3 vs_TEXCOORD3;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    vec3 u_xlat0;
                    vec3 u_xlat1;
                    vec3 u_xlat2;
                    vec4 u_xlat3;
                    mediump vec4 u_xlat16_3;
                    mediump vec3 u_xlat16_4;
                    mediump vec3 u_xlat16_5;
                    vec4 u_xlat6;
                    vec4 u_xlat7;
                    vec4 u_xlat8;
                    mediump vec3 u_xlat16_9;
                    bvec3 u_xlatb10;
                    vec3 u_xlat11;
                    mediump vec3 u_xlat16_11;
                    vec3 u_xlat12;
                    float u_xlat15;
                    mediump vec3 u_xlat16_16;
                    float u_xlat24;
                    float u_xlat36;
                    float u_xlat37;
                    bool u_xlatb37;
                    float u_xlat38;
                    bool u_xlatb38;
                    mediump float u_xlat16_40;
                    mediump float u_xlat16_41;
                    mediump float u_xlat16_45;
                    mediump float u_xlat16_47;
                    void main()
                    {
                        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb37){
                            u_xlatb38 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat3.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
                            u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat3.xyz = (bool(u_xlatb38)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat38 = u_xlat3.y * 0.25 + 0.75;
                            u_xlat15 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                            u_xlat3.x = max(u_xlat38, u_xlat15);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
                            u_xlat16_3 = u_xlat3;
                        } else {
                            u_xlat16_3.x = float(1.0);
                            u_xlat16_3.y = float(1.0);
                            u_xlat16_3.z = float(1.0);
                            u_xlat16_3.w = float(1.0);
                        }
                        u_xlat16_4.x = dot(u_xlat16_3, unity_OcclusionMaskSelector);
                        u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
                        u_xlat16_16.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
                        u_xlat16_16.x = u_xlat16_16.x + u_xlat16_16.x;
                        u_xlat16_16.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_16.xxx) + (-u_xlat1.xyz);
                        u_xlat16_5.xyz = u_xlat16_4.xxx * _LightColor0.xyz;
                        if(u_xlatb37){
                            u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat6.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
                            u_xlat6.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
                            u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat6.xyz = (bool(u_xlatb37)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
                            u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat3.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat37 = u_xlat3.y * 0.25;
                            u_xlat38 = unity_ProbeVolumeParams.z * 0.5;
                            u_xlat6.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
                            u_xlat37 = max(u_xlat37, u_xlat38);
                            u_xlat3.x = min(u_xlat6.x, u_xlat37);
                            u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
                            u_xlat7.xyz = u_xlat3.xzw + vec3(0.25, 0.0, 0.0);
                            u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
                            u_xlat8.xyz = u_xlat3.xzw + vec3(0.5, 0.0, 0.0);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
                            u_xlat8.xyz = vs_TEXCOORD1.xyz;
                            u_xlat8.w = 1.0;
                            u_xlat16_9.x = dot(u_xlat6, u_xlat8);
                            u_xlat16_9.y = dot(u_xlat7, u_xlat8);
                            u_xlat16_9.z = dot(u_xlat3, u_xlat8);
                        } else {
                            u_xlat3.xyz = vs_TEXCOORD1.xyz;
                            u_xlat3.w = 1.0;
                            u_xlat16_9.x = dot(unity_SHAr, u_xlat3);
                            u_xlat16_9.y = dot(unity_SHAg, u_xlat3);
                            u_xlat16_9.z = dot(unity_SHAb, u_xlat3);
                        }
                        u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
                        u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
                        u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
                        if(u_xlatb37){
                            u_xlat37 = dot(u_xlat16_16.xyz, u_xlat16_16.xyz);
                            u_xlat37 = inversesqrt(u_xlat37);
                            u_xlat6.xyz = vec3(u_xlat37) * u_xlat16_16.xyz;
                            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
                            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
                            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
                            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
                            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
                            {
                                vec4 hlslcc_movcTemp = u_xlat7;
                                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat7.x : u_xlat8.x;
                                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat7.y : u_xlat8.y;
                                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat7.z : u_xlat8.z;
                                u_xlat7 = hlslcc_movcTemp;
                            }
                            u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                            u_xlat37 = min(u_xlat7.z, u_xlat37);
                            u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
                            u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                        } else {
                            u_xlat6.xyz = u_xlat16_16.xyz;
                        }
                        u_xlat3 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
                        u_xlat16_4.x = u_xlat3.w + -1.0;
                        u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
                        u_xlat16_4.x = log2(u_xlat16_4.x);
                        u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.y;
                        u_xlat16_4.x = exp2(u_xlat16_4.x);
                        u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
                        u_xlat16_11.xyz = u_xlat3.xyz * u_xlat16_4.xxx;
                        u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
                        if(u_xlatb37){
                            u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
                            if(u_xlatb37){
                                u_xlat37 = dot(u_xlat16_16.xyz, u_xlat16_16.xyz);
                                u_xlat37 = inversesqrt(u_xlat37);
                                u_xlat6.xyz = vec3(u_xlat37) * u_xlat16_16.xyz;
                                u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
                                u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
                                u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
                                u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
                                u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
                                {
                                    vec4 hlslcc_movcTemp = u_xlat7;
                                    hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat7.x : u_xlat8.x;
                                    hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat7.y : u_xlat8.y;
                                    hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat7.z : u_xlat8.z;
                                    u_xlat7 = hlslcc_movcTemp;
                                }
                                u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                                u_xlat37 = min(u_xlat7.z, u_xlat37);
                                u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
                                u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                            } else {
                                u_xlat6.xyz = u_xlat16_16.xyz;
                            }
                            u_xlat6 = textureLod(unity_SpecCube1, u_xlat6.xyz, 6.0);
                            u_xlat16_16.x = u_xlat6.w + -1.0;
                            u_xlat16_16.x = unity_SpecCube1_HDR.w * u_xlat16_16.x + 1.0;
                            u_xlat16_16.x = log2(u_xlat16_16.x);
                            u_xlat16_16.x = u_xlat16_16.x * unity_SpecCube1_HDR.y;
                            u_xlat16_16.x = exp2(u_xlat16_16.x);
                            u_xlat16_16.x = u_xlat16_16.x * unity_SpecCube1_HDR.x;
                            u_xlat16_16.xyz = u_xlat6.xyz * u_xlat16_16.xxx;
                            u_xlat6.xyz = u_xlat16_4.xxx * u_xlat3.xyz + (-u_xlat16_16.xyz);
                            u_xlat11.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat16_16.xyz;
                            u_xlat16_11.xyz = u_xlat11.xyz;
                        }
                        u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
                        u_xlat37 = inversesqrt(u_xlat37);
                        u_xlat6.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
                        u_xlat16_4.xyz = u_xlat2.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = max(u_xlat36, 0.00100000005);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat36 = dot(u_xlat6.xyz, u_xlat1.xyz);
                        u_xlat1.x = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
                        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
                        u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
                        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
                        u_xlat16_40 = u_xlat0.x + u_xlat0.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat0.x + -0.5;
                        u_xlat16_41 = (-u_xlat1.x) + 1.0;
                        u_xlat16_45 = u_xlat16_41 * u_xlat16_41;
                        u_xlat16_45 = u_xlat16_45 * u_xlat16_45;
                        u_xlat16_41 = u_xlat16_41 * u_xlat16_45;
                        u_xlat16_41 = u_xlat16_40 * u_xlat16_41 + 1.0;
                        u_xlat16_45 = -abs(u_xlat36) + 1.0;
                        u_xlat16_47 = u_xlat16_45 * u_xlat16_45;
                        u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
                        u_xlat16_45 = u_xlat16_45 * u_xlat16_47;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_45 + 1.0;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_41;
                        u_xlat12.x = u_xlat1.x * u_xlat16_40;
                        u_xlat24 = abs(u_xlat36) + u_xlat1.x;
                        u_xlat24 = u_xlat24 + 9.99999975e-06;
                        u_xlat24 = 0.5 / u_xlat24;
                        u_xlat24 = u_xlat1.x * u_xlat24;
                        u_xlat24 = u_xlat24 * 0.999999881;
                        u_xlat16_9.xyz = u_xlat16_5.xyz * u_xlat12.xxx + u_xlat16_9.xyz;
                        u_xlat12.xyz = u_xlat16_5.xyz * vec3(u_xlat24);
                        u_xlat16_40 = (-u_xlat0.x) + 1.0;
                        u_xlat16_5.x = u_xlat16_40 * u_xlat16_40;
                        u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_5.x;
                        u_xlat16_40 = u_xlat16_40 * 0.959999979 + 0.0399999991;
                        u_xlat0.xyz = u_xlat12.xyz * vec3(u_xlat16_40);
                        u_xlat0.xyz = u_xlat16_4.xyz * u_xlat16_9.xyz + u_xlat0.xyz;
                        u_xlat16_4.xyz = u_xlat16_11.xyz * vec3(0.5, 0.5, 0.5);
                        u_xlat16_40 = u_xlat16_45 * 2.23517418e-08 + 0.0399999991;
                        u_xlat0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_40) + u_xlat0.xyz;
                        SV_Target0.xyz = u_xlat0.xyz;
                        SV_Target0.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
                SubProgram "gles3 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec4 _ProjectionParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out highp vec4 vs_TEXCOORD5;
                    out highp vec4 vs_TEXCOORD6;
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    float u_xlat7;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
                        gl_Position = u_xlat0;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
                        u_xlat7 = inversesqrt(u_xlat7);
                        vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
                        u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
                        u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
                        vs_TEXCOORD5.zw = u_xlat0.zw;
                        vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
                        vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_texture_lod
                    #extension GL_EXT_shader_texture_lod : enable
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec3 _WorldSpaceCameraPos;
                    uniform 	mediump vec4 _WorldSpaceLightPos0;
                    uniform 	mediump vec4 unity_OcclusionMaskSelector;
                    uniform 	vec4 _LightShadowData;
                    uniform 	vec4 unity_ShadowFadeCenterAndType;
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
                    uniform 	vec4 unity_SpecCube0_BoxMax;
                    uniform 	vec4 unity_SpecCube0_BoxMin;
                    uniform 	vec4 unity_SpecCube0_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube0_HDR;
                    uniform 	vec4 unity_SpecCube1_BoxMax;
                    uniform 	vec4 unity_SpecCube1_BoxMin;
                    uniform 	vec4 unity_SpecCube1_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube1_HDR;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    uniform 	mediump vec4 _LightColor0;
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform mediump sampler2D _ShadowMapTexture;
                    UNITY_LOCATION(2) uniform mediump samplerCube unity_SpecCube0;
                    UNITY_LOCATION(3) uniform mediump samplerCube unity_SpecCube1;
                    UNITY_LOCATION(4) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    in highp vec4 vs_TEXCOORD5;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    vec3 u_xlat0;
                    vec3 u_xlat1;
                    vec3 u_xlat2;
                    vec4 u_xlat3;
                    mediump vec4 u_xlat16_3;
                    mediump vec3 u_xlat16_4;
                    vec4 u_xlat5;
                    mediump vec3 u_xlat16_6;
                    vec3 u_xlat7;
                    vec3 u_xlat8;
                    bvec3 u_xlatb9;
                    vec3 u_xlat10;
                    mediump vec3 u_xlat16_10;
                    mediump vec3 u_xlat16_11;
                    vec3 u_xlat12;
                    float u_xlat15;
                    mediump vec3 u_xlat16_16;
                    float u_xlat24;
                    float u_xlat36;
                    float u_xlat37;
                    bool u_xlatb37;
                    float u_xlat38;
                    bool u_xlatb38;
                    mediump float u_xlat16_40;
                    mediump float u_xlat16_42;
                    mediump float u_xlat16_46;
                    void main()
                    {
                        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
                        u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
                        u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
                        u_xlat37 = dot(u_xlat0.xyz, u_xlat3.xyz);
                        u_xlat3.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
                        u_xlat38 = dot(u_xlat3.xyz, u_xlat3.xyz);
                        u_xlat38 = sqrt(u_xlat38);
                        u_xlat38 = (-u_xlat37) + u_xlat38;
                        u_xlat37 = unity_ShadowFadeCenterAndType.w * u_xlat38 + u_xlat37;
                        u_xlat37 = u_xlat37 * _LightShadowData.z + _LightShadowData.w;
                        u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
                        u_xlatb38 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb38){
                            u_xlatb38 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat3.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
                            u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat3.xyz = (bool(u_xlatb38)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat38 = u_xlat3.y * 0.25 + 0.75;
                            u_xlat15 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                            u_xlat3.x = max(u_xlat38, u_xlat15);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
                            u_xlat16_3 = u_xlat3;
                        } else {
                            u_xlat16_3.x = float(1.0);
                            u_xlat16_3.y = float(1.0);
                            u_xlat16_3.z = float(1.0);
                            u_xlat16_3.w = float(1.0);
                        }
                        u_xlat16_4.x = dot(u_xlat16_3, unity_OcclusionMaskSelector);
                        u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
                        u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
                        u_xlat5.x = texture(_ShadowMapTexture, u_xlat5.xy).x;
                        u_xlat16_4.x = u_xlat16_4.x + (-u_xlat5.x);
                        u_xlat16_4.x = u_xlat37 * u_xlat16_4.x + u_xlat5.x;
                        u_xlat16_16.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
                        u_xlat16_16.x = u_xlat16_16.x + u_xlat16_16.x;
                        u_xlat16_16.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_16.xxx) + (-u_xlat1.xyz);
                        u_xlat16_6.xyz = u_xlat16_4.xxx * _LightColor0.xyz;
                        u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
                        if(u_xlatb37){
                            u_xlat37 = dot(u_xlat16_16.xyz, u_xlat16_16.xyz);
                            u_xlat37 = inversesqrt(u_xlat37);
                            u_xlat5.xyz = vec3(u_xlat37) * u_xlat16_16.xyz;
                            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
                            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
                            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
                            u_xlat8.xyz = u_xlat8.xyz / u_xlat5.xyz;
                            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
                            {
                                vec3 hlslcc_movcTemp = u_xlat7;
                                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
                                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
                                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
                                u_xlat7 = hlslcc_movcTemp;
                            }
                            u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                            u_xlat37 = min(u_xlat7.z, u_xlat37);
                            u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
                            u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                        } else {
                            u_xlat5.xyz = u_xlat16_16.xyz;
                        }
                        u_xlat3 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
                        u_xlat16_4.x = u_xlat3.w + -1.0;
                        u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
                        u_xlat16_4.x = log2(u_xlat16_4.x);
                        u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.y;
                        u_xlat16_4.x = exp2(u_xlat16_4.x);
                        u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
                        u_xlat16_10.xyz = u_xlat3.xyz * u_xlat16_4.xxx;
                        u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
                        if(u_xlatb37){
                            u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
                            if(u_xlatb37){
                                u_xlat37 = dot(u_xlat16_16.xyz, u_xlat16_16.xyz);
                                u_xlat37 = inversesqrt(u_xlat37);
                                u_xlat5.xyz = vec3(u_xlat37) * u_xlat16_16.xyz;
                                u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
                                u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
                                u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
                                u_xlat8.xyz = u_xlat8.xyz / u_xlat5.xyz;
                                u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
                                {
                                    vec3 hlslcc_movcTemp = u_xlat7;
                                    hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
                                    hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
                                    hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
                                    u_xlat7 = hlslcc_movcTemp;
                                }
                                u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                                u_xlat37 = min(u_xlat7.z, u_xlat37);
                                u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
                                u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                            } else {
                                u_xlat5.xyz = u_xlat16_16.xyz;
                            }
                            u_xlat5 = textureLod(unity_SpecCube1, u_xlat5.xyz, 6.0);
                            u_xlat16_16.x = u_xlat5.w + -1.0;
                            u_xlat16_16.x = unity_SpecCube1_HDR.w * u_xlat16_16.x + 1.0;
                            u_xlat16_16.x = log2(u_xlat16_16.x);
                            u_xlat16_16.x = u_xlat16_16.x * unity_SpecCube1_HDR.y;
                            u_xlat16_16.x = exp2(u_xlat16_16.x);
                            u_xlat16_16.x = u_xlat16_16.x * unity_SpecCube1_HDR.x;
                            u_xlat16_16.xyz = u_xlat5.xyz * u_xlat16_16.xxx;
                            u_xlat5.xyz = u_xlat16_4.xxx * u_xlat3.xyz + (-u_xlat16_16.xyz);
                            u_xlat10.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat16_16.xyz;
                            u_xlat16_10.xyz = u_xlat10.xyz;
                        }
                        u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
                        u_xlat37 = inversesqrt(u_xlat37);
                        u_xlat5.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
                        u_xlat16_4.xyz = u_xlat2.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = max(u_xlat36, 0.00100000005);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat36 = dot(u_xlat5.xyz, u_xlat1.xyz);
                        u_xlat1.x = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
                        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
                        u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
                        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
                        u_xlat16_40 = u_xlat0.x + u_xlat0.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat0.x + -0.5;
                        u_xlat16_42 = (-u_xlat1.x) + 1.0;
                        u_xlat16_46 = u_xlat16_42 * u_xlat16_42;
                        u_xlat16_46 = u_xlat16_46 * u_xlat16_46;
                        u_xlat16_42 = u_xlat16_42 * u_xlat16_46;
                        u_xlat16_42 = u_xlat16_40 * u_xlat16_42 + 1.0;
                        u_xlat16_46 = -abs(u_xlat36) + 1.0;
                        u_xlat16_11.x = u_xlat16_46 * u_xlat16_46;
                        u_xlat16_11.x = u_xlat16_11.x * u_xlat16_11.x;
                        u_xlat16_46 = u_xlat16_46 * u_xlat16_11.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_46 + 1.0;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_42;
                        u_xlat12.x = u_xlat1.x * u_xlat16_40;
                        u_xlat24 = abs(u_xlat36) + u_xlat1.x;
                        u_xlat24 = u_xlat24 + 9.99999975e-06;
                        u_xlat24 = 0.5 / u_xlat24;
                        u_xlat24 = u_xlat1.x * u_xlat24;
                        u_xlat24 = u_xlat24 * 0.999999881;
                        u_xlat16_11.xyz = u_xlat12.xxx * u_xlat16_6.xyz;
                        u_xlat12.xyz = u_xlat16_6.xyz * vec3(u_xlat24);
                        u_xlat16_40 = (-u_xlat0.x) + 1.0;
                        u_xlat16_6.x = u_xlat16_40 * u_xlat16_40;
                        u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_6.x;
                        u_xlat16_40 = u_xlat16_40 * 0.959999979 + 0.0399999991;
                        u_xlat0.xyz = u_xlat12.xyz * vec3(u_xlat16_40);
                        u_xlat0.xyz = u_xlat16_4.xyz * u_xlat16_11.xyz + u_xlat0.xyz;
                        u_xlat16_4.xyz = u_xlat16_10.xyz * vec3(0.5, 0.5, 0.5);
                        u_xlat16_40 = u_xlat16_46 * 2.23517418e-08 + 0.0399999991;
                        u_xlat0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_40) + u_xlat0.xyz;
                        SV_Target0.xyz = u_xlat0.xyz;
                        SV_Target0.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
                SubProgram "gles3 " {
                    Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec4 _ProjectionParams;
                    uniform 	mediump vec4 unity_SHBr;
                    uniform 	mediump vec4 unity_SHBg;
                    uniform 	mediump vec4 unity_SHBb;
                    uniform 	mediump vec4 unity_SHC;
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out mediump vec3 vs_TEXCOORD3;
                    out highp vec4 vs_TEXCOORD5;
                    out highp vec4 vs_TEXCOORD6;
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    mediump vec4 u_xlat16_1;
                    mediump float u_xlat16_2;
                    mediump vec3 u_xlat16_3;
                    vec4 u_xlat4;
                    float u_xlat16;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
                        gl_Position = u_xlat0;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
                        u_xlat16 = inversesqrt(u_xlat16);
                        u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
                        vs_TEXCOORD1.xyz = u_xlat1.xyz;
                        u_xlat16_2 = u_xlat1.y * u_xlat1.y;
                        u_xlat16_2 = u_xlat1.x * u_xlat1.x + (-u_xlat16_2);
                        u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
                        u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
                        u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
                        u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
                        vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
                        u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
                        u_xlat4.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
                        vs_TEXCOORD5.zw = u_xlat0.zw;
                        vs_TEXCOORD5.xy = u_xlat4.zz + u_xlat4.xw;
                        vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_texture_lod
                    #extension GL_EXT_shader_texture_lod : enable
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec3 _WorldSpaceCameraPos;
                    uniform 	mediump vec4 _WorldSpaceLightPos0;
                    uniform 	mediump vec4 unity_SHAr;
                    uniform 	mediump vec4 unity_SHAg;
                    uniform 	mediump vec4 unity_SHAb;
                    uniform 	mediump vec4 unity_OcclusionMaskSelector;
                    uniform 	vec4 _LightShadowData;
                    uniform 	vec4 unity_ShadowFadeCenterAndType;
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
                    uniform 	vec4 unity_SpecCube0_BoxMax;
                    uniform 	vec4 unity_SpecCube0_BoxMin;
                    uniform 	vec4 unity_SpecCube0_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube0_HDR;
                    uniform 	vec4 unity_SpecCube1_BoxMax;
                    uniform 	vec4 unity_SpecCube1_BoxMin;
                    uniform 	vec4 unity_SpecCube1_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube1_HDR;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    uniform 	mediump vec4 _LightColor0;
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform mediump sampler2D _ShadowMapTexture;
                    UNITY_LOCATION(2) uniform mediump samplerCube unity_SpecCube0;
                    UNITY_LOCATION(3) uniform mediump samplerCube unity_SpecCube1;
                    UNITY_LOCATION(4) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    in mediump vec3 vs_TEXCOORD3;
                    in highp vec4 vs_TEXCOORD5;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    vec3 u_xlat0;
                    vec3 u_xlat1;
                    vec3 u_xlat2;
                    vec4 u_xlat3;
                    mediump vec4 u_xlat16_3;
                    bool u_xlatb3;
                    vec4 u_xlat4;
                    mediump vec3 u_xlat16_5;
                    mediump vec3 u_xlat16_6;
                    vec4 u_xlat7;
                    vec4 u_xlat8;
                    mediump vec3 u_xlat16_9;
                    bvec3 u_xlatb10;
                    vec3 u_xlat11;
                    mediump vec3 u_xlat16_11;
                    vec3 u_xlat12;
                    vec3 u_xlat15;
                    float u_xlat16;
                    mediump vec3 u_xlat16_17;
                    float u_xlat24;
                    float u_xlat36;
                    float u_xlat37;
                    bool u_xlatb37;
                    float u_xlat38;
                    bool u_xlatb38;
                    mediump float u_xlat16_41;
                    mediump float u_xlat16_42;
                    mediump float u_xlat16_45;
                    mediump float u_xlat16_47;
                    void main()
                    {
                        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
                        u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
                        u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
                        u_xlat37 = dot(u_xlat0.xyz, u_xlat3.xyz);
                        u_xlat3.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
                        u_xlat38 = dot(u_xlat3.xyz, u_xlat3.xyz);
                        u_xlat38 = sqrt(u_xlat38);
                        u_xlat38 = (-u_xlat37) + u_xlat38;
                        u_xlat37 = unity_ShadowFadeCenterAndType.w * u_xlat38 + u_xlat37;
                        u_xlat37 = u_xlat37 * _LightShadowData.z + _LightShadowData.w;
                        u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
                        u_xlatb38 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb38){
                            u_xlatb3 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat15.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat15.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat15.xyz;
                            u_xlat15.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat15.xyz;
                            u_xlat15.xyz = u_xlat15.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat3.xyz = (bool(u_xlatb3)) ? u_xlat15.xyz : vs_TEXCOORD2.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat15.x = u_xlat3.y * 0.25 + 0.75;
                            u_xlat4.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                            u_xlat3.x = max(u_xlat15.x, u_xlat4.x);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
                            u_xlat16_3 = u_xlat3;
                        } else {
                            u_xlat16_3.x = float(1.0);
                            u_xlat16_3.y = float(1.0);
                            u_xlat16_3.z = float(1.0);
                            u_xlat16_3.w = float(1.0);
                        }
                        u_xlat16_5.x = dot(u_xlat16_3, unity_OcclusionMaskSelector);
                        u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
                        u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
                        u_xlat4.x = texture(_ShadowMapTexture, u_xlat4.xy).x;
                        u_xlat16_5.x = (-u_xlat4.x) + u_xlat16_5.x;
                        u_xlat16_5.x = u_xlat37 * u_xlat16_5.x + u_xlat4.x;
                        u_xlat16_17.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
                        u_xlat16_17.x = u_xlat16_17.x + u_xlat16_17.x;
                        u_xlat16_17.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_17.xxx) + (-u_xlat1.xyz);
                        u_xlat16_6.xyz = u_xlat16_5.xxx * _LightColor0.xyz;
                        if(u_xlatb38){
                            u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat4.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat4.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
                            u_xlat4.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
                            u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat4.xyz = (bool(u_xlatb37)) ? u_xlat4.xyz : vs_TEXCOORD2.xyz;
                            u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat3.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat37 = u_xlat3.y * 0.25;
                            u_xlat4.x = unity_ProbeVolumeParams.z * 0.5;
                            u_xlat16 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
                            u_xlat37 = max(u_xlat37, u_xlat4.x);
                            u_xlat3.x = min(u_xlat16, u_xlat37);
                            u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
                            u_xlat7.xyz = u_xlat3.xzw + vec3(0.25, 0.0, 0.0);
                            u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
                            u_xlat8.xyz = u_xlat3.xzw + vec3(0.5, 0.0, 0.0);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
                            u_xlat8.xyz = vs_TEXCOORD1.xyz;
                            u_xlat8.w = 1.0;
                            u_xlat16_9.x = dot(u_xlat4, u_xlat8);
                            u_xlat16_9.y = dot(u_xlat7, u_xlat8);
                            u_xlat16_9.z = dot(u_xlat3, u_xlat8);
                        } else {
                            u_xlat3.xyz = vs_TEXCOORD1.xyz;
                            u_xlat3.w = 1.0;
                            u_xlat16_9.x = dot(unity_SHAr, u_xlat3);
                            u_xlat16_9.y = dot(unity_SHAg, u_xlat3);
                            u_xlat16_9.z = dot(unity_SHAb, u_xlat3);
                        }
                        u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
                        u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
                        u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
                        if(u_xlatb37){
                            u_xlat37 = dot(u_xlat16_17.xyz, u_xlat16_17.xyz);
                            u_xlat37 = inversesqrt(u_xlat37);
                            u_xlat4.xyz = vec3(u_xlat37) * u_xlat16_17.xyz;
                            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
                            u_xlat7.xyz = u_xlat7.xyz / u_xlat4.xyz;
                            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
                            u_xlat8.xyz = u_xlat8.xyz / u_xlat4.xyz;
                            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
                            {
                                vec4 hlslcc_movcTemp = u_xlat7;
                                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat7.x : u_xlat8.x;
                                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat7.y : u_xlat8.y;
                                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat7.z : u_xlat8.z;
                                u_xlat7 = hlslcc_movcTemp;
                            }
                            u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                            u_xlat37 = min(u_xlat7.z, u_xlat37);
                            u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
                            u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                        } else {
                            u_xlat4.xyz = u_xlat16_17.xyz;
                        }
                        u_xlat3 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
                        u_xlat16_5.x = u_xlat3.w + -1.0;
                        u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
                        u_xlat16_5.x = log2(u_xlat16_5.x);
                        u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.y;
                        u_xlat16_5.x = exp2(u_xlat16_5.x);
                        u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
                        u_xlat16_11.xyz = u_xlat3.xyz * u_xlat16_5.xxx;
                        u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
                        if(u_xlatb37){
                            u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
                            if(u_xlatb37){
                                u_xlat37 = dot(u_xlat16_17.xyz, u_xlat16_17.xyz);
                                u_xlat37 = inversesqrt(u_xlat37);
                                u_xlat4.xyz = vec3(u_xlat37) * u_xlat16_17.xyz;
                                u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
                                u_xlat7.xyz = u_xlat7.xyz / u_xlat4.xyz;
                                u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
                                u_xlat8.xyz = u_xlat8.xyz / u_xlat4.xyz;
                                u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
                                {
                                    vec4 hlslcc_movcTemp = u_xlat7;
                                    hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat7.x : u_xlat8.x;
                                    hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat7.y : u_xlat8.y;
                                    hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat7.z : u_xlat8.z;
                                    u_xlat7 = hlslcc_movcTemp;
                                }
                                u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                                u_xlat37 = min(u_xlat7.z, u_xlat37);
                                u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
                                u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                            } else {
                                u_xlat4.xyz = u_xlat16_17.xyz;
                            }
                            u_xlat4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 6.0);
                            u_xlat16_17.x = u_xlat4.w + -1.0;
                            u_xlat16_17.x = unity_SpecCube1_HDR.w * u_xlat16_17.x + 1.0;
                            u_xlat16_17.x = log2(u_xlat16_17.x);
                            u_xlat16_17.x = u_xlat16_17.x * unity_SpecCube1_HDR.y;
                            u_xlat16_17.x = exp2(u_xlat16_17.x);
                            u_xlat16_17.x = u_xlat16_17.x * unity_SpecCube1_HDR.x;
                            u_xlat16_17.xyz = u_xlat4.xyz * u_xlat16_17.xxx;
                            u_xlat4.xyz = u_xlat16_5.xxx * u_xlat3.xyz + (-u_xlat16_17.xyz);
                            u_xlat11.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat16_17.xyz;
                            u_xlat16_11.xyz = u_xlat11.xyz;
                        }
                        u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
                        u_xlat37 = inversesqrt(u_xlat37);
                        u_xlat4.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
                        u_xlat16_5.xyz = u_xlat2.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = max(u_xlat36, 0.00100000005);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat36 = dot(u_xlat4.xyz, u_xlat1.xyz);
                        u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
                        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
                        u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
                        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
                        u_xlat16_41 = u_xlat0.x + u_xlat0.x;
                        u_xlat16_41 = u_xlat16_41 * u_xlat0.x + -0.5;
                        u_xlat16_42 = (-u_xlat1.x) + 1.0;
                        u_xlat16_45 = u_xlat16_42 * u_xlat16_42;
                        u_xlat16_45 = u_xlat16_45 * u_xlat16_45;
                        u_xlat16_42 = u_xlat16_42 * u_xlat16_45;
                        u_xlat16_42 = u_xlat16_41 * u_xlat16_42 + 1.0;
                        u_xlat16_45 = -abs(u_xlat36) + 1.0;
                        u_xlat16_47 = u_xlat16_45 * u_xlat16_45;
                        u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
                        u_xlat16_45 = u_xlat16_45 * u_xlat16_47;
                        u_xlat16_41 = u_xlat16_41 * u_xlat16_45 + 1.0;
                        u_xlat16_41 = u_xlat16_41 * u_xlat16_42;
                        u_xlat12.x = u_xlat1.x * u_xlat16_41;
                        u_xlat24 = abs(u_xlat36) + u_xlat1.x;
                        u_xlat24 = u_xlat24 + 9.99999975e-06;
                        u_xlat24 = 0.5 / u_xlat24;
                        u_xlat24 = u_xlat1.x * u_xlat24;
                        u_xlat24 = u_xlat24 * 0.999999881;
                        u_xlat16_9.xyz = u_xlat16_6.xyz * u_xlat12.xxx + u_xlat16_9.xyz;
                        u_xlat12.xyz = u_xlat16_6.xyz * vec3(u_xlat24);
                        u_xlat16_41 = (-u_xlat0.x) + 1.0;
                        u_xlat16_6.x = u_xlat16_41 * u_xlat16_41;
                        u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
                        u_xlat16_41 = u_xlat16_41 * u_xlat16_6.x;
                        u_xlat16_41 = u_xlat16_41 * 0.959999979 + 0.0399999991;
                        u_xlat0.xyz = u_xlat12.xyz * vec3(u_xlat16_41);
                        u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz + u_xlat0.xyz;
                        u_xlat16_5.xyz = u_xlat16_11.xyz * vec3(0.5, 0.5, 0.5);
                        u_xlat16_41 = u_xlat16_45 * 2.23517418e-08 + 0.0399999991;
                        u_xlat0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41) + u_xlat0.xyz;
                        SV_Target0.xyz = u_xlat0.xyz;
                        SV_Target0.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
                SubProgram "gles3 " {
                    Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out highp vec4 vs_TEXCOORD5;
                    out highp vec4 vs_TEXCOORD6;
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    float u_xlat6;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
                        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat6 = inversesqrt(u_xlat6);
                        vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
                        vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
                        vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_texture_lod
                    #extension GL_EXT_shader_texture_lod : enable
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec3 _WorldSpaceCameraPos;
                    uniform 	mediump vec4 _WorldSpaceLightPos0;
                    uniform 	mediump vec4 unity_OcclusionMaskSelector;
                    uniform 	vec4 unity_SpecCube0_BoxMax;
                    uniform 	vec4 unity_SpecCube0_BoxMin;
                    uniform 	vec4 unity_SpecCube0_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube0_HDR;
                    uniform 	vec4 unity_SpecCube1_BoxMax;
                    uniform 	vec4 unity_SpecCube1_BoxMin;
                    uniform 	vec4 unity_SpecCube1_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube1_HDR;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    uniform 	mediump vec4 _LightColor0;
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform mediump samplerCube unity_SpecCube0;
                    UNITY_LOCATION(2) uniform mediump samplerCube unity_SpecCube1;
                    UNITY_LOCATION(3) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    vec3 u_xlat0;
                    vec3 u_xlat1;
                    vec3 u_xlat2;
                    vec4 u_xlat3;
                    mediump vec4 u_xlat16_3;
                    mediump vec3 u_xlat16_4;
                    mediump vec3 u_xlat16_5;
                    vec4 u_xlat6;
                    vec3 u_xlat7;
                    vec3 u_xlat8;
                    bvec3 u_xlatb9;
                    vec3 u_xlat10;
                    mediump vec3 u_xlat16_10;
                    mediump vec3 u_xlat16_11;
                    vec3 u_xlat12;
                    mediump vec3 u_xlat16_16;
                    float u_xlat24;
                    float u_xlat36;
                    float u_xlat37;
                    bool u_xlatb37;
                    float u_xlat38;
                    mediump float u_xlat16_40;
                    mediump float u_xlat16_41;
                    mediump float u_xlat16_46;
                    void main()
                    {
                        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb37){
                            u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat3.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
                            u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat3.xyz = (bool(u_xlatb37)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat37 = u_xlat3.y * 0.25 + 0.75;
                            u_xlat38 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                            u_xlat3.x = max(u_xlat37, u_xlat38);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
                            u_xlat16_3 = u_xlat3;
                        } else {
                            u_xlat16_3.x = float(1.0);
                            u_xlat16_3.y = float(1.0);
                            u_xlat16_3.z = float(1.0);
                            u_xlat16_3.w = float(1.0);
                        }
                        u_xlat16_4.x = dot(u_xlat16_3, unity_OcclusionMaskSelector);
                        u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
                        u_xlat16_16.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
                        u_xlat16_16.x = u_xlat16_16.x + u_xlat16_16.x;
                        u_xlat16_16.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_16.xxx) + (-u_xlat1.xyz);
                        u_xlat16_5.xyz = u_xlat16_4.xxx * _LightColor0.xyz;
                        u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
                        if(u_xlatb37){
                            u_xlat37 = dot(u_xlat16_16.xyz, u_xlat16_16.xyz);
                            u_xlat37 = inversesqrt(u_xlat37);
                            u_xlat6.xyz = vec3(u_xlat37) * u_xlat16_16.xyz;
                            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
                            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
                            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
                            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
                            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
                            {
                                vec3 hlslcc_movcTemp = u_xlat7;
                                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
                                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
                                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
                                u_xlat7 = hlslcc_movcTemp;
                            }
                            u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                            u_xlat37 = min(u_xlat7.z, u_xlat37);
                            u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
                            u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                        } else {
                            u_xlat6.xyz = u_xlat16_16.xyz;
                        }
                        u_xlat3 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
                        u_xlat16_4.x = u_xlat3.w + -1.0;
                        u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
                        u_xlat16_4.x = log2(u_xlat16_4.x);
                        u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.y;
                        u_xlat16_4.x = exp2(u_xlat16_4.x);
                        u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
                        u_xlat16_10.xyz = u_xlat3.xyz * u_xlat16_4.xxx;
                        u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
                        if(u_xlatb37){
                            u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
                            if(u_xlatb37){
                                u_xlat37 = dot(u_xlat16_16.xyz, u_xlat16_16.xyz);
                                u_xlat37 = inversesqrt(u_xlat37);
                                u_xlat6.xyz = vec3(u_xlat37) * u_xlat16_16.xyz;
                                u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
                                u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
                                u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
                                u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
                                u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
                                {
                                    vec3 hlslcc_movcTemp = u_xlat7;
                                    hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
                                    hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
                                    hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
                                    u_xlat7 = hlslcc_movcTemp;
                                }
                                u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                                u_xlat37 = min(u_xlat7.z, u_xlat37);
                                u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
                                u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                            } else {
                                u_xlat6.xyz = u_xlat16_16.xyz;
                            }
                            u_xlat6 = textureLod(unity_SpecCube1, u_xlat6.xyz, 6.0);
                            u_xlat16_16.x = u_xlat6.w + -1.0;
                            u_xlat16_16.x = unity_SpecCube1_HDR.w * u_xlat16_16.x + 1.0;
                            u_xlat16_16.x = log2(u_xlat16_16.x);
                            u_xlat16_16.x = u_xlat16_16.x * unity_SpecCube1_HDR.y;
                            u_xlat16_16.x = exp2(u_xlat16_16.x);
                            u_xlat16_16.x = u_xlat16_16.x * unity_SpecCube1_HDR.x;
                            u_xlat16_16.xyz = u_xlat6.xyz * u_xlat16_16.xxx;
                            u_xlat6.xyz = u_xlat16_4.xxx * u_xlat3.xyz + (-u_xlat16_16.xyz);
                            u_xlat10.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat16_16.xyz;
                            u_xlat16_10.xyz = u_xlat10.xyz;
                        }
                        u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
                        u_xlat37 = inversesqrt(u_xlat37);
                        u_xlat6.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
                        u_xlat16_4.xyz = u_xlat2.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = max(u_xlat36, 0.00100000005);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat36 = dot(u_xlat6.xyz, u_xlat1.xyz);
                        u_xlat1.x = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
                        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
                        u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
                        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
                        u_xlat16_40 = u_xlat0.x + u_xlat0.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat0.x + -0.5;
                        u_xlat16_41 = (-u_xlat1.x) + 1.0;
                        u_xlat16_46 = u_xlat16_41 * u_xlat16_41;
                        u_xlat16_46 = u_xlat16_46 * u_xlat16_46;
                        u_xlat16_41 = u_xlat16_41 * u_xlat16_46;
                        u_xlat16_41 = u_xlat16_40 * u_xlat16_41 + 1.0;
                        u_xlat16_46 = -abs(u_xlat36) + 1.0;
                        u_xlat16_11.x = u_xlat16_46 * u_xlat16_46;
                        u_xlat16_11.x = u_xlat16_11.x * u_xlat16_11.x;
                        u_xlat16_46 = u_xlat16_46 * u_xlat16_11.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_46 + 1.0;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_41;
                        u_xlat12.x = u_xlat1.x * u_xlat16_40;
                        u_xlat24 = abs(u_xlat36) + u_xlat1.x;
                        u_xlat24 = u_xlat24 + 9.99999975e-06;
                        u_xlat24 = 0.5 / u_xlat24;
                        u_xlat24 = u_xlat1.x * u_xlat24;
                        u_xlat24 = u_xlat24 * 0.999999881;
                        u_xlat16_11.xyz = u_xlat12.xxx * u_xlat16_5.xyz;
                        u_xlat12.xyz = u_xlat16_5.xyz * vec3(u_xlat24);
                        u_xlat16_40 = (-u_xlat0.x) + 1.0;
                        u_xlat16_5.x = u_xlat16_40 * u_xlat16_40;
                        u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_5.x;
                        u_xlat16_40 = u_xlat16_40 * 0.959999979 + 0.0399999991;
                        u_xlat0.xyz = u_xlat12.xyz * vec3(u_xlat16_40);
                        u_xlat0.xyz = u_xlat16_4.xyz * u_xlat16_11.xyz + u_xlat0.xyz;
                        u_xlat16_4.xyz = u_xlat16_10.xyz * vec3(0.5, 0.5, 0.5);
                        u_xlat16_40 = u_xlat16_46 * 2.23517418e-08 + 0.0399999991;
                        u_xlat0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_40) + u_xlat0.xyz;
                        SV_Target0.xyz = u_xlat0.xyz;
                        SV_Target0.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
                SubProgram "gles3 " {
                    Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec4 unity_4LightPosX0;
                    uniform 	vec4 unity_4LightPosY0;
                    uniform 	vec4 unity_4LightPosZ0;
                    uniform 	mediump vec4 unity_4LightAtten0;
                    uniform 	mediump vec4 unity_LightColor[8];
                    uniform 	mediump vec4 unity_SHBr;
                    uniform 	mediump vec4 unity_SHBg;
                    uniform 	mediump vec4 unity_SHBb;
                    uniform 	mediump vec4 unity_SHC;
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out mediump vec3 vs_TEXCOORD3;
                    out highp vec4 vs_TEXCOORD5;
                    out highp vec4 vs_TEXCOORD6;
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    mediump vec4 u_xlat16_1;
                    vec4 u_xlat2;
                    vec4 u_xlat3;
                    vec4 u_xlat4;
                    mediump vec3 u_xlat16_5;
                    mediump vec3 u_xlat16_6;
                    float u_xlat21;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
                        u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
                        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
                        u_xlat21 = inversesqrt(u_xlat21);
                        u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
                        vs_TEXCOORD1.xyz = u_xlat1.xyz;
                        vs_TEXCOORD2.xyz = u_xlat0.xyz;
                        u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
                        u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
                        u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
                        u_xlat4 = u_xlat1.yyyy * u_xlat3;
                        u_xlat3 = u_xlat3 * u_xlat3;
                        u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
                        u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
                        u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
                        u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
                        u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
                        u_xlat3 = inversesqrt(u_xlat0);
                        u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
                        u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
                        u_xlat2 = u_xlat2 * u_xlat3;
                        u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
                        u_xlat0 = u_xlat0 * u_xlat2;
                        u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
                        u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
                        u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
                        u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
                        u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
                        u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
                        u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
                        u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
                        u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
                        u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
                        u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
                        vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat16_5.xyz;
                        vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
                        vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_texture_lod
                    #extension GL_EXT_shader_texture_lod : enable
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec3 _WorldSpaceCameraPos;
                    uniform 	mediump vec4 _WorldSpaceLightPos0;
                    uniform 	mediump vec4 unity_SHAr;
                    uniform 	mediump vec4 unity_SHAg;
                    uniform 	mediump vec4 unity_SHAb;
                    uniform 	mediump vec4 unity_OcclusionMaskSelector;
                    uniform 	vec4 unity_SpecCube0_BoxMax;
                    uniform 	vec4 unity_SpecCube0_BoxMin;
                    uniform 	vec4 unity_SpecCube0_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube0_HDR;
                    uniform 	vec4 unity_SpecCube1_BoxMax;
                    uniform 	vec4 unity_SpecCube1_BoxMin;
                    uniform 	vec4 unity_SpecCube1_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube1_HDR;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    uniform 	mediump vec4 _LightColor0;
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform mediump samplerCube unity_SpecCube0;
                    UNITY_LOCATION(2) uniform mediump samplerCube unity_SpecCube1;
                    UNITY_LOCATION(3) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    in mediump vec3 vs_TEXCOORD3;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    vec3 u_xlat0;
                    vec3 u_xlat1;
                    vec3 u_xlat2;
                    vec4 u_xlat3;
                    mediump vec4 u_xlat16_3;
                    mediump vec3 u_xlat16_4;
                    mediump vec3 u_xlat16_5;
                    vec4 u_xlat6;
                    vec4 u_xlat7;
                    vec4 u_xlat8;
                    mediump vec3 u_xlat16_9;
                    bvec3 u_xlatb10;
                    vec3 u_xlat11;
                    mediump vec3 u_xlat16_11;
                    vec3 u_xlat12;
                    float u_xlat15;
                    mediump vec3 u_xlat16_16;
                    float u_xlat24;
                    float u_xlat36;
                    float u_xlat37;
                    bool u_xlatb37;
                    float u_xlat38;
                    bool u_xlatb38;
                    mediump float u_xlat16_40;
                    mediump float u_xlat16_41;
                    mediump float u_xlat16_45;
                    mediump float u_xlat16_47;
                    void main()
                    {
                        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb37){
                            u_xlatb38 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat3.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
                            u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat3.xyz = (bool(u_xlatb38)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat38 = u_xlat3.y * 0.25 + 0.75;
                            u_xlat15 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                            u_xlat3.x = max(u_xlat38, u_xlat15);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
                            u_xlat16_3 = u_xlat3;
                        } else {
                            u_xlat16_3.x = float(1.0);
                            u_xlat16_3.y = float(1.0);
                            u_xlat16_3.z = float(1.0);
                            u_xlat16_3.w = float(1.0);
                        }
                        u_xlat16_4.x = dot(u_xlat16_3, unity_OcclusionMaskSelector);
                        u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
                        u_xlat16_16.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
                        u_xlat16_16.x = u_xlat16_16.x + u_xlat16_16.x;
                        u_xlat16_16.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_16.xxx) + (-u_xlat1.xyz);
                        u_xlat16_5.xyz = u_xlat16_4.xxx * _LightColor0.xyz;
                        if(u_xlatb37){
                            u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat6.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat6.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
                            u_xlat6.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
                            u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat6.xyz = (bool(u_xlatb37)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
                            u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat3.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat37 = u_xlat3.y * 0.25;
                            u_xlat38 = unity_ProbeVolumeParams.z * 0.5;
                            u_xlat6.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
                            u_xlat37 = max(u_xlat37, u_xlat38);
                            u_xlat3.x = min(u_xlat6.x, u_xlat37);
                            u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
                            u_xlat7.xyz = u_xlat3.xzw + vec3(0.25, 0.0, 0.0);
                            u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
                            u_xlat8.xyz = u_xlat3.xzw + vec3(0.5, 0.0, 0.0);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
                            u_xlat8.xyz = vs_TEXCOORD1.xyz;
                            u_xlat8.w = 1.0;
                            u_xlat16_9.x = dot(u_xlat6, u_xlat8);
                            u_xlat16_9.y = dot(u_xlat7, u_xlat8);
                            u_xlat16_9.z = dot(u_xlat3, u_xlat8);
                        } else {
                            u_xlat3.xyz = vs_TEXCOORD1.xyz;
                            u_xlat3.w = 1.0;
                            u_xlat16_9.x = dot(unity_SHAr, u_xlat3);
                            u_xlat16_9.y = dot(unity_SHAg, u_xlat3);
                            u_xlat16_9.z = dot(unity_SHAb, u_xlat3);
                        }
                        u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
                        u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
                        u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
                        if(u_xlatb37){
                            u_xlat37 = dot(u_xlat16_16.xyz, u_xlat16_16.xyz);
                            u_xlat37 = inversesqrt(u_xlat37);
                            u_xlat6.xyz = vec3(u_xlat37) * u_xlat16_16.xyz;
                            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
                            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
                            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
                            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
                            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
                            {
                                vec4 hlslcc_movcTemp = u_xlat7;
                                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat7.x : u_xlat8.x;
                                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat7.y : u_xlat8.y;
                                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat7.z : u_xlat8.z;
                                u_xlat7 = hlslcc_movcTemp;
                            }
                            u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                            u_xlat37 = min(u_xlat7.z, u_xlat37);
                            u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
                            u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                        } else {
                            u_xlat6.xyz = u_xlat16_16.xyz;
                        }
                        u_xlat3 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
                        u_xlat16_4.x = u_xlat3.w + -1.0;
                        u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
                        u_xlat16_4.x = log2(u_xlat16_4.x);
                        u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.y;
                        u_xlat16_4.x = exp2(u_xlat16_4.x);
                        u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
                        u_xlat16_11.xyz = u_xlat3.xyz * u_xlat16_4.xxx;
                        u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
                        if(u_xlatb37){
                            u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
                            if(u_xlatb37){
                                u_xlat37 = dot(u_xlat16_16.xyz, u_xlat16_16.xyz);
                                u_xlat37 = inversesqrt(u_xlat37);
                                u_xlat6.xyz = vec3(u_xlat37) * u_xlat16_16.xyz;
                                u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
                                u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
                                u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
                                u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
                                u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
                                {
                                    vec4 hlslcc_movcTemp = u_xlat7;
                                    hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat7.x : u_xlat8.x;
                                    hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat7.y : u_xlat8.y;
                                    hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat7.z : u_xlat8.z;
                                    u_xlat7 = hlslcc_movcTemp;
                                }
                                u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                                u_xlat37 = min(u_xlat7.z, u_xlat37);
                                u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
                                u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                            } else {
                                u_xlat6.xyz = u_xlat16_16.xyz;
                            }
                            u_xlat6 = textureLod(unity_SpecCube1, u_xlat6.xyz, 6.0);
                            u_xlat16_16.x = u_xlat6.w + -1.0;
                            u_xlat16_16.x = unity_SpecCube1_HDR.w * u_xlat16_16.x + 1.0;
                            u_xlat16_16.x = log2(u_xlat16_16.x);
                            u_xlat16_16.x = u_xlat16_16.x * unity_SpecCube1_HDR.y;
                            u_xlat16_16.x = exp2(u_xlat16_16.x);
                            u_xlat16_16.x = u_xlat16_16.x * unity_SpecCube1_HDR.x;
                            u_xlat16_16.xyz = u_xlat6.xyz * u_xlat16_16.xxx;
                            u_xlat6.xyz = u_xlat16_4.xxx * u_xlat3.xyz + (-u_xlat16_16.xyz);
                            u_xlat11.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat16_16.xyz;
                            u_xlat16_11.xyz = u_xlat11.xyz;
                        }
                        u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
                        u_xlat37 = inversesqrt(u_xlat37);
                        u_xlat6.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
                        u_xlat16_4.xyz = u_xlat2.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = max(u_xlat36, 0.00100000005);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat36 = dot(u_xlat6.xyz, u_xlat1.xyz);
                        u_xlat1.x = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
                        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
                        u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
                        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
                        u_xlat16_40 = u_xlat0.x + u_xlat0.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat0.x + -0.5;
                        u_xlat16_41 = (-u_xlat1.x) + 1.0;
                        u_xlat16_45 = u_xlat16_41 * u_xlat16_41;
                        u_xlat16_45 = u_xlat16_45 * u_xlat16_45;
                        u_xlat16_41 = u_xlat16_41 * u_xlat16_45;
                        u_xlat16_41 = u_xlat16_40 * u_xlat16_41 + 1.0;
                        u_xlat16_45 = -abs(u_xlat36) + 1.0;
                        u_xlat16_47 = u_xlat16_45 * u_xlat16_45;
                        u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
                        u_xlat16_45 = u_xlat16_45 * u_xlat16_47;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_45 + 1.0;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_41;
                        u_xlat12.x = u_xlat1.x * u_xlat16_40;
                        u_xlat24 = abs(u_xlat36) + u_xlat1.x;
                        u_xlat24 = u_xlat24 + 9.99999975e-06;
                        u_xlat24 = 0.5 / u_xlat24;
                        u_xlat24 = u_xlat1.x * u_xlat24;
                        u_xlat24 = u_xlat24 * 0.999999881;
                        u_xlat16_9.xyz = u_xlat16_5.xyz * u_xlat12.xxx + u_xlat16_9.xyz;
                        u_xlat12.xyz = u_xlat16_5.xyz * vec3(u_xlat24);
                        u_xlat16_40 = (-u_xlat0.x) + 1.0;
                        u_xlat16_5.x = u_xlat16_40 * u_xlat16_40;
                        u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_5.x;
                        u_xlat16_40 = u_xlat16_40 * 0.959999979 + 0.0399999991;
                        u_xlat0.xyz = u_xlat12.xyz * vec3(u_xlat16_40);
                        u_xlat0.xyz = u_xlat16_4.xyz * u_xlat16_9.xyz + u_xlat0.xyz;
                        u_xlat16_4.xyz = u_xlat16_11.xyz * vec3(0.5, 0.5, 0.5);
                        u_xlat16_40 = u_xlat16_45 * 2.23517418e-08 + 0.0399999991;
                        u_xlat0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_40) + u_xlat0.xyz;
                        SV_Target0.xyz = u_xlat0.xyz;
                        SV_Target0.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
                SubProgram "gles3 " {
                    Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec4 _ProjectionParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out highp vec4 vs_TEXCOORD5;
                    out highp vec4 vs_TEXCOORD6;
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    float u_xlat7;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
                        gl_Position = u_xlat0;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
                        u_xlat7 = inversesqrt(u_xlat7);
                        vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
                        u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
                        u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
                        vs_TEXCOORD5.zw = u_xlat0.zw;
                        vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
                        vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_texture_lod
                    #extension GL_EXT_shader_texture_lod : enable
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec3 _WorldSpaceCameraPos;
                    uniform 	mediump vec4 _WorldSpaceLightPos0;
                    uniform 	mediump vec4 unity_OcclusionMaskSelector;
                    uniform 	vec4 _LightShadowData;
                    uniform 	vec4 unity_ShadowFadeCenterAndType;
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
                    uniform 	vec4 unity_SpecCube0_BoxMax;
                    uniform 	vec4 unity_SpecCube0_BoxMin;
                    uniform 	vec4 unity_SpecCube0_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube0_HDR;
                    uniform 	vec4 unity_SpecCube1_BoxMax;
                    uniform 	vec4 unity_SpecCube1_BoxMin;
                    uniform 	vec4 unity_SpecCube1_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube1_HDR;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    uniform 	mediump vec4 _LightColor0;
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform mediump sampler2D _ShadowMapTexture;
                    UNITY_LOCATION(2) uniform mediump samplerCube unity_SpecCube0;
                    UNITY_LOCATION(3) uniform mediump samplerCube unity_SpecCube1;
                    UNITY_LOCATION(4) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    in highp vec4 vs_TEXCOORD5;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    vec3 u_xlat0;
                    vec3 u_xlat1;
                    vec3 u_xlat2;
                    vec4 u_xlat3;
                    mediump vec4 u_xlat16_3;
                    mediump vec3 u_xlat16_4;
                    vec4 u_xlat5;
                    mediump vec3 u_xlat16_6;
                    vec3 u_xlat7;
                    vec3 u_xlat8;
                    bvec3 u_xlatb9;
                    vec3 u_xlat10;
                    mediump vec3 u_xlat16_10;
                    mediump vec3 u_xlat16_11;
                    vec3 u_xlat12;
                    float u_xlat15;
                    mediump vec3 u_xlat16_16;
                    float u_xlat24;
                    float u_xlat36;
                    float u_xlat37;
                    bool u_xlatb37;
                    float u_xlat38;
                    bool u_xlatb38;
                    mediump float u_xlat16_40;
                    mediump float u_xlat16_42;
                    mediump float u_xlat16_46;
                    void main()
                    {
                        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
                        u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
                        u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
                        u_xlat37 = dot(u_xlat0.xyz, u_xlat3.xyz);
                        u_xlat3.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
                        u_xlat38 = dot(u_xlat3.xyz, u_xlat3.xyz);
                        u_xlat38 = sqrt(u_xlat38);
                        u_xlat38 = (-u_xlat37) + u_xlat38;
                        u_xlat37 = unity_ShadowFadeCenterAndType.w * u_xlat38 + u_xlat37;
                        u_xlat37 = u_xlat37 * _LightShadowData.z + _LightShadowData.w;
                        u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
                        u_xlatb38 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb38){
                            u_xlatb38 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat3.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
                            u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat3.xyz = (bool(u_xlatb38)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat38 = u_xlat3.y * 0.25 + 0.75;
                            u_xlat15 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                            u_xlat3.x = max(u_xlat38, u_xlat15);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
                            u_xlat16_3 = u_xlat3;
                        } else {
                            u_xlat16_3.x = float(1.0);
                            u_xlat16_3.y = float(1.0);
                            u_xlat16_3.z = float(1.0);
                            u_xlat16_3.w = float(1.0);
                        }
                        u_xlat16_4.x = dot(u_xlat16_3, unity_OcclusionMaskSelector);
                        u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
                        u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
                        u_xlat5.x = texture(_ShadowMapTexture, u_xlat5.xy).x;
                        u_xlat16_4.x = u_xlat16_4.x + (-u_xlat5.x);
                        u_xlat16_4.x = u_xlat37 * u_xlat16_4.x + u_xlat5.x;
                        u_xlat16_16.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
                        u_xlat16_16.x = u_xlat16_16.x + u_xlat16_16.x;
                        u_xlat16_16.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_16.xxx) + (-u_xlat1.xyz);
                        u_xlat16_6.xyz = u_xlat16_4.xxx * _LightColor0.xyz;
                        u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
                        if(u_xlatb37){
                            u_xlat37 = dot(u_xlat16_16.xyz, u_xlat16_16.xyz);
                            u_xlat37 = inversesqrt(u_xlat37);
                            u_xlat5.xyz = vec3(u_xlat37) * u_xlat16_16.xyz;
                            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
                            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
                            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
                            u_xlat8.xyz = u_xlat8.xyz / u_xlat5.xyz;
                            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
                            {
                                vec3 hlslcc_movcTemp = u_xlat7;
                                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
                                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
                                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
                                u_xlat7 = hlslcc_movcTemp;
                            }
                            u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                            u_xlat37 = min(u_xlat7.z, u_xlat37);
                            u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
                            u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                        } else {
                            u_xlat5.xyz = u_xlat16_16.xyz;
                        }
                        u_xlat3 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
                        u_xlat16_4.x = u_xlat3.w + -1.0;
                        u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
                        u_xlat16_4.x = log2(u_xlat16_4.x);
                        u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.y;
                        u_xlat16_4.x = exp2(u_xlat16_4.x);
                        u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
                        u_xlat16_10.xyz = u_xlat3.xyz * u_xlat16_4.xxx;
                        u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
                        if(u_xlatb37){
                            u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
                            if(u_xlatb37){
                                u_xlat37 = dot(u_xlat16_16.xyz, u_xlat16_16.xyz);
                                u_xlat37 = inversesqrt(u_xlat37);
                                u_xlat5.xyz = vec3(u_xlat37) * u_xlat16_16.xyz;
                                u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
                                u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
                                u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
                                u_xlat8.xyz = u_xlat8.xyz / u_xlat5.xyz;
                                u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
                                {
                                    vec3 hlslcc_movcTemp = u_xlat7;
                                    hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
                                    hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
                                    hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
                                    u_xlat7 = hlslcc_movcTemp;
                                }
                                u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                                u_xlat37 = min(u_xlat7.z, u_xlat37);
                                u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
                                u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                            } else {
                                u_xlat5.xyz = u_xlat16_16.xyz;
                            }
                            u_xlat5 = textureLod(unity_SpecCube1, u_xlat5.xyz, 6.0);
                            u_xlat16_16.x = u_xlat5.w + -1.0;
                            u_xlat16_16.x = unity_SpecCube1_HDR.w * u_xlat16_16.x + 1.0;
                            u_xlat16_16.x = log2(u_xlat16_16.x);
                            u_xlat16_16.x = u_xlat16_16.x * unity_SpecCube1_HDR.y;
                            u_xlat16_16.x = exp2(u_xlat16_16.x);
                            u_xlat16_16.x = u_xlat16_16.x * unity_SpecCube1_HDR.x;
                            u_xlat16_16.xyz = u_xlat5.xyz * u_xlat16_16.xxx;
                            u_xlat5.xyz = u_xlat16_4.xxx * u_xlat3.xyz + (-u_xlat16_16.xyz);
                            u_xlat10.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat16_16.xyz;
                            u_xlat16_10.xyz = u_xlat10.xyz;
                        }
                        u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
                        u_xlat37 = inversesqrt(u_xlat37);
                        u_xlat5.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
                        u_xlat16_4.xyz = u_xlat2.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = max(u_xlat36, 0.00100000005);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat36 = dot(u_xlat5.xyz, u_xlat1.xyz);
                        u_xlat1.x = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
                        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
                        u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
                        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
                        u_xlat16_40 = u_xlat0.x + u_xlat0.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat0.x + -0.5;
                        u_xlat16_42 = (-u_xlat1.x) + 1.0;
                        u_xlat16_46 = u_xlat16_42 * u_xlat16_42;
                        u_xlat16_46 = u_xlat16_46 * u_xlat16_46;
                        u_xlat16_42 = u_xlat16_42 * u_xlat16_46;
                        u_xlat16_42 = u_xlat16_40 * u_xlat16_42 + 1.0;
                        u_xlat16_46 = -abs(u_xlat36) + 1.0;
                        u_xlat16_11.x = u_xlat16_46 * u_xlat16_46;
                        u_xlat16_11.x = u_xlat16_11.x * u_xlat16_11.x;
                        u_xlat16_46 = u_xlat16_46 * u_xlat16_11.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_46 + 1.0;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_42;
                        u_xlat12.x = u_xlat1.x * u_xlat16_40;
                        u_xlat24 = abs(u_xlat36) + u_xlat1.x;
                        u_xlat24 = u_xlat24 + 9.99999975e-06;
                        u_xlat24 = 0.5 / u_xlat24;
                        u_xlat24 = u_xlat1.x * u_xlat24;
                        u_xlat24 = u_xlat24 * 0.999999881;
                        u_xlat16_11.xyz = u_xlat12.xxx * u_xlat16_6.xyz;
                        u_xlat12.xyz = u_xlat16_6.xyz * vec3(u_xlat24);
                        u_xlat16_40 = (-u_xlat0.x) + 1.0;
                        u_xlat16_6.x = u_xlat16_40 * u_xlat16_40;
                        u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
                        u_xlat16_40 = u_xlat16_40 * u_xlat16_6.x;
                        u_xlat16_40 = u_xlat16_40 * 0.959999979 + 0.0399999991;
                        u_xlat0.xyz = u_xlat12.xyz * vec3(u_xlat16_40);
                        u_xlat0.xyz = u_xlat16_4.xyz * u_xlat16_11.xyz + u_xlat0.xyz;
                        u_xlat16_4.xyz = u_xlat16_10.xyz * vec3(0.5, 0.5, 0.5);
                        u_xlat16_40 = u_xlat16_46 * 2.23517418e-08 + 0.0399999991;
                        u_xlat0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_40) + u_xlat0.xyz;
                        SV_Target0.xyz = u_xlat0.xyz;
                        SV_Target0.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
                SubProgram "gles3 " {
                    Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec4 _ProjectionParams;
                    uniform 	vec4 unity_4LightPosX0;
                    uniform 	vec4 unity_4LightPosY0;
                    uniform 	vec4 unity_4LightPosZ0;
                    uniform 	mediump vec4 unity_4LightAtten0;
                    uniform 	mediump vec4 unity_LightColor[8];
                    uniform 	mediump vec4 unity_SHBr;
                    uniform 	mediump vec4 unity_SHBg;
                    uniform 	mediump vec4 unity_SHBb;
                    uniform 	mediump vec4 unity_SHC;
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out mediump vec3 vs_TEXCOORD3;
                    out highp vec4 vs_TEXCOORD5;
                    out highp vec4 vs_TEXCOORD6;
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    vec4 u_xlat2;
                    mediump vec4 u_xlat16_2;
                    vec4 u_xlat3;
                    vec4 u_xlat4;
                    vec4 u_xlat5;
                    mediump vec3 u_xlat16_6;
                    mediump vec3 u_xlat16_7;
                    float u_xlat24;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
                        u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
                        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
                        gl_Position = u_xlat1;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
                        u_xlat24 = inversesqrt(u_xlat24);
                        u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
                        vs_TEXCOORD1.xyz = u_xlat2.xyz;
                        vs_TEXCOORD2.xyz = u_xlat0.xyz;
                        u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
                        u_xlat4 = (-u_xlat0.yyyy) + unity_4LightPosY0;
                        u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
                        u_xlat5 = u_xlat2.yyyy * u_xlat4;
                        u_xlat4 = u_xlat4 * u_xlat4;
                        u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
                        u_xlat3 = u_xlat3 * u_xlat2.xxxx + u_xlat5;
                        u_xlat3 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
                        u_xlat0 = u_xlat0 * u_xlat0 + u_xlat4;
                        u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
                        u_xlat4 = inversesqrt(u_xlat0);
                        u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
                        u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
                        u_xlat3 = u_xlat3 * u_xlat4;
                        u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
                        u_xlat0 = u_xlat0 * u_xlat3;
                        u_xlat3.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
                        u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
                        u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
                        u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
                        u_xlat16_6.x = u_xlat2.y * u_xlat2.y;
                        u_xlat16_6.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_6.x);
                        u_xlat16_2 = u_xlat2.yzzx * u_xlat2.xyzz;
                        u_xlat16_7.x = dot(unity_SHBr, u_xlat16_2);
                        u_xlat16_7.y = dot(unity_SHBg, u_xlat16_2);
                        u_xlat16_7.z = dot(unity_SHBb, u_xlat16_2);
                        u_xlat16_6.xyz = unity_SHC.xyz * u_xlat16_6.xxx + u_xlat16_7.xyz;
                        vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat16_6.xyz;
                        u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
                        u_xlat0.w = u_xlat0.x * 0.5;
                        u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
                        vs_TEXCOORD5.zw = u_xlat1.zw;
                        vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
                        vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_texture_lod
                    #extension GL_EXT_shader_texture_lod : enable
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec3 _WorldSpaceCameraPos;
                    uniform 	mediump vec4 _WorldSpaceLightPos0;
                    uniform 	mediump vec4 unity_SHAr;
                    uniform 	mediump vec4 unity_SHAg;
                    uniform 	mediump vec4 unity_SHAb;
                    uniform 	mediump vec4 unity_OcclusionMaskSelector;
                    uniform 	vec4 _LightShadowData;
                    uniform 	vec4 unity_ShadowFadeCenterAndType;
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
                    uniform 	vec4 unity_SpecCube0_BoxMax;
                    uniform 	vec4 unity_SpecCube0_BoxMin;
                    uniform 	vec4 unity_SpecCube0_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube0_HDR;
                    uniform 	vec4 unity_SpecCube1_BoxMax;
                    uniform 	vec4 unity_SpecCube1_BoxMin;
                    uniform 	vec4 unity_SpecCube1_ProbePosition;
                    uniform 	mediump vec4 unity_SpecCube1_HDR;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    uniform 	mediump vec4 _LightColor0;
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform mediump sampler2D _ShadowMapTexture;
                    UNITY_LOCATION(2) uniform mediump samplerCube unity_SpecCube0;
                    UNITY_LOCATION(3) uniform mediump samplerCube unity_SpecCube1;
                    UNITY_LOCATION(4) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    in mediump vec3 vs_TEXCOORD3;
                    in highp vec4 vs_TEXCOORD5;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    vec3 u_xlat0;
                    vec3 u_xlat1;
                    vec3 u_xlat2;
                    vec4 u_xlat3;
                    mediump vec4 u_xlat16_3;
                    bool u_xlatb3;
                    vec4 u_xlat4;
                    mediump vec3 u_xlat16_5;
                    mediump vec3 u_xlat16_6;
                    vec4 u_xlat7;
                    vec4 u_xlat8;
                    mediump vec3 u_xlat16_9;
                    bvec3 u_xlatb10;
                    vec3 u_xlat11;
                    mediump vec3 u_xlat16_11;
                    vec3 u_xlat12;
                    vec3 u_xlat15;
                    float u_xlat16;
                    mediump vec3 u_xlat16_17;
                    float u_xlat24;
                    float u_xlat36;
                    float u_xlat37;
                    bool u_xlatb37;
                    float u_xlat38;
                    bool u_xlatb38;
                    mediump float u_xlat16_41;
                    mediump float u_xlat16_42;
                    mediump float u_xlat16_45;
                    mediump float u_xlat16_47;
                    void main()
                    {
                        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
                        u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
                        u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
                        u_xlat37 = dot(u_xlat0.xyz, u_xlat3.xyz);
                        u_xlat3.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
                        u_xlat38 = dot(u_xlat3.xyz, u_xlat3.xyz);
                        u_xlat38 = sqrt(u_xlat38);
                        u_xlat38 = (-u_xlat37) + u_xlat38;
                        u_xlat37 = unity_ShadowFadeCenterAndType.w * u_xlat38 + u_xlat37;
                        u_xlat37 = u_xlat37 * _LightShadowData.z + _LightShadowData.w;
                        u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
                        u_xlatb38 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb38){
                            u_xlatb3 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat15.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat15.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat15.xyz;
                            u_xlat15.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat15.xyz;
                            u_xlat15.xyz = u_xlat15.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat3.xyz = (bool(u_xlatb3)) ? u_xlat15.xyz : vs_TEXCOORD2.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat15.x = u_xlat3.y * 0.25 + 0.75;
                            u_xlat4.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                            u_xlat3.x = max(u_xlat15.x, u_xlat4.x);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
                            u_xlat16_3 = u_xlat3;
                        } else {
                            u_xlat16_3.x = float(1.0);
                            u_xlat16_3.y = float(1.0);
                            u_xlat16_3.z = float(1.0);
                            u_xlat16_3.w = float(1.0);
                        }
                        u_xlat16_5.x = dot(u_xlat16_3, unity_OcclusionMaskSelector);
                        u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
                        u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
                        u_xlat4.x = texture(_ShadowMapTexture, u_xlat4.xy).x;
                        u_xlat16_5.x = (-u_xlat4.x) + u_xlat16_5.x;
                        u_xlat16_5.x = u_xlat37 * u_xlat16_5.x + u_xlat4.x;
                        u_xlat16_17.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
                        u_xlat16_17.x = u_xlat16_17.x + u_xlat16_17.x;
                        u_xlat16_17.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_17.xxx) + (-u_xlat1.xyz);
                        u_xlat16_6.xyz = u_xlat16_5.xxx * _LightColor0.xyz;
                        if(u_xlatb38){
                            u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat4.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat4.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
                            u_xlat4.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
                            u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat4.xyz = (bool(u_xlatb37)) ? u_xlat4.xyz : vs_TEXCOORD2.xyz;
                            u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat3.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat37 = u_xlat3.y * 0.25;
                            u_xlat4.x = unity_ProbeVolumeParams.z * 0.5;
                            u_xlat16 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
                            u_xlat37 = max(u_xlat37, u_xlat4.x);
                            u_xlat3.x = min(u_xlat16, u_xlat37);
                            u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
                            u_xlat7.xyz = u_xlat3.xzw + vec3(0.25, 0.0, 0.0);
                            u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
                            u_xlat8.xyz = u_xlat3.xzw + vec3(0.5, 0.0, 0.0);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
                            u_xlat8.xyz = vs_TEXCOORD1.xyz;
                            u_xlat8.w = 1.0;
                            u_xlat16_9.x = dot(u_xlat4, u_xlat8);
                            u_xlat16_9.y = dot(u_xlat7, u_xlat8);
                            u_xlat16_9.z = dot(u_xlat3, u_xlat8);
                        } else {
                            u_xlat3.xyz = vs_TEXCOORD1.xyz;
                            u_xlat3.w = 1.0;
                            u_xlat16_9.x = dot(unity_SHAr, u_xlat3);
                            u_xlat16_9.y = dot(unity_SHAg, u_xlat3);
                            u_xlat16_9.z = dot(unity_SHAb, u_xlat3);
                        }
                        u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
                        u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
                        u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
                        if(u_xlatb37){
                            u_xlat37 = dot(u_xlat16_17.xyz, u_xlat16_17.xyz);
                            u_xlat37 = inversesqrt(u_xlat37);
                            u_xlat4.xyz = vec3(u_xlat37) * u_xlat16_17.xyz;
                            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
                            u_xlat7.xyz = u_xlat7.xyz / u_xlat4.xyz;
                            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
                            u_xlat8.xyz = u_xlat8.xyz / u_xlat4.xyz;
                            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
                            {
                                vec4 hlslcc_movcTemp = u_xlat7;
                                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat7.x : u_xlat8.x;
                                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat7.y : u_xlat8.y;
                                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat7.z : u_xlat8.z;
                                u_xlat7 = hlslcc_movcTemp;
                            }
                            u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                            u_xlat37 = min(u_xlat7.z, u_xlat37);
                            u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
                            u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                        } else {
                            u_xlat4.xyz = u_xlat16_17.xyz;
                        }
                        u_xlat3 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
                        u_xlat16_5.x = u_xlat3.w + -1.0;
                        u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
                        u_xlat16_5.x = log2(u_xlat16_5.x);
                        u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.y;
                        u_xlat16_5.x = exp2(u_xlat16_5.x);
                        u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
                        u_xlat16_11.xyz = u_xlat3.xyz * u_xlat16_5.xxx;
                        u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
                        if(u_xlatb37){
                            u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
                            if(u_xlatb37){
                                u_xlat37 = dot(u_xlat16_17.xyz, u_xlat16_17.xyz);
                                u_xlat37 = inversesqrt(u_xlat37);
                                u_xlat4.xyz = vec3(u_xlat37) * u_xlat16_17.xyz;
                                u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
                                u_xlat7.xyz = u_xlat7.xyz / u_xlat4.xyz;
                                u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
                                u_xlat8.xyz = u_xlat8.xyz / u_xlat4.xyz;
                                u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
                                {
                                    vec4 hlslcc_movcTemp = u_xlat7;
                                    hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat7.x : u_xlat8.x;
                                    hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat7.y : u_xlat8.y;
                                    hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat7.z : u_xlat8.z;
                                    u_xlat7 = hlslcc_movcTemp;
                                }
                                u_xlat37 = min(u_xlat7.y, u_xlat7.x);
                                u_xlat37 = min(u_xlat7.z, u_xlat37);
                                u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
                                u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat37) + u_xlat7.xyz;
                            } else {
                                u_xlat4.xyz = u_xlat16_17.xyz;
                            }
                            u_xlat4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 6.0);
                            u_xlat16_17.x = u_xlat4.w + -1.0;
                            u_xlat16_17.x = unity_SpecCube1_HDR.w * u_xlat16_17.x + 1.0;
                            u_xlat16_17.x = log2(u_xlat16_17.x);
                            u_xlat16_17.x = u_xlat16_17.x * unity_SpecCube1_HDR.y;
                            u_xlat16_17.x = exp2(u_xlat16_17.x);
                            u_xlat16_17.x = u_xlat16_17.x * unity_SpecCube1_HDR.x;
                            u_xlat16_17.xyz = u_xlat4.xyz * u_xlat16_17.xxx;
                            u_xlat4.xyz = u_xlat16_5.xxx * u_xlat3.xyz + (-u_xlat16_17.xyz);
                            u_xlat11.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat16_17.xyz;
                            u_xlat16_11.xyz = u_xlat11.xyz;
                        }
                        u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
                        u_xlat37 = inversesqrt(u_xlat37);
                        u_xlat4.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
                        u_xlat16_5.xyz = u_xlat2.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
                        u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat36 = max(u_xlat36, 0.00100000005);
                        u_xlat36 = inversesqrt(u_xlat36);
                        u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
                        u_xlat36 = dot(u_xlat4.xyz, u_xlat1.xyz);
                        u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
                        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
                        u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
                        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
                        u_xlat16_41 = u_xlat0.x + u_xlat0.x;
                        u_xlat16_41 = u_xlat16_41 * u_xlat0.x + -0.5;
                        u_xlat16_42 = (-u_xlat1.x) + 1.0;
                        u_xlat16_45 = u_xlat16_42 * u_xlat16_42;
                        u_xlat16_45 = u_xlat16_45 * u_xlat16_45;
                        u_xlat16_42 = u_xlat16_42 * u_xlat16_45;
                        u_xlat16_42 = u_xlat16_41 * u_xlat16_42 + 1.0;
                        u_xlat16_45 = -abs(u_xlat36) + 1.0;
                        u_xlat16_47 = u_xlat16_45 * u_xlat16_45;
                        u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
                        u_xlat16_45 = u_xlat16_45 * u_xlat16_47;
                        u_xlat16_41 = u_xlat16_41 * u_xlat16_45 + 1.0;
                        u_xlat16_41 = u_xlat16_41 * u_xlat16_42;
                        u_xlat12.x = u_xlat1.x * u_xlat16_41;
                        u_xlat24 = abs(u_xlat36) + u_xlat1.x;
                        u_xlat24 = u_xlat24 + 9.99999975e-06;
                        u_xlat24 = 0.5 / u_xlat24;
                        u_xlat24 = u_xlat1.x * u_xlat24;
                        u_xlat24 = u_xlat24 * 0.999999881;
                        u_xlat16_9.xyz = u_xlat16_6.xyz * u_xlat12.xxx + u_xlat16_9.xyz;
                        u_xlat12.xyz = u_xlat16_6.xyz * vec3(u_xlat24);
                        u_xlat16_41 = (-u_xlat0.x) + 1.0;
                        u_xlat16_6.x = u_xlat16_41 * u_xlat16_41;
                        u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
                        u_xlat16_41 = u_xlat16_41 * u_xlat16_6.x;
                        u_xlat16_41 = u_xlat16_41 * 0.959999979 + 0.0399999991;
                        u_xlat0.xyz = u_xlat12.xyz * vec3(u_xlat16_41);
                        u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz + u_xlat0.xyz;
                        u_xlat16_5.xyz = u_xlat16_11.xyz * vec3(0.5, 0.5, 0.5);
                        u_xlat16_41 = u_xlat16_45 * 2.23517418e-08 + 0.0399999991;
                        u_xlat0.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41) + u_xlat0.xyz;
                        SV_Target0.xyz = u_xlat0.xyz;
                        SV_Target0.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
            }
        }
        Pass {
            Name "FORWARD"
            LOD 200
            Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
            Blend One One, One One
            ZWrite Off
            GpuProgramID 96379
            PlayerProgram "vp" {
                SubProgram "gles3 " {
                    Keywords { "POINT" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out highp vec3 vs_TEXCOORD3;
                    out highp vec4 vs_TEXCOORD4;
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    vec4 u_xlat2;
                    float u_xlat10;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
                        u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
                        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
                        u_xlat10 = inversesqrt(u_xlat10);
                        vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
                        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
                        u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
                        u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
                        vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
                        vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec3 _WorldSpaceCameraPos;
                    uniform 	vec4 _WorldSpaceLightPos0;
                    uniform 	mediump vec4 unity_OcclusionMaskSelector;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    uniform 	mediump vec4 _LightColor0;
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform highp sampler2D _LightTexture0;
                    UNITY_LOCATION(2) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    vec3 u_xlat0;
                    vec3 u_xlat1;
                    vec3 u_xlat2;
                    vec3 u_xlat3;
                    vec3 u_xlat4;
                    vec4 u_xlat5;
                    mediump vec4 u_xlat16_5;
                    mediump vec3 u_xlat16_6;
                    mediump vec3 u_xlat16_7;
                    mediump vec3 u_xlat16_8;
                    vec3 u_xlat9;
                    mediump float u_xlat16_15;
                    mediump float u_xlat16_17;
                    float u_xlat18;
                    float u_xlat27;
                    float u_xlat28;
                    bool u_xlatb28;
                    float u_xlat29;
                    mediump float u_xlat16_33;
                    mediump float u_xlat16_34;
                    void main()
                    {
                        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
                        u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat27 = inversesqrt(u_xlat27);
                        u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
                        u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
                        u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
                        u_xlat28 = inversesqrt(u_xlat28);
                        u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
                        u_xlat3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlat4.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
                        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
                        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
                        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
                        u_xlatb28 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb28){
                            u_xlatb28 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat5.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat5.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
                            u_xlat5.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
                            u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat5.xyz = (bool(u_xlatb28)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
                            u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat28 = u_xlat5.y * 0.25 + 0.75;
                            u_xlat29 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                            u_xlat5.x = max(u_xlat28, u_xlat29);
                            u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
                            u_xlat16_5 = u_xlat5;
                        } else {
                            u_xlat16_5.x = float(1.0);
                            u_xlat16_5.y = float(1.0);
                            u_xlat16_5.z = float(1.0);
                            u_xlat16_5.w = float(1.0);
                        }
                        u_xlat16_6.x = dot(u_xlat16_5, unity_OcclusionMaskSelector);
                        u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
                        u_xlat28 = dot(u_xlat4.xyz, u_xlat4.xyz);
                        u_xlat28 = texture(_LightTexture0, vec2(u_xlat28)).x;
                        u_xlat28 = u_xlat16_6.x * u_xlat28;
                        u_xlat16_6.xyz = vec3(u_xlat28) * _LightColor0.xyz;
                        u_xlat28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
                        u_xlat28 = inversesqrt(u_xlat28);
                        u_xlat4.xyz = vec3(u_xlat28) * vs_TEXCOORD1.xyz;
                        u_xlat16_7.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat2.xyz;
                        u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat27 = max(u_xlat27, 0.00100000005);
                        u_xlat27 = inversesqrt(u_xlat27);
                        u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
                        u_xlat27 = dot(u_xlat4.xyz, u_xlat2.xyz);
                        u_xlat28 = dot(u_xlat4.xyz, u_xlat1.xyz);
                        u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
                        u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
                        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
                        u_xlat16_33 = u_xlat0.x + u_xlat0.x;
                        u_xlat16_33 = u_xlat16_33 * u_xlat0.x + -0.5;
                        u_xlat16_34 = (-u_xlat28) + 1.0;
                        u_xlat16_8.x = u_xlat16_34 * u_xlat16_34;
                        u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
                        u_xlat16_34 = u_xlat16_34 * u_xlat16_8.x;
                        u_xlat16_34 = u_xlat16_33 * u_xlat16_34 + 1.0;
                        u_xlat16_8.x = -abs(u_xlat27) + 1.0;
                        u_xlat16_17 = u_xlat16_8.x * u_xlat16_8.x;
                        u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
                        u_xlat16_8.x = u_xlat16_8.x * u_xlat16_17;
                        u_xlat16_33 = u_xlat16_33 * u_xlat16_8.x + 1.0;
                        u_xlat16_33 = u_xlat16_33 * u_xlat16_34;
                        u_xlat9.x = u_xlat28 * u_xlat16_33;
                        u_xlat18 = abs(u_xlat27) + u_xlat28;
                        u_xlat18 = u_xlat18 + 9.99999975e-06;
                        u_xlat18 = 0.5 / u_xlat18;
                        u_xlat18 = u_xlat28 * u_xlat18;
                        u_xlat18 = u_xlat18 * 0.999999881;
                        u_xlat16_8.xyz = u_xlat9.xxx * u_xlat16_6.xyz;
                        u_xlat9.xyz = u_xlat16_6.xyz * vec3(u_xlat18);
                        u_xlat16_6.x = (-u_xlat0.x) + 1.0;
                        u_xlat16_15 = u_xlat16_6.x * u_xlat16_6.x;
                        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
                        u_xlat16_6.x = u_xlat16_6.x * u_xlat16_15;
                        u_xlat16_6.x = u_xlat16_6.x * 0.959999979 + 0.0399999991;
                        u_xlat0.xyz = u_xlat9.xyz * u_xlat16_6.xxx;
                        u_xlat0.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz + u_xlat0.xyz;
                        SV_Target0.xyz = u_xlat0.xyz;
                        SV_Target0.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
                SubProgram "gles3 " {
                    Keywords { "DIRECTIONAL" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out highp vec4 vs_TEXCOORD4;
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    float u_xlat6;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
                        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat6 = inversesqrt(u_xlat6);
                        vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
                        vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec3 _WorldSpaceCameraPos;
                    uniform 	mediump vec4 _WorldSpaceLightPos0;
                    uniform 	mediump vec4 unity_OcclusionMaskSelector;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    uniform 	mediump vec4 _LightColor0;
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    vec3 u_xlat0;
                    vec3 u_xlat1;
                    vec3 u_xlat2;
                    vec4 u_xlat3;
                    mediump vec4 u_xlat16_3;
                    mediump vec3 u_xlat16_4;
                    vec3 u_xlat5;
                    mediump vec3 u_xlat16_6;
                    mediump vec3 u_xlat16_7;
                    vec3 u_xlat8;
                    mediump float u_xlat16_12;
                    mediump float u_xlat16_15;
                    float u_xlat16;
                    float u_xlat24;
                    float u_xlat25;
                    bool u_xlatb25;
                    float u_xlat26;
                    mediump float u_xlat16_28;
                    mediump float u_xlat16_30;
                    void main()
                    {
                        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
                        u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat24 = inversesqrt(u_xlat24);
                        u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
                        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb25){
                            u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat3.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
                            u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat3.xyz = (bool(u_xlatb25)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
                            u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat25 = u_xlat3.y * 0.25 + 0.75;
                            u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                            u_xlat3.x = max(u_xlat25, u_xlat26);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
                            u_xlat16_3 = u_xlat3;
                        } else {
                            u_xlat16_3.x = float(1.0);
                            u_xlat16_3.y = float(1.0);
                            u_xlat16_3.z = float(1.0);
                            u_xlat16_3.w = float(1.0);
                        }
                        u_xlat16_4.x = dot(u_xlat16_3, unity_OcclusionMaskSelector);
                        u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
                        u_xlat16_4.xyz = u_xlat16_4.xxx * _LightColor0.xyz;
                        u_xlat25 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
                        u_xlat25 = inversesqrt(u_xlat25);
                        u_xlat5.xyz = vec3(u_xlat25) * vs_TEXCOORD1.xyz;
                        u_xlat16_6.xyz = u_xlat2.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
                        u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat24 = max(u_xlat24, 0.00100000005);
                        u_xlat24 = inversesqrt(u_xlat24);
                        u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
                        u_xlat24 = dot(u_xlat5.xyz, u_xlat1.xyz);
                        u_xlat1.x = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
                        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
                        u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
                        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
                        u_xlat16_28 = u_xlat0.x + u_xlat0.x;
                        u_xlat16_28 = u_xlat16_28 * u_xlat0.x + -0.5;
                        u_xlat16_30 = (-u_xlat1.x) + 1.0;
                        u_xlat16_7.x = u_xlat16_30 * u_xlat16_30;
                        u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
                        u_xlat16_30 = u_xlat16_30 * u_xlat16_7.x;
                        u_xlat16_30 = u_xlat16_28 * u_xlat16_30 + 1.0;
                        u_xlat16_7.x = -abs(u_xlat24) + 1.0;
                        u_xlat16_15 = u_xlat16_7.x * u_xlat16_7.x;
                        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
                        u_xlat16_7.x = u_xlat16_7.x * u_xlat16_15;
                        u_xlat16_28 = u_xlat16_28 * u_xlat16_7.x + 1.0;
                        u_xlat16_28 = u_xlat16_28 * u_xlat16_30;
                        u_xlat8.x = u_xlat1.x * u_xlat16_28;
                        u_xlat16 = abs(u_xlat24) + u_xlat1.x;
                        u_xlat16 = u_xlat16 + 9.99999975e-06;
                        u_xlat16 = 0.5 / u_xlat16;
                        u_xlat16 = u_xlat1.x * u_xlat16;
                        u_xlat16 = u_xlat16 * 0.999999881;
                        u_xlat16_7.xyz = u_xlat8.xxx * u_xlat16_4.xyz;
                        u_xlat8.xyz = u_xlat16_4.xyz * vec3(u_xlat16);
                        u_xlat16_4.x = (-u_xlat0.x) + 1.0;
                        u_xlat16_12 = u_xlat16_4.x * u_xlat16_4.x;
                        u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
                        u_xlat16_4.x = u_xlat16_4.x * u_xlat16_12;
                        u_xlat16_4.x = u_xlat16_4.x * 0.959999979 + 0.0399999991;
                        u_xlat0.xyz = u_xlat8.xyz * u_xlat16_4.xxx;
                        u_xlat0.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
                        SV_Target0.xyz = u_xlat0.xyz;
                        SV_Target0.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
                SubProgram "gles3 " {
                    Keywords { "SPOT" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out highp vec4 vs_TEXCOORD3;
                    out highp vec4 vs_TEXCOORD4;
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    vec4 u_xlat2;
                    float u_xlat10;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
                        u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
                        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
                        u_xlat10 = inversesqrt(u_xlat10);
                        vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
                        u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
                        u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
                        u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
                        vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
                        vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec3 _WorldSpaceCameraPos;
                    uniform 	vec4 _WorldSpaceLightPos0;
                    uniform 	mediump vec4 unity_OcclusionMaskSelector;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    uniform 	mediump vec4 _LightColor0;
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform highp sampler2D _LightTexture0;
                    UNITY_LOCATION(2) uniform highp sampler2D _LightTextureB0;
                    UNITY_LOCATION(3) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    vec3 u_xlat0;
                    vec3 u_xlat1;
                    vec3 u_xlat2;
                    vec3 u_xlat3;
                    vec4 u_xlat4;
                    vec4 u_xlat5;
                    mediump vec4 u_xlat16_5;
                    mediump vec3 u_xlat16_6;
                    vec2 u_xlat7;
                    mediump vec3 u_xlat16_8;
                    mediump vec3 u_xlat16_9;
                    vec3 u_xlat10;
                    mediump float u_xlat16_16;
                    mediump float u_xlat16_19;
                    float u_xlat20;
                    float u_xlat30;
                    float u_xlat31;
                    bool u_xlatb31;
                    float u_xlat32;
                    mediump float u_xlat16_36;
                    mediump float u_xlat16_38;
                    void main()
                    {
                        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
                        u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat30 = inversesqrt(u_xlat30);
                        u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
                        u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
                        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
                        u_xlat31 = inversesqrt(u_xlat31);
                        u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
                        u_xlat3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlat4 = vs_TEXCOORD2.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
                        u_xlat4 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat4;
                        u_xlat4 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat4;
                        u_xlat4 = u_xlat4 + hlslcc_mtx4x4unity_WorldToLight[3];
                        u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb31){
                            u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat5.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat5.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
                            u_xlat5.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
                            u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat5.xyz = (bool(u_xlatb31)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
                            u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat31 = u_xlat5.y * 0.25 + 0.75;
                            u_xlat32 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                            u_xlat5.x = max(u_xlat31, u_xlat32);
                            u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
                            u_xlat16_5 = u_xlat5;
                        } else {
                            u_xlat16_5.x = float(1.0);
                            u_xlat16_5.y = float(1.0);
                            u_xlat16_5.z = float(1.0);
                            u_xlat16_5.w = float(1.0);
                        }
                        u_xlat16_6.x = dot(u_xlat16_5, unity_OcclusionMaskSelector);
                        u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
                        u_xlatb31 = 0.0<u_xlat4.z;
                        u_xlat16_16 = (u_xlatb31) ? 1.0 : 0.0;
                        u_xlat7.xy = u_xlat4.xy / u_xlat4.ww;
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat31 = texture(_LightTexture0, u_xlat7.xy).w;
                        u_xlat16_16 = u_xlat31 * u_xlat16_16;
                        u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
                        u_xlat31 = texture(_LightTextureB0, vec2(u_xlat31)).x;
                        u_xlat16_16 = u_xlat31 * u_xlat16_16;
                        u_xlat16_6.x = u_xlat16_6.x * u_xlat16_16;
                        u_xlat16_6.xyz = u_xlat16_6.xxx * _LightColor0.xyz;
                        u_xlat31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
                        u_xlat31 = inversesqrt(u_xlat31);
                        u_xlat4.xyz = vec3(u_xlat31) * vs_TEXCOORD1.xyz;
                        u_xlat16_8.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat2.xyz;
                        u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat30 = max(u_xlat30, 0.00100000005);
                        u_xlat30 = inversesqrt(u_xlat30);
                        u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
                        u_xlat30 = dot(u_xlat4.xyz, u_xlat2.xyz);
                        u_xlat31 = dot(u_xlat4.xyz, u_xlat1.xyz);
                        u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
                        u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
                        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
                        u_xlat16_36 = u_xlat0.x + u_xlat0.x;
                        u_xlat16_36 = u_xlat16_36 * u_xlat0.x + -0.5;
                        u_xlat16_38 = (-u_xlat31) + 1.0;
                        u_xlat16_9.x = u_xlat16_38 * u_xlat16_38;
                        u_xlat16_9.x = u_xlat16_9.x * u_xlat16_9.x;
                        u_xlat16_38 = u_xlat16_38 * u_xlat16_9.x;
                        u_xlat16_38 = u_xlat16_36 * u_xlat16_38 + 1.0;
                        u_xlat16_9.x = -abs(u_xlat30) + 1.0;
                        u_xlat16_19 = u_xlat16_9.x * u_xlat16_9.x;
                        u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
                        u_xlat16_9.x = u_xlat16_9.x * u_xlat16_19;
                        u_xlat16_36 = u_xlat16_36 * u_xlat16_9.x + 1.0;
                        u_xlat16_36 = u_xlat16_36 * u_xlat16_38;
                        u_xlat10.x = u_xlat31 * u_xlat16_36;
                        u_xlat20 = abs(u_xlat30) + u_xlat31;
                        u_xlat20 = u_xlat20 + 9.99999975e-06;
                        u_xlat20 = 0.5 / u_xlat20;
                        u_xlat20 = u_xlat31 * u_xlat20;
                        u_xlat20 = u_xlat20 * 0.999999881;
                        u_xlat16_9.xyz = u_xlat10.xxx * u_xlat16_6.xyz;
                        u_xlat10.xyz = u_xlat16_6.xyz * vec3(u_xlat20);
                        u_xlat16_6.x = (-u_xlat0.x) + 1.0;
                        u_xlat16_16 = u_xlat16_6.x * u_xlat16_6.x;
                        u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
                        u_xlat16_6.x = u_xlat16_6.x * u_xlat16_16;
                        u_xlat16_6.x = u_xlat16_6.x * 0.959999979 + 0.0399999991;
                        u_xlat0.xyz = u_xlat10.xyz * u_xlat16_6.xxx;
                        u_xlat0.xyz = u_xlat16_8.xyz * u_xlat16_9.xyz + u_xlat0.xyz;
                        SV_Target0.xyz = u_xlat0.xyz;
                        SV_Target0.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
                SubProgram "gles3 " {
                    Keywords { "POINT_COOKIE" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out highp vec3 vs_TEXCOORD3;
                    out highp vec4 vs_TEXCOORD4;
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    vec4 u_xlat2;
                    float u_xlat10;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
                        u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
                        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
                        u_xlat10 = inversesqrt(u_xlat10);
                        vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
                        u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
                        u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
                        u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
                        vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
                        vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec3 _WorldSpaceCameraPos;
                    uniform 	vec4 _WorldSpaceLightPos0;
                    uniform 	mediump vec4 unity_OcclusionMaskSelector;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    uniform 	mediump vec4 _LightColor0;
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform highp sampler2D _LightTextureB0;
                    UNITY_LOCATION(2) uniform highp samplerCube _LightTexture0;
                    UNITY_LOCATION(3) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    vec3 u_xlat0;
                    vec3 u_xlat1;
                    vec3 u_xlat2;
                    vec3 u_xlat3;
                    vec3 u_xlat4;
                    vec4 u_xlat5;
                    mediump vec4 u_xlat16_5;
                    mediump vec3 u_xlat16_6;
                    mediump vec3 u_xlat16_7;
                    mediump vec3 u_xlat16_8;
                    vec3 u_xlat9;
                    mediump float u_xlat16_15;
                    mediump float u_xlat16_17;
                    float u_xlat18;
                    float u_xlat27;
                    float u_xlat28;
                    bool u_xlatb28;
                    float u_xlat29;
                    mediump float u_xlat16_33;
                    mediump float u_xlat16_34;
                    void main()
                    {
                        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
                        u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat27 = inversesqrt(u_xlat27);
                        u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
                        u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
                        u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
                        u_xlat28 = inversesqrt(u_xlat28);
                        u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
                        u_xlat3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlat4.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
                        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
                        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
                        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
                        u_xlatb28 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb28){
                            u_xlatb28 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat5.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat5.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
                            u_xlat5.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
                            u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat5.xyz = (bool(u_xlatb28)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
                            u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat28 = u_xlat5.y * 0.25 + 0.75;
                            u_xlat29 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                            u_xlat5.x = max(u_xlat28, u_xlat29);
                            u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
                            u_xlat16_5 = u_xlat5;
                        } else {
                            u_xlat16_5.x = float(1.0);
                            u_xlat16_5.y = float(1.0);
                            u_xlat16_5.z = float(1.0);
                            u_xlat16_5.w = float(1.0);
                        }
                        u_xlat16_6.x = dot(u_xlat16_5, unity_OcclusionMaskSelector);
                        u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
                        u_xlat28 = dot(u_xlat4.xyz, u_xlat4.xyz);
                        u_xlat28 = texture(_LightTextureB0, vec2(u_xlat28)).x;
                        u_xlat29 = texture(_LightTexture0, u_xlat4.xyz).w;
                        u_xlat28 = u_xlat28 * u_xlat29;
                        u_xlat28 = u_xlat16_6.x * u_xlat28;
                        u_xlat16_6.xyz = vec3(u_xlat28) * _LightColor0.xyz;
                        u_xlat28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
                        u_xlat28 = inversesqrt(u_xlat28);
                        u_xlat4.xyz = vec3(u_xlat28) * vs_TEXCOORD1.xyz;
                        u_xlat16_7.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat2.xyz;
                        u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat27 = max(u_xlat27, 0.00100000005);
                        u_xlat27 = inversesqrt(u_xlat27);
                        u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
                        u_xlat27 = dot(u_xlat4.xyz, u_xlat2.xyz);
                        u_xlat28 = dot(u_xlat4.xyz, u_xlat1.xyz);
                        u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
                        u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
                        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
                        u_xlat16_33 = u_xlat0.x + u_xlat0.x;
                        u_xlat16_33 = u_xlat16_33 * u_xlat0.x + -0.5;
                        u_xlat16_34 = (-u_xlat28) + 1.0;
                        u_xlat16_8.x = u_xlat16_34 * u_xlat16_34;
                        u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
                        u_xlat16_34 = u_xlat16_34 * u_xlat16_8.x;
                        u_xlat16_34 = u_xlat16_33 * u_xlat16_34 + 1.0;
                        u_xlat16_8.x = -abs(u_xlat27) + 1.0;
                        u_xlat16_17 = u_xlat16_8.x * u_xlat16_8.x;
                        u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
                        u_xlat16_8.x = u_xlat16_8.x * u_xlat16_17;
                        u_xlat16_33 = u_xlat16_33 * u_xlat16_8.x + 1.0;
                        u_xlat16_33 = u_xlat16_33 * u_xlat16_34;
                        u_xlat9.x = u_xlat28 * u_xlat16_33;
                        u_xlat18 = abs(u_xlat27) + u_xlat28;
                        u_xlat18 = u_xlat18 + 9.99999975e-06;
                        u_xlat18 = 0.5 / u_xlat18;
                        u_xlat18 = u_xlat28 * u_xlat18;
                        u_xlat18 = u_xlat18 * 0.999999881;
                        u_xlat16_8.xyz = u_xlat9.xxx * u_xlat16_6.xyz;
                        u_xlat9.xyz = u_xlat16_6.xyz * vec3(u_xlat18);
                        u_xlat16_6.x = (-u_xlat0.x) + 1.0;
                        u_xlat16_15 = u_xlat16_6.x * u_xlat16_6.x;
                        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
                        u_xlat16_6.x = u_xlat16_6.x * u_xlat16_15;
                        u_xlat16_6.x = u_xlat16_6.x * 0.959999979 + 0.0399999991;
                        u_xlat0.xyz = u_xlat9.xyz * u_xlat16_6.xxx;
                        u_xlat0.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz + u_xlat0.xyz;
                        SV_Target0.xyz = u_xlat0.xyz;
                        SV_Target0.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
                SubProgram "gles3 " {
                    Keywords { "DIRECTIONAL_COOKIE" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD3;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out highp vec4 vs_TEXCOORD4;
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    vec4 u_xlat2;
                    float u_xlat9;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
                        u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
                        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
                        u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0.xy = u_xlat1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
                        u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
                        u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
                        vs_TEXCOORD3.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat9 = inversesqrt(u_xlat9);
                        vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
                        vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec3 _WorldSpaceCameraPos;
                    uniform 	mediump vec4 _WorldSpaceLightPos0;
                    uniform 	mediump vec4 unity_OcclusionMaskSelector;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    uniform 	mediump vec4 _LightColor0;
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform highp sampler2D _LightTexture0;
                    UNITY_LOCATION(2) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    vec3 u_xlat0;
                    vec3 u_xlat1;
                    vec3 u_xlat2;
                    vec3 u_xlat3;
                    vec4 u_xlat4;
                    mediump vec4 u_xlat16_4;
                    mediump vec3 u_xlat16_5;
                    mediump vec3 u_xlat16_6;
                    mediump vec3 u_xlat16_7;
                    vec3 u_xlat8;
                    mediump float u_xlat16_13;
                    mediump float u_xlat16_15;
                    float u_xlat16;
                    float u_xlat24;
                    float u_xlat25;
                    bool u_xlatb25;
                    float u_xlat26;
                    mediump float u_xlat16_29;
                    mediump float u_xlat16_30;
                    void main()
                    {
                        u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
                        u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat24 = inversesqrt(u_xlat24);
                        u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
                        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlat3.xy = vs_TEXCOORD2.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
                        u_xlat3.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat3.xy;
                        u_xlat3.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat3.xy;
                        u_xlat3.xy = u_xlat3.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
                        u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb25){
                            u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat4.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat4.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
                            u_xlat4.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
                            u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat4.xyz = (bool(u_xlatb25)) ? u_xlat4.xyz : vs_TEXCOORD2.xyz;
                            u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat25 = u_xlat4.y * 0.25 + 0.75;
                            u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                            u_xlat4.x = max(u_xlat25, u_xlat26);
                            u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
                            u_xlat16_4 = u_xlat4;
                        } else {
                            u_xlat16_4.x = float(1.0);
                            u_xlat16_4.y = float(1.0);
                            u_xlat16_4.z = float(1.0);
                            u_xlat16_4.w = float(1.0);
                        }
                        u_xlat16_5.x = dot(u_xlat16_4, unity_OcclusionMaskSelector);
                        u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
                        u_xlat25 = texture(_LightTexture0, u_xlat3.xy).w;
                        u_xlat25 = u_xlat16_5.x * u_xlat25;
                        u_xlat16_5.xyz = vec3(u_xlat25) * _LightColor0.xyz;
                        u_xlat25 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
                        u_xlat25 = inversesqrt(u_xlat25);
                        u_xlat3.xyz = vec3(u_xlat25) * vs_TEXCOORD1.xyz;
                        u_xlat16_6.xyz = u_xlat2.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
                        u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat24 = max(u_xlat24, 0.00100000005);
                        u_xlat24 = inversesqrt(u_xlat24);
                        u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
                        u_xlat24 = dot(u_xlat3.xyz, u_xlat1.xyz);
                        u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
                        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
                        u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
                        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
                        u_xlat16_29 = u_xlat0.x + u_xlat0.x;
                        u_xlat16_29 = u_xlat16_29 * u_xlat0.x + -0.5;
                        u_xlat16_30 = (-u_xlat1.x) + 1.0;
                        u_xlat16_7.x = u_xlat16_30 * u_xlat16_30;
                        u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
                        u_xlat16_30 = u_xlat16_30 * u_xlat16_7.x;
                        u_xlat16_30 = u_xlat16_29 * u_xlat16_30 + 1.0;
                        u_xlat16_7.x = -abs(u_xlat24) + 1.0;
                        u_xlat16_15 = u_xlat16_7.x * u_xlat16_7.x;
                        u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
                        u_xlat16_7.x = u_xlat16_7.x * u_xlat16_15;
                        u_xlat16_29 = u_xlat16_29 * u_xlat16_7.x + 1.0;
                        u_xlat16_29 = u_xlat16_29 * u_xlat16_30;
                        u_xlat8.x = u_xlat1.x * u_xlat16_29;
                        u_xlat16 = abs(u_xlat24) + u_xlat1.x;
                        u_xlat16 = u_xlat16 + 9.99999975e-06;
                        u_xlat16 = 0.5 / u_xlat16;
                        u_xlat16 = u_xlat1.x * u_xlat16;
                        u_xlat16 = u_xlat16 * 0.999999881;
                        u_xlat16_7.xyz = u_xlat8.xxx * u_xlat16_5.xyz;
                        u_xlat8.xyz = u_xlat16_5.xyz * vec3(u_xlat16);
                        u_xlat16_5.x = (-u_xlat0.x) + 1.0;
                        u_xlat16_13 = u_xlat16_5.x * u_xlat16_5.x;
                        u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
                        u_xlat16_5.x = u_xlat16_5.x * u_xlat16_13;
                        u_xlat16_5.x = u_xlat16_5.x * 0.959999979 + 0.0399999991;
                        u_xlat0.xyz = u_xlat8.xyz * u_xlat16_5.xxx;
                        u_xlat0.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
                        SV_Target0.xyz = u_xlat0.xyz;
                        SV_Target0.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
            }
        }
        Pass {
            Name "DEFERRED"
            LOD 200
            Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
            GpuProgramID 164588
            PlayerProgram "vp" {
                SubProgram "gles3 " {
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out highp vec4 vs_TEXCOORD4;
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    float u_xlat6;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
                        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat6 = inversesqrt(u_xlat6);
                        vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
                        vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 1) inout mediump vec4 SV_Target1;
                    #else
                    layout(location = 1) out mediump vec4 SV_Target1;
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 2) inout mediump vec4 SV_Target2;
                    #else
                    layout(location = 2) out mediump vec4 SV_Target2;
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 3) inout mediump vec4 SV_Target3;
                    #else
                    layout(location = 3) out mediump vec4 SV_Target3;
                    #endif
                    vec4 u_xlat0;
                    void main()
                    {
                        u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        SV_Target0.xyz = u_xlat0.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        SV_Target0.w = 1.0;
                        SV_Target1 = vec4(0.0399999991, 0.0399999991, 0.0399999991, 0.0);
                        u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
                        u_xlat0.w = 1.0;
                        SV_Target2 = u_xlat0;
                        SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
                        return;
                    }
                    
                    #endif
                    "
                }
                SubProgram "gles3 " {
                    Keywords { "LIGHTPROBE_SH" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	mediump vec4 unity_SHBr;
                    uniform 	mediump vec4 unity_SHBg;
                    uniform 	mediump vec4 unity_SHBb;
                    uniform 	mediump vec4 unity_SHC;
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out highp vec4 vs_TEXCOORD4;
                    out mediump vec3 vs_TEXCOORD5;
                    vec4 u_xlat0;
                    mediump vec4 u_xlat16_0;
                    vec4 u_xlat1;
                    mediump float u_xlat16_2;
                    mediump vec3 u_xlat16_3;
                    float u_xlat12;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
                        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat12 = inversesqrt(u_xlat12);
                        u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
                        vs_TEXCOORD1.xyz = u_xlat0.xyz;
                        vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
                        u_xlat16_2 = u_xlat0.y * u_xlat0.y;
                        u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
                        u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
                        u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
                        u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
                        u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
                        vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	mediump vec4 unity_SHAr;
                    uniform 	mediump vec4 unity_SHAg;
                    uniform 	mediump vec4 unity_SHAb;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    in mediump vec3 vs_TEXCOORD5;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 1) inout mediump vec4 SV_Target1;
                    #else
                    layout(location = 1) out mediump vec4 SV_Target1;
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 2) inout mediump vec4 SV_Target2;
                    #else
                    layout(location = 2) out mediump vec4 SV_Target2;
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 3) inout mediump vec4 SV_Target3;
                    #else
                    layout(location = 3) out mediump vec4 SV_Target3;
                    #endif
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    vec4 u_xlat2;
                    vec4 u_xlat3;
                    vec4 u_xlat4;
                    mediump vec3 u_xlat16_5;
                    mediump vec3 u_xlat16_6;
                    float u_xlat8;
                    float u_xlat21;
                    bool u_xlatb21;
                    void main()
                    {
                        u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlatb21 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb21){
                            u_xlatb21 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat1.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat1.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
                            u_xlat1.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
                            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat1.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
                            u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat21 = u_xlat1.y * 0.25;
                            u_xlat8 = unity_ProbeVolumeParams.z * 0.5;
                            u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
                            u_xlat21 = max(u_xlat21, u_xlat8);
                            u_xlat1.x = min(u_xlat2.x, u_xlat21);
                            u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
                            u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
                            u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
                            u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
                            u_xlat4.xyz = vs_TEXCOORD1.xyz;
                            u_xlat4.w = 1.0;
                            u_xlat16_5.x = dot(u_xlat2, u_xlat4);
                            u_xlat16_5.y = dot(u_xlat3, u_xlat4);
                            u_xlat16_5.z = dot(u_xlat1, u_xlat4);
                        } else {
                            u_xlat1.xyz = vs_TEXCOORD1.xyz;
                            u_xlat1.w = 1.0;
                            u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
                            u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
                            u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
                        }
                        u_xlat16_5.xyz = u_xlat16_5.xyz + vs_TEXCOORD5.xyz;
                        u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
                        u_xlat16_6.xyz = u_xlat0.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
                        SV_Target3.xyz = exp2((-u_xlat16_5.xyz));
                        SV_Target0.xyz = u_xlat16_6.xyz;
                        SV_Target0.w = 1.0;
                        SV_Target1 = vec4(0.0399999991, 0.0399999991, 0.0399999991, 0.0);
                        u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
                        u_xlat0.w = 1.0;
                        SV_Target2 = u_xlat0;
                        SV_Target3.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
                SubProgram "gles3 " {
                    Keywords { "UNITY_HDR_ON" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out highp vec4 vs_TEXCOORD4;
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    float u_xlat6;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
                        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat6 = inversesqrt(u_xlat6);
                        vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
                        vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 1) inout mediump vec4 SV_Target1;
                    #else
                    layout(location = 1) out mediump vec4 SV_Target1;
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 2) inout mediump vec4 SV_Target2;
                    #else
                    layout(location = 2) out mediump vec4 SV_Target2;
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 3) inout mediump vec4 SV_Target3;
                    #else
                    layout(location = 3) out mediump vec4 SV_Target3;
                    #endif
                    vec4 u_xlat0;
                    void main()
                    {
                        u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        SV_Target0.xyz = u_xlat0.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        SV_Target0.w = 1.0;
                        SV_Target1 = vec4(0.0399999991, 0.0399999991, 0.0399999991, 0.0);
                        u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
                        u_xlat0.w = 1.0;
                        SV_Target2 = u_xlat0;
                        SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
                        return;
                    }
                    
                    #endif
                    "
                }
                SubProgram "gles3 " {
                    Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
                    "#ifdef VERTEX
                    #version 300 es
                    
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	mediump vec4 unity_SHBr;
                    uniform 	mediump vec4 unity_SHBg;
                    uniform 	mediump vec4 unity_SHBb;
                    uniform 	mediump vec4 unity_SHC;
                    uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
                    uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
                    uniform 	vec4 _MainTex_ST;
                    in highp vec4 in_POSITION0;
                    in highp vec3 in_NORMAL0;
                    in highp vec4 in_TEXCOORD0;
                    out highp vec2 vs_TEXCOORD0;
                    out highp vec3 vs_TEXCOORD1;
                    out highp vec3 vs_TEXCOORD2;
                    out highp vec4 vs_TEXCOORD4;
                    out mediump vec3 vs_TEXCOORD5;
                    vec4 u_xlat0;
                    mediump vec4 u_xlat16_0;
                    vec4 u_xlat1;
                    mediump float u_xlat16_2;
                    mediump vec3 u_xlat16_3;
                    float u_xlat12;
                    void main()
                    {
                        u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
                        u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
                        vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
                        u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
                        u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
                        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
                        vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                        u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
                        u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
                        u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
                        u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
                        u_xlat12 = inversesqrt(u_xlat12);
                        u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
                        vs_TEXCOORD1.xyz = u_xlat0.xyz;
                        vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
                        u_xlat16_2 = u_xlat0.y * u_xlat0.y;
                        u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
                        u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
                        u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
                        u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
                        u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
                        vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
                        return;
                    }
                    
                    #endif
                    #ifdef FRAGMENT
                    #version 300 es
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    #extension GL_EXT_shader_framebuffer_fetch : enable
                    #endif
                    
                    precision highp float;
                    precision highp int;
                    #define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
                    #if HLSLCC_ENABLE_UNIFORM_BUFFERS
                    #define UNITY_UNIFORM
                    #else
                    #define UNITY_UNIFORM uniform
                    #endif
                    #define UNITY_SUPPORTS_UNIFORM_LOCATION 1
                    #if UNITY_SUPPORTS_UNIFORM_LOCATION
                    #define UNITY_LOCATION(x) layout(location = x)
                    #define UNITY_BINDING(x) layout(binding = x, std140)
                    #else
                    #define UNITY_LOCATION(x)
                    #define UNITY_BINDING(x) layout(std140)
                    #endif
                    uniform 	mediump vec4 unity_SHAr;
                    uniform 	mediump vec4 unity_SHAg;
                    uniform 	mediump vec4 unity_SHAb;
                    uniform 	vec4 unity_ProbeVolumeParams;
                    uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
                    uniform 	vec3 unity_ProbeVolumeSizeInv;
                    uniform 	vec3 unity_ProbeVolumeMin;
                    UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
                    UNITY_LOCATION(1) uniform highp sampler3D unity_ProbeVolumeSH;
                    in highp vec2 vs_TEXCOORD0;
                    in highp vec3 vs_TEXCOORD1;
                    in highp vec3 vs_TEXCOORD2;
                    in mediump vec3 vs_TEXCOORD5;
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 0) inout mediump vec4 SV_Target0;
                    #else
                    layout(location = 0) out mediump vec4 SV_Target0;
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 1) inout mediump vec4 SV_Target1;
                    #else
                    layout(location = 1) out mediump vec4 SV_Target1;
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 2) inout mediump vec4 SV_Target2;
                    #else
                    layout(location = 2) out mediump vec4 SV_Target2;
                    #endif
                    #ifdef GL_EXT_shader_framebuffer_fetch
                    layout(location = 3) inout mediump vec4 SV_Target3;
                    #else
                    layout(location = 3) out mediump vec4 SV_Target3;
                    #endif
                    vec4 u_xlat0;
                    vec4 u_xlat1;
                    vec4 u_xlat2;
                    vec4 u_xlat3;
                    vec4 u_xlat4;
                    mediump vec3 u_xlat16_5;
                    mediump vec3 u_xlat16_6;
                    float u_xlat8;
                    float u_xlat21;
                    bool u_xlatb21;
                    void main()
                    {
                        u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
                        u_xlatb21 = unity_ProbeVolumeParams.x==1.0;
                        if(u_xlatb21){
                            u_xlatb21 = unity_ProbeVolumeParams.y==1.0;
                            u_xlat1.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
                            u_xlat1.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
                            u_xlat1.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
                            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
                            u_xlat1.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
                            u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
                            u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
                            u_xlat21 = u_xlat1.y * 0.25;
                            u_xlat8 = unity_ProbeVolumeParams.z * 0.5;
                            u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
                            u_xlat21 = max(u_xlat21, u_xlat8);
                            u_xlat1.x = min(u_xlat2.x, u_xlat21);
                            u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
                            u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
                            u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
                            u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
                            u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
                            u_xlat4.xyz = vs_TEXCOORD1.xyz;
                            u_xlat4.w = 1.0;
                            u_xlat16_5.x = dot(u_xlat2, u_xlat4);
                            u_xlat16_5.y = dot(u_xlat3, u_xlat4);
                            u_xlat16_5.z = dot(u_xlat1, u_xlat4);
                        } else {
                            u_xlat1.xyz = vs_TEXCOORD1.xyz;
                            u_xlat1.w = 1.0;
                            u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
                            u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
                            u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
                        }
                        u_xlat16_5.xyz = u_xlat16_5.xyz + vs_TEXCOORD5.xyz;
                        u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
                        u_xlat16_6.xyz = u_xlat0.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
                        SV_Target3.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
                        SV_Target0.xyz = u_xlat16_6.xyz;
                        SV_Target0.w = 1.0;
                        SV_Target1 = vec4(0.0399999991, 0.0399999991, 0.0399999991, 0.0);
                        u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
                        u_xlat0.w = 1.0;
                        SV_Target2 = u_xlat0;
                        SV_Target3.w = 1.0;
                        return;
                    }
                    
                    #endif
                    "
                }
            }
        }
    }
}
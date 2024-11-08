//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "NK/Unlit/Field/NK_Field_SDToon" {
Properties {
[NoScaleOffset] _MainTex ("Texture", 2D) = "white" { }
[NoScaleOffset] _RimTex ("Rim Light Texture", 2D) = "white" { }
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
}
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  Blend One One, One One
  ZWrite Off
  GpuProgramID 96379
}
 Pass {
  Name "DEFERRED"
  LOD 200
  Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
  GpuProgramID 164588
}
}
}
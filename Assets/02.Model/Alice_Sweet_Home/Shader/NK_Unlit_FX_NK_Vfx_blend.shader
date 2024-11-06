//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "NK/Unlit/FX/NK_Vfx_blend" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_UVRotation ("UV Rotate", Float) = 0
_Color ("Color", Vector) = (1,1,1,1)
_OverlayColor ("Overlay Color", Vector) = (1,1,1,1)
_OverlayOpacity ("Overlay Opacity", Float) = 0
_CutOut ("Cut Out", Float) = 0
_BloomIntensity ("Bloom Intensity", Float) = 1
[Toggle] _AlphaTest ("Alpha Clipping", Float) = 1
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 56559
}
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  Blend One One, One One
  ZWrite Off
  GpuProgramID 121714
}
 Pass {
  Name "DEFERRED"
  LOD 200
  Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
  GpuProgramID 155996
}
}
}
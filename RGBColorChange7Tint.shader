Shader "RGB Color Change/7 Color Tint" {
	Properties {
		_MainTex ("Details", 2D) = "white" {}
		_ColorTex ("Color Map", 2D) = "white" {}
		_Color1 ("Base Color(Replaces White(255,255,255))", Color) = (1,1,1,1)
		_Color2 ("Red(255,0,0) Replacer", Color) = (1,1,1,1)
		_Color3 ("Green(0,255,0) Replacer", Color) = (1,1,1,1)
		_Color4 ("Blue(0,0,255) Replacer", Color) = (1,1,1,1)
		_Color5 ("Yellow(255,255,0) Replacer", Color) = (1,1,1,1)
		_Color6 ("Violet(255,0,255) Replacer", Color) = (1,1,1,1)
		_Color7 ("Cyan(0,255,255) Replacer", Color) = (1,1,1,1)
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _ColorTex;
		float4 _Color1,_Color2,_Color3,_Color4,_Color5,_Color6,_Color7;
		
		struct Input {
			float2 uv_MainTex;
			float2 uv_ColorTex;
		};

		half _Glossiness;
		half _Metallic;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 t = tex2D (_ColorTex, IN.uv_ColorTex);
			if (t.r >= .1 && t.g >= .1 && t.b >= .1) t = _Color1;
			else if (t.r >= .1 && t.g >= .1) t = _Color5;
			else if (t.r >= .1 && t.b >= .1) t = _Color6;
			else if (t.g >= .1 && t.b >= .1) t = _Color7;
			else if (t.r >= .1) t = _Color2;
			else if (t.g >= .1) t = _Color3;
			else if (t.b >= .1) t = _Color4;
			c = c * t;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}

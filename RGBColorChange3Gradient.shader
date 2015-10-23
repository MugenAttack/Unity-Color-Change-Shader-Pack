Shader "RGB Color Change/3 Color Gradient" {
	Properties {
		_MainTex ("Color Map", 2D) = "white" {}
		_Color1 ("Red(255,0,0) Replacer", Color) = (1,1,1,1)
		_Color2 ("Green(0,255,0) Replacer", Color) = (1,1,1,1)
		_Color3 ("Blue(0,0,255) Replacer", Color) = (1,1,1,1)
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
		float4 _Color1,_Color2,_Color3;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 r = _Color1 * (c.r,c.r,c.r,c.r);
			fixed4 g = _Color2 * (c.g,c.g,c.g,c.g);
			fixed4 b = _Color3 * (c.b,c.b,c.b,c.b);
			fixed4 average = (r + g + b);
			c = average;
			 
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

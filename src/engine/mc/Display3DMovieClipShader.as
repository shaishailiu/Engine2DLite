package engine.mc
{
	import engine.programs.Shader3D;
	
	
	public class Display3DMovieClipShader extends Shader3D
	{
		public static var DISPLAY3D_MOVIECLIP_SHADER:String = "Display3DMovieClipShader";
		public function Display3DMovieClipShader()
		{
			vertex = 
				"mov vt0,va0 \n" + 
				
				"mov vt1, va1 \n" +
				
				"mul vt0.xy,vt0.xy,vc4.xy \n" + 
				"add vt0.xy,vt0.xy,vc[vt1.z].zw \n" + 
				"mov op, vt0 \n" +
				
				"mul vt1.xy, vt1.xy,vc5.zw \n" +
				"add vt1.xy, vt1.xy,vc[vt1.z].xy \n" +
				
				"mov v1, vt1";
			fragment =
				"tex ft1, v1, fs1 <2d,linear,repeat>\n"+
				"mov oc, ft1";
		}
	}
}
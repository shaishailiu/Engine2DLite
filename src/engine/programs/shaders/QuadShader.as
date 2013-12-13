package engine.programs.shaders
{
	import engine.programs.Shader3D;
	
	
	public class QuadShader extends Shader3D
	{
		public static var QUAD_SHADER:String = "QuadShader";
		public function QuadShader()
		{
			vertex = 
				"mov vt0,va0 \n" + 
				"mul vt0.xy,vt0.xy,vc4.xy \n" + 
				"add vt0.xy,vt0.xy,vc4.zw \n" + 
				"mov op, vt0 \n" +
				"mov v1, va1";
			fragment =
				"tex ft1, v1, fs1 <2d,linear,repeat>\n"+
				"mov oc, ft1";
		}
	}
}
package engine.programs
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display3D.Context3DProgramType;
	import flash.utils.ByteArray;
	
	public class Shader3D implements IShader3D
	{
		public var vertex:String;
		public var fragment:String;
		private var vertexByte:ByteArray;
		private var fragmentByte:ByteArray;
		public function Shader3D()
		{
		}
		
		public function get vertexShaderByte():ByteArray
		{
			return vertexByte;
		}
		
		public function get fragmentShaderByte():ByteArray
		{
			return fragmentByte;
		}
		
		public function encode(agal:AGALMiniAssembler):void
		{
			vertexByte = agal.assemble(Context3DProgramType.VERTEX,vertex);
			fragmentByte = agal.assemble(Context3DProgramType.FRAGMENT,fragment);
		}
	}
}
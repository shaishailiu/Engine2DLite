package engine.programs
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.utils.ByteArray;

	public interface IShader3D
	{
		function get vertexShaderByte():ByteArray;
		function get fragmentShaderByte():ByteArray;
		function encode(agal:AGALMiniAssembler):void;
	}
}
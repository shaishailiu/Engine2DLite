package engine.programs
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import engine.core.Scene_data;
	
	import flash.display3D.Context3D;
	import flash.display3D.Program3D;
	
	import engine.programs.shaders.StatShader;

	public class Program3DManager
	{
		private static var instance:Program3DManager;
		private var _context3D:Context3D;
		private var _programDic:Object;
		private var _classDic:Object;
		private var _shaderAssembler:AGALMiniAssembler;
		public function Program3DManager()
		{
			this._context3D = Scene_data.context3D;
			_programDic = new Object;
			_classDic = new Object;
			_shaderAssembler = new AGALMiniAssembler();
		}
		public static function getInstance():Program3DManager{
			if(!instance){
				instance = new Program3DManager();
			}
			return instance;
		}
		
		public function initReg():void{
			//注册着色器
			registe(StatShader.STATSHADER,StatShader);
		}
		public function getProgram(key:String):Program3D{
			if(_programDic[key]){
				return _programDic[key];
			}else{
				if(_classDic[key]){
					var cls:Class = _classDic[key];
					var shader:IShader3D = new cls();
					shader.encode(_shaderAssembler);
					try{
						var program:Program3D = _context3D.createProgram();
						program.upload(shader.vertexShaderByte,shader.fragmentShaderByte);
					} catch(error:Error) {}
					_programDic[key] = program;
					return program;
				}else{
					throw new Error("未注册的着色器:" + key)
				}
			}
			return null;
		}
		
		public function registe(key:String,shaderCls:Class):void{
			_classDic[key] = shaderCls;
		}
		
		public function reload():void{
			this._context3D = Scene_data.context3D;
			
			for(var key:String in _classDic){
				var cls:Class = _classDic[key];
				var shader:IShader3D = new cls();
				shader.encode(_shaderAssembler);
				var program:Program3D = _context3D.createProgram();
				program.upload(shader.vertexShaderByte,shader.fragmentShaderByte);
				_programDic[key] = program;
			}
		}
		
	}
}
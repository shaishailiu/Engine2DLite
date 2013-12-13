package engine.display3D
{
	import engine.core.ObjData;
	import engine.core.Scene_data;
	import engine.core.TextureVo;
	import engine.programs.Program3DManager;
	import engine.programs.shaders.QuadShader;
	import engine.programs.shaders.StatShader;
	import engine.textures.TextureManager;
	
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Program3D;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	public class Display3DBackImg extends Display3DQuad
	{
		public function Display3DBackImg(context:Context3D)
		{
			super(context);
			initData2();
			//loadTexture();
			this.program = Program3DManager.getInstance().getProgram(QuadShader.QUAD_SHADER);
		}
		
		override protected function setVc():void{
			//var width:int = 256;
			//var height:int = 128;
			
			var sw:Number = 2*_width/Scene_data.stageWidth;
			var sh:Number = -2*_height/Scene_data.stageHeight;
			
			var sx:Number = 2*_x/Scene_data.stageWidth - 1;
			var sy:Number = -2*_y/Scene_data.stageHeight + 1;
			
			_context.setProgramConstantsFromVector(Context3DProgramType.VERTEX,4,Vector.<Number>( [sw,sh,sx,sy]));
			
		}
		
		public function loadTexture($url:String):void{
			TextureManager.getInstance().addTexture($url,addTexture,null);
		}
		private function addTexture(textureVo:TextureVo,info:Object):void{
			_objData.texture = textureVo.texture;
			
			//_width = textureVo.bitmapdata.width;
			//_height = textureVo.bitmapdata.height;
			
			_width = 1280;
			_height = 768;
		}
		public function initData():void{
			_objData = new ObjData;
			var vertices:Vector.<Number> = new Vector.<Number>;
			var uvs:Vector.<Number> = new Vector.<Number>;
			var indexs:Vector.<uint> = new Vector.<uint>;
			
			
			vertices.push(0,0,0);
			vertices.push(1,0,0);
			vertices.push(0,1,0);
			vertices.push(1,1,0);
			
			uvs.push(0,0);
			uvs.push(1,0);
			uvs.push(0,1);
			uvs.push(1,1);
			
			indexs.push(0,1,2,1,3,2);
			
			_objData.vertices = vertices;
			_objData.uvs = uvs;
			_objData.indexs = indexs;
			
			uplodToGpu();
		}
		public function initData2():void{
			_objData = new ObjData;
			var wNum:Number = (1024 - 768)/2/1280;
			var secondNum:Number = (1024-768)/1024;
			var thridNum:Number = (1024-128)/1024;
			var fourNum:Number = 128/1024;
			var fiveNum:Number = 768/1024;
			
			var vertices:Vector.<Number> = new Vector.<Number>;
			var uvs:Vector.<Number> = new Vector.<Number>;
			var indexs:Vector.<uint> = new Vector.<uint>;
			
			vertices.push(0,0,0);
			vertices.push(wNum,0,0);
			vertices.push(0,1,0);
			vertices.push(wNum,1,0);
			
			uvs.push(fiveNum,thridNum);
			uvs.push(fiveNum,1);
			uvs.push(0,thridNum);
			uvs.push(0,1);
			
			indexs.push(0,1,2,1,3,2);
			
			vertices.push(wNum,0,0);
			vertices.push(1-wNum,0,0);
			vertices.push(wNum,1,0);
			vertices.push(1-wNum,1,0);
			
			uvs.push(0,fourNum);
			uvs.push(1,fourNum);
			uvs.push(0,thridNum);
			uvs.push(1,thridNum);
			
			indexs.push(0+4,1+4,2+4,1+4,3+4,2+4);
			
			vertices.push(1-wNum,0,0);
			vertices.push(1,0,0);
			vertices.push(1-wNum,1,0);
			vertices.push(1,1,0);
			
			uvs.push(fiveNum,0);
			uvs.push(fiveNum,fourNum);
			uvs.push(0,0);
			uvs.push(0,fourNum);
			
			indexs.push(0+8,1+8,2+8,1+8,3+8,2+8);
			
			_objData.vertices = vertices;
			_objData.uvs = uvs;
			_objData.indexs = indexs;
			
			uplodToGpu();
		}
		
		
	}
}
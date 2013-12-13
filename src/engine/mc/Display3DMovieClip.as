package engine.mc
{
	import engine.core.ObjData;
	import engine.core.Scene_data;
	import engine.core.TextureVo;
	import engine.display3D.Display3DQuad;
	import engine.programs.Program3DManager;
	import engine.programs.shaders.QuadShader;
	import engine.textures.TextureManager;
	
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.geom.Point;
	
	public class Display3DMovieClip extends Display3DQuad
	{
		//num = 16
		private var _baseWidth:Number;
		private var _baseHeight:Number;
		
		private var _allFrame:int;
		
		private var _uvPosVec:Vector.<Point>;
		
		private var _frame:int;

		private var uNum:Number;

		private var vNum:Number;
		
		private var _time:uint;
		
		private var _frameTime:uint = 33;
		
		private var _mcVec:Vector.<MovieClip3D>;
		
		public function Display3DMovieClip(context:Context3D)
		{
			super(context);
			initData();
			_mcVec = new Vector.<MovieClip3D>;
			this.program = Program3DManager.getInstance().getProgram(Display3DMovieClipShader.DISPLAY3D_MOVIECLIP_SHADER);
		}
		
		
		override protected function setVc():void{
			var sw:Number = 2*_baseWidth/Scene_data.stageWidth;
			var sh:Number = -2*_baseHeight/Scene_data.stageHeight;
			
			var sx:Number = 2*_x/Scene_data.stageWidth - 1;
			var sy:Number = -2*_y/Scene_data.stageHeight + 1;
			
			_context.setProgramConstantsFromVector(Context3DProgramType.VERTEX,4,Vector.<Number>( [sw,sh,1,1]));
			
			_context.setProgramConstantsFromVector(Context3DProgramType.VERTEX,5,Vector.<Number>( [0,0,uNum,vNum]));
			
			
			for(var i:int;i<_mcVec.length;i++){
				
				sx = 2*(_mcVec[i].useX)/Scene_data.stageWidth - 1;
				sy = -2*(_mcVec[i].useY)/Scene_data.stageHeight + 1;
				
				_context.setProgramConstantsFromVector(Context3DProgramType.VERTEX,20 + i,Vector.<Number>( [_uvPosVec[_mcVec[i].frame].x,_uvPosVec[_mcVec[i].frame].y,sx,sy]));
			}
			
		}
		
		public function updateFrame(time:int):void{
			
			for(var i:int;i<_mcVec.length;i++){
				if(_mcVec[i].isShow){
					_mcVec[i].updateFrame(time);
				}
			}
//			_time += time;
//			
//			_frame = int(_time/_frameTime);
//			
//			if(_frame >= _allFrame){
//				_frame = 0;
//				_time = 0;
//			}
//			
			//_frame++;
			
			
		}
		
		public function setBaseWidthHeight($baseWidth:Number,$baseHeight:Number,$allFrame:int = 16 * 8):void{
			_baseWidth = $baseWidth;
			_baseHeight = $baseHeight;
			_allFrame = $allFrame;
			
			for(var i:int;i<100;i++){
				var mc:MovieClip3D = new MovieClip3D;
				mc.displayTarget = this;
				mc.allFrame = $allFrame;
				_mcVec.push(mc);
			}
			
		}
		
		public function loadTexture($url:String):void{
			TextureManager.getInstance().addTexture($url,addTexture,null);
		}
		
		private function addTexture(textureVo:TextureVo,info:Object):void{
			_objData.texture = textureVo.texture;
			
			_width = textureVo.bitmapdata.width;
			_height = textureVo.bitmapdata.height;
			
			initUV();
		}
		
		private function initUV():void{
			var wNum:int = _width / _baseWidth;
			var hNum:int = _height / _baseHeight;
			
			uNum = 1/wNum;
			vNum = 1/hNum;
			
			_uvPosVec = new Vector.<Point>;
			
			for(var i:int;i<hNum;i++){
				for(var j:int=0;j<wNum;j++){
					var p:Point = new Point;
					p.x = j * uNum;
					p.y = i * vNum;
					_uvPosVec.push(p);
					
					
					if(_allFrame == _uvPosVec.length){
						return;
					}
					
				}
			}
			
			
		}
		
		public function getIdleMovie():MovieClip3D{
			for(var i:int;i<_mcVec.length;i++){
				if(!_mcVec[i].isUse){
					_mcVec[i].isUse = true;
					return _mcVec[i];
				}
			}
			return null;
		}
		
		public function clear():void{
			for(var i:int;i<_mcVec.length;i++){
				if(_mcVec[i].isShow){
					return;
				}
			}
			if(this.parent){
				this.parent.removeChild(this);
			}
		}
		
		public function initData():void{
			_objData = new ObjData;
			var vertices:Vector.<Number> = new Vector.<Number>;
			var uvs:Vector.<Number> = new Vector.<Number>;
			var indexs:Vector.<uint> = new Vector.<uint>;
			
			for(var i:int;i<100;i++){
				
				vertices.push(0,0,0);
				vertices.push(1,0,0);
				vertices.push(0,1,0);
				vertices.push(1,1,0);
				
				uvs.push(0,0,i + 20);
				uvs.push(1,0,i + 20);
				uvs.push(0,1,i + 20);
				uvs.push(1,1,i + 20);
				
				indexs.push(0 + 4*i,1 + 4*i,2+ 4*i,1 + 4*i,3 + 4*i,2 + 4*i);
				
				
			}
			
			
			_objData.vertices = vertices;
			_objData.uvs = uvs;
			_objData.indexs = indexs;
			
			uplodToGpu();
		}
		
		override protected function uplodToGpu() : void {
			_objData.vertexBuffer = this._context.createVertexBuffer(_objData.vertices.length / 3, 3);
			_objData.vertexBuffer.uploadFromVector(Vector.<Number>(_objData.vertices), 0, _objData.vertices.length / 3);
			
			_objData.uvBuffer = this._context.createVertexBuffer(_objData.uvs.length / 3, 3);
			_objData.uvBuffer.uploadFromVector(Vector.<Number>(_objData.uvs), 0, _objData.uvs.length / 3);
			
			_objData.indexBuffer = this._context.createIndexBuffer(_objData.indexs.length);
			_objData.indexBuffer.uploadFromVector(Vector.<uint>(_objData.indexs), 0, _objData.indexs.length);
		}
		
		override protected function setVa() : void {
			_context.setVertexBufferAt(0, _objData.vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			_context.setVertexBufferAt(1, _objData.uvBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			_context.setTextureAt(1, _objData.texture);
			_context.drawTriangles(_objData.indexBuffer, 0, -1);
		}
		
		
		
	}
}
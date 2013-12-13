package  engine.display3D{
	import engine.core.ObjData;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.Program3D;
	import flash.geom.Matrix3D;

	/**
	 * @author liuyanfei  QQ: 421537900
	 */
	public class Display3DQuad {
		protected var _objData : ObjData;
		protected var _context : Context3D;
		private var _bitmapdata : BitmapData;
		private var _modelMatrix : Matrix3D;
		protected var _program:Program3D;
		
		protected var _width:int;
		protected var _height:int;
		
		protected var _x:int;
		protected var _y:int;
		
		protected var _visible:Boolean = true;
		
		public var parent:Display3DContainer;

		public function Display3DQuad(context : Context3D) {
			this._context = context;
		}

		public function update() : void {
			if (_objData && _objData.texture) {
				_context.setProgram(this.program);
				setVc();
				setVa();
				resetVa();
			}
		}
		
		public function setMatrix(modelMatrix : Matrix3D) : void {
			this._modelMatrix = modelMatrix;
		}

		private function onTextureLoad(bitmap : Bitmap) : void {
			this._bitmapdata = bitmap.bitmapData;
			uplodToGpu();
		}
 
//		protected function addTexture(textureVo : TextureVo, info : Object) : void {
//			_objData.texture = textureVo.texture;
//			textureVo.useNum++
//			uplodToGpu();
//			Scene_data.loadModeOk(_url);
//			this.loadComplete = true;
//			this.dispatchEvent(new Event(LOAD_COMPLETE));
//		}

		protected function uplodToGpu() : void {
 			_objData.vertexBuffer = this._context.createVertexBuffer(_objData.vertices.length / 3, 3);
			_objData.vertexBuffer.uploadFromVector(Vector.<Number>(_objData.vertices), 0, _objData.vertices.length / 3);

			_objData.uvBuffer = this._context.createVertexBuffer(_objData.uvs.length / 2, 2);
			_objData.uvBuffer.uploadFromVector(Vector.<Number>(_objData.uvs), 0, _objData.uvs.length / 2);

			if(_objData.normals){
				_objData.normalsBuffer = this._context.createVertexBuffer(_objData.normals.length / 3, 3);
				_objData.normalsBuffer.uploadFromVector(Vector.<Number>(_objData.normals), 0, _objData.normals.length / 3);
			}

			_objData.indexBuffer = this._context.createIndexBuffer(_objData.indexs.length);
			_objData.indexBuffer.uploadFromVector(Vector.<uint>(_objData.indexs), 0, _objData.indexs.length);
		}
		
		protected function setVa() : void {
			_context.setVertexBufferAt(0, _objData.vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			_context.setVertexBufferAt(1, _objData.uvBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
			_context.setTextureAt(1, _objData.texture);
			_context.drawTriangles(_objData.indexBuffer, 0, -1);
		}
		
		protected function resetVa() : void {
			_context.setVertexBufferAt(0, null);
			_context.setVertexBufferAt(1, null);
			_context.setVertexBufferAt(2, null);
			_context.setTextureAt(1,null);
		}

		protected function setVc() : void {
			//this.updateMatrix();
			//_context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, modelMatrix, true);
		}

		public function get objData():ObjData
		{
			return _objData;
		}
		public function set objData(value:ObjData):void
		{
			_objData = value;
		}
		
		public function get disposed():Boolean
		{
			return this._context.driverInfo == "Disposed";
		}
		public function removeRender():void{
			
		}
		public function get program():Program3D
		{
			return _program;
		}
		
		public function set program(value:Program3D):void
		{
			_program = value;
		}
		
		public function reload():void{
			//_context = Scene_data.context3D;
		}

		public function get width():int
		{
			return _width;
		}

		public function set width(value:int):void
		{
			_width = value;
		}

		public function get height():int
		{
			return _height;
		}

		public function set height(value:int):void
		{
			_height = value;
		}

		public function get x():int
		{
			return _x;
		}

		public function set x(value:int):void
		{
			_x = value;
		}

		public function get y():int
		{
			return _y;
		}

		public function set y(value:int):void
		{
			_y = value;
		}
		
		public function dispose():void{
			
		}

		
	}
}
package engine.core
{
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;

	public class ObjData
	{
		public var vertices:Vector.<Number>;
		public var normals:Vector.<Number>;
		public var uvs:Vector.<Number>;
		public var indexs:Vector.<uint>;
		public var mtl:String;
		
		public var vertexBuffer:VertexBuffer3D;
		public var uvBuffer:VertexBuffer3D;
		public var normalsBuffer:VertexBuffer3D;
		public var indexBuffer:IndexBuffer3D;
		public var texture:Texture;
		public var textureVo:TextureVo;
		
		public var hasDispose:Boolean;
		
		public function ObjData()
		{
			
		}
		
		public function dispose():void{
			if(vertexBuffer)
				vertexBuffer.dispose();
			if(uvBuffer)
				uvBuffer.dispose();
			if(normalsBuffer)
				normalsBuffer.dispose();
			if(indexBuffer)
				indexBuffer.dispose();
			if(textureVo){
				textureVo.useNum--;
			}
			
			if(vertices){
				vertices.length = 0;
				vertices = null;
			}
			
			if(normals){
				normals.length = 0;
				normals = null;
			}
			
			if(uvs){
				uvs.length = 0;
				uvs = null;
			}
			
			if(indexs){
				indexs.length = 0;
				indexs = null;
			}
			
			mtl = null;
			
		}
		
	}
}
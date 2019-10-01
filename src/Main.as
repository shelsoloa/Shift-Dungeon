package
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import net.flashpunk.Engine;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;

    public class Main extends Engine
    {
        public function Main() {
            super(640, 427, 60, false);
            FP.screen.color = 0x0C0C0C;
        }
        
        override public function init():void {
            Config.SPRITES = scale_image(Config.RAW_SPRITES, 2);
            FP.world = new FirstFloor();
        }
        
        private function scale_image(source:Class, scale:Number):BitmapData {
            var sourceBitmap:Bitmap = new source();
            var sourceBitmapdata:BitmapData = sourceBitmap.bitmapData;
            var matrix:Matrix = new Matrix();
            matrix.scale(scale, scale);
            var scaledBitmapdata:BitmapData = new BitmapData(sourceBitmapdata.width * scale, sourceBitmapdata.height * scale, true, 0x000000);
            scaledBitmapdata.draw(sourceBitmapdata, matrix);
            return scaledBitmapdata;
        }
    }
}

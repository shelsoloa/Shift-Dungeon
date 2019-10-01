package
{
    import net.flashpunk.graphics.Image;
    import flash.display.BitmapData;


    public class Config {
        [Embed(source = 'sprites.png')]
        public static const RAW_SPRITES:Class;
        
        [Embed(fontName = "CourierPrime", source = "Courier Prime Code.ttf")]
        public static const INPUT_FONT:Class;
        public static var font_style:Object = { font: "CourierPrime" };
        
        public static var SPRITES:BitmapData;
    }
}

package
{
    import net.flashpunk.Entity;
    import net.flashpunk.utils.Draw;

    public class Tile extends Entity {
        private var _row:Number = 0;
        private var _col:Number = 0;

        public var solid:Boolean = false;
        public var contents:Actor = null;

        public static const WIDTH:Number = 32;
        public static const HEIGHT:Number = 32;

        public function Tile(row:Number, column:Number, solid:Boolean) {
            this.type = 'tile';
            this._row = row;
            this._col = column;
            this.solid = solid;
            this.contents = null;
        }

        public function get movable():Boolean {
            return !contents || contents.movable;
        }

        public function get row():int {
            return _row;
        }
        public function set row(row:int):void {
            if (contents) contents.row = row;
            _row = row;
        }

        public function get column():int {
            return _col;
        }
        public function set column(column:int):void {
            if (contents) contents.column = column;
            _col = column;
        }

        override public function render():void {
            var color:uint;
            if (solid)
                color = 0x001F3A;
            else
                color = 0x09030B;

            Draw.rect(column * WIDTH + column + Dungeon.OFFSET_X,
                      row * HEIGHT + row + Dungeon.OFFSET_Y,
                      WIDTH, HEIGHT, color);
        }
    }
}

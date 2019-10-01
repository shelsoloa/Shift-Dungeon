package
{
    import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Draw;
    
    public class Actor extends Entity {
        protected var current_tile:Tile = null;
        public var movable:Boolean = true;
        public var row:int = 0;
        public var column:int = 0;

        protected var sprite:Spritemap;

        public static const NORTH:int = 0;
        public static const SOUTH:int = 1;
        public static const EAST:int = 2;
        public static const WEST:int = 3;
        public var direction:int = SOUTH;

        public static const WAIT_TIME:int = 120;
        public var move_timer:int = 0;

        public function Actor() {
            type = 'actor';
            direction = SOUTH;
            move_timer = 0;
        }

        public function move_to(col:int, row:int):void {
            var dungeon:Dungeon = FP.world as Dungeon;
            var dest_tile:Tile = dungeon.get_tile(col, row);
            
            if (dest_tile.contents != null || dest_tile.solid)
                trace("CANNOT MOVE: TILE IS OCCUPIED");
            else {
                if (current_tile != null)
                    current_tile.contents = null;

                current_tile = dest_tile;
                current_tile.contents = this;

                this.row = row;
                this.column = col;
            }
        }

        override public function render():void {
            Draw.graphic(sprite, 
                column * Tile.WIDTH + column + Dungeon.OFFSET_X,
                row * Tile.HEIGHT + row + Dungeon.OFFSET_Y);
        }

        protected function rotate(clockwise:Boolean):void {
            if (direction == NORTH) {
                if (clockwise)
                    direction = WEST;
                else
                    direction = EAST;
            }
            else if (direction == WEST) {
                if (clockwise)
                    direction = SOUTH;
                else
                    direction = NORTH;
            }
            else if (direction == SOUTH) {
                if (clockwise)
                    direction = EAST;
                else
                    direction = WEST;
            }
            else if (direction == EAST) {
                if (clockwise)
                    direction = NORTH;
                else
                    direction = SOUTH;
            }
        }
    }
}

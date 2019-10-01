package
{
    import net.flashpunk.utils.Draw;

    public class StairsDown extends Actor {

        public function StairsDown(row:int, column:int) {
            super();
            type = 'stairs';
            movable = false;
            move_to(row, column);
        }

        override public function update():void {
            if (current_tile.contents == null)
                current_tile.contents = this;
        }

        override public function render():void {
            Draw.circlePlus(
                column * Tile.WIDTH + (Tile.WIDTH / 2) + column + Dungeon.OFFSET_X,
                row * Tile.HEIGHT + (Tile.HEIGHT / 2) + row + Dungeon.OFFSET_Y,
                8, 0x614126);
        }
    }
}

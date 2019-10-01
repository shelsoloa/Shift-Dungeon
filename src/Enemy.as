package
{
    import net.flashpunk.Entity;
    import net.flashpunk.FP;

    public class Enemy extends Actor {
        public var max_health:int = 0;
        public var health:int = 0;
        public var attack:int = 0;
        public var experience_points:int = 0;
        public var tag:String = '';

        public function Enemy(row:int, column:int) {
            super();
            type = 'enemy';
            movable = false;
            move_to(row, column);
        }

        public function destroy():void {
            current_tile.contents = null;
            FP.world.remove(this);
        }

        override public function move_to(col:int, row:int):void {
            var dungeon:Dungeon = FP.world as Dungeon;
            var dest_tile:Tile = dungeon.get_tile(col, row);

            if (!dest_tile || dest_tile.solid) {
                rotate(false);
                return;
            }
            if (dest_tile.contents) {
                if (dest_tile.contents.name == 'warrior') {
                    var warrior:Warrior = dest_tile.contents as Warrior;
                    warrior.fight(this)

                    if (warrior.health <= 0)
                        dungeon.game_over();
                    else if (health > 0)
                        return;
                }
                else if (dest_tile.contents.type == 'heart') {
                    var heart:Heart = dest_tile.contents as Heart;
                    heart.consume();
                    health = max_health;
                }
            }

            if (current_tile != null)
                current_tile.contents = null;

            current_tile = dest_tile;
            current_tile.contents = this;

            this.row = row;
            this.column = col;
        }
        
        override public function update():void {
            move_timer += 1;
            if (move_timer > WAIT_TIME) {
                if (direction == NORTH)
                    move_to(column, row - 1);
                else if (direction == SOUTH)
                    move_to(column, row + 1);
                else if (direction == EAST)
                    move_to(column - 1, row);
                else if (direction == WEST)
                    move_to(column + 1, row);
                move_timer = 0;
            }
        }
    }
}

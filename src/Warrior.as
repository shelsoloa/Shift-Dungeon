package
{
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Draw;
    
    public class Warrior extends Actor {
        public var level:int = 1;
        public var max_health:int = 0;
        public var health:int = 7;
        public var attack:int = 0;
        public var exp:int = 0;
        public var exp_required:int = 0;

        public function Warrior() {
            super();
            name = 'warrior';
            reset(1);
            direction = SOUTH;
            
            sprite = new Spritemap(Config.SPRITES, 32, 32);
            sprite.add("north", [3]);
            sprite.add("south", [0]);
            sprite.add("east", [1]);
            sprite.add("west", [2]);
            sprite.play("south");
            
            graphic = sprite;
        }

        public function fight(enemy:Enemy):void {
            health -= enemy.attack;
            enemy.health -= attack;
            
            trace("-- FIGHT --");
            trace("Warrior took " + enemy.attack + " damage. HP: " + health);
            trace("Enemy took " + attack + " damage. HP: " + enemy.health + "\n");

            if (enemy.health <= 0) {
                exp += enemy.experience_points;
                enemy.destroy();

                if (exp >= exp_required) {
                    level_up();
                }
            }
        }

        private function set_stats(level:int):void {
            if (level == 1) {
                max_health = 8;
                attack = 1;
                exp_required = 6;
            }
            if (level == 2) {
                max_health = 12;
                attack = 2;
                exp_required = 12;
            }
            if (level == 3) {
                max_health = 15;
                attack = 3;
            }
            if (level == 4) {
                max_health = 20;
                attack = 4;
                exp_required = 16;
            }
            if (level == 5) {
                max_health = 25;
                attack = 5;
                exp_required = 20;
            }
        }

        public function level_up():void {
            level += 1;
            exp -= exp_required;

            var prev_max:int = max_health;
            set_stats(level);
            health += max_health - prev_max;
        }

        public function reset(level:int):void {
            this.level = level;

            set_stats(level);

            health = max_health;
            exp = 0;
        }

        override public function move_to(col:int, row:int):void {
            var dungeon:Dungeon = FP.world as Dungeon;
            var dest_tile:Tile = dungeon.get_tile(col, row);

            if (!dest_tile || dest_tile.solid) {
                rotate(true);
                return;
            }
            if (dest_tile.contents) {
                if (dest_tile.contents.type == 'enemy') {
                    var enemy:Enemy = dest_tile.contents as Enemy;
                    fight(enemy);
                    if (health <= 0) {
                        dungeon.game_over();
                    }
                    else if (enemy.health > 0)
                        return;
                    else {
                        exp += enemy.experience_points;
                        if (exp >= exp_required) {
                            level_up();
                        }
                    }
                }
                else if (dest_tile.contents.type == 'stairs') {
                    if (dungeon.typeCount('enemy') == 0) {
                        dungeon.advance();
                    }
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

        override public function render():void {
            if (direction == NORTH)
                sprite.play("north");
            else if (direction == SOUTH)
                sprite.play("south");
            else if (direction == EAST)
                sprite.play("east");
            else if (direction == WEST)
                sprite.play("west");
            
            Draw.graphic(sprite, 
                column * Tile.WIDTH + column + Dungeon.OFFSET_X,
                row * Tile.HEIGHT + row + Dungeon.OFFSET_Y);
        }
    }
}

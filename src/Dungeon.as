package
{
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;
    import net.flashpunk.utils.Draw;

    public class Dungeon extends World {
        
        public static const MAX_ROWS:int = 11;
        public static const MAX_COLS:int = 11;
        
        public static const BOARD_WIDTH:int = MAX_ROWS * Tile.WIDTH + MAX_ROWS;
        public static const BOARD_HEIGHT:int = MAX_COLS * Tile.HEIGHT + MAX_COLS;

        public static const OFFSET_X:int = FP.width - BOARD_WIDTH - 32;
        public static const OFFSET_Y:int = 32;
        
        protected var selected_row:int = 5;
        protected var selected_col:int = 5;

        public const STATE_MOVE:int = 0;
        public const STATE_SHIFT:int = 1;
        public const STATE_PAUSE:int = 2;
        protected var state:int = STATE_MOVE;

        protected var warrior:Warrior = null;
        protected var starting_level:int = 1;
        
        public function Dungeon(warrior:Warrior) {
            super(); 

            create_tiles();

            this.warrior = warrior;
            this.warrior.direction = Actor.SOUTH;
            starting_level = warrior.level;
            add(this.warrior);
        }

        public function advance():void { }

        public function reset():void {
            removeAll();
            create_tiles();
            warrior.reset(starting_level);
            add(warrior);
        }

        public function game_over():void {
            remove(this.warrior);
            FP.world = new GameOver();
        }

        override public function begin():void {
            var test:Tile = get_tile(3, 3);
            test.solid = false;
            warrior.move_to(3, 3);
        }

        public function get_tile(col:int, row:int):Tile {
            var tiles:Array = new Array();
            getType('tile', tiles);

            for each (var tile:Tile in tiles) {
                if (tile.row == row && tile.column == col)
                    return tile;
            }
            return null;
        }

        public function shift_column(column:int, direction:int):void {
            var tiles:Array = new Array();
            var tile:Tile = null;
            getType('tile', tiles);

            // verify
            for each(tile in tiles) {
                if (tile.column == column && !tile.solid) {
                    if (tile.contents && !tile.contents.movable)
                        return;

                    var dest_row:int = tile.row + direction;
                    if (dest_row == -1 || dest_row == MAX_ROWS)
                        return;
                }
            }

            for each(tile in tiles) {
                if (tile.column == column) {
                    tile.row += direction;
                    if (tile.row == -1)
                        tile.row = MAX_ROWS - 1;
                    else if (tile.row == MAX_ROWS)
                        tile.row = 0;
                }
            }
        }

        public function shift_row(row:int, direction:int):void {
            var tiles:Array = new Array();
            var tile:Tile = null;
            getType('tile', tiles);

            // verify
            for each(tile in tiles) {
                if (tile.row == row && !tile.solid) {
                    if (tile.contents && !tile.contents.movable)
                        return;
                    var dest_column:int = tile.column + direction;
                    if (dest_column == -1 || dest_column == MAX_COLS)
                        return;
                        // TODO temp flag
                }
            }

            // shift
            for each(tile in tiles) {
                if (tile.row == row) {
                    tile.column += direction;
                    if (tile.column == -1) {
                        tile.column = MAX_COLS - 1;
                    }
                    else if (tile.column == MAX_COLS) {
                        tile.column = 0;
                    }
                }
            }
        }

        override public function update():void {
            var keypressed_pause:Boolean = Input.pressed(Key.P);
            var keypressed_reset:Boolean = Input.pressed(Key.R);
            var keypressed_left:Boolean = Input.pressed(Key.LEFT);
            var keypressed_right:Boolean = Input.pressed(Key.RIGHT);
            var keypressed_up:Boolean = Input.pressed(Key.UP);
            var keypressed_down:Boolean = Input.pressed(Key.DOWN);
            var keydown_shift:Boolean = Input.check(Key.SHIFT);

            if (keypressed_pause) {
                if (state == STATE_PAUSE)
                    state = STATE_MOVE;
                else
                    state = STATE_PAUSE;
            }

            if (keydown_shift)
                state = STATE_SHIFT;
            else
                state = STATE_MOVE;

            if (state == STATE_MOVE) {
                if (keypressed_up) {
                    selected_row -= 1;
                    if (selected_row < 0)
                        selected_row = MAX_ROWS - 1;
                }
                if (keypressed_down) {
                    selected_row += 1;
                    if (selected_row >= MAX_ROWS)
                        selected_row = 0;
                }
                if (keypressed_left) {
                    selected_col -= 1;
                    if (selected_col < 0)
                        selected_col = MAX_COLS - 1;
                }
                if (keypressed_right) {
                    selected_col += 1;
                    if (selected_col >= MAX_COLS)
                        selected_col = 0;
                }
            }
            else if (state == STATE_SHIFT) {
                if (keypressed_up)
                    shift_column(selected_col, -1);
                if (keypressed_down)
                    shift_column(selected_col, 1);
                if (keypressed_left)
                    shift_row(selected_row, -1);
                if (keypressed_right)
                    shift_row(selected_row, 1);
            }

            if (keypressed_reset) {
                FP.world = new ResetHelper(this);
                return;
            }

            if (state != STATE_PAUSE)
                super.update();
        }

        override public function render():void {
            var accent:uint;
            var color:uint;

            // Background
            Draw.rect(OFFSET_X - 32, OFFSET_Y - 32, BOARD_WIDTH + 64, BOARD_HEIGHT + 64, 0x000000);

            // Indicator
            if (state == STATE_MOVE) {
                color = 0x393939;
                accent = 0x368094;
            }
            else {
                color = 0xF28500;
                accent = 0xFFC42D;
            }

            var x:Number = selected_col * Tile.WIDTH  + selected_col + OFFSET_X - 1;
            var y:Number = selected_row * Tile.HEIGHT + selected_row + OFFSET_Y - 1;
            
            Draw.rect(x, OFFSET_Y - 1, Tile.WIDTH + 2, BOARD_HEIGHT + 1, color);
            Draw.rect(OFFSET_X - 1, y, BOARD_WIDTH + 1, Tile.HEIGHT + 2, color);
            Draw.rect(x, y, Tile.WIDTH + 2, Tile.HEIGHT + 2, accent);

            if (state == STATE_SHIFT) {
                var tiles:Array = new Array();
                getType('tile', tiles);
                for each(tile in tiles) {
                    if (!tile.movable && (tile.row == selected_row || tile.column == selected_col))
                        Draw.rect(tile.column * Tile.WIDTH + tile.column + OFFSET_X - 1,
                                  tile.row * Tile.HEIGHT + tile.row + OFFSET_Y - 1, 
                                  Tile.WIDTH + 2, Tile.HEIGHT + 2, 0xFF0000);
                }
            }

            // Objects
            super.render();
            
            // HUD - Timer
            var i:int;
            
            const HUD_WIDTH:Number = FP.width - BOARD_WIDTH - 128;

            for (i = 1; i <= Actor.WAIT_TIME + 1; i += Actor.WAIT_TIME / 5) {
                if ((i > warrior.move_timer || warrior.move_timer < 15))
                    color = 0xFFFFFF;
                else
                    color = 0xF28500;

                x = (i / Actor.WAIT_TIME) * HUD_WIDTH;

                Draw.rect(x + 32, FP.height - 40, 8, 8, color);
            }

            // HUD - Health
            for (i = 0; i < warrior.max_health; i++) {
                if (i >= warrior.health)
                    color = 0x880000;
                else
                    color = 0xFF0000;

                if (i < 10) {
                    x = i * 16 + 32;
                    y = 32;
                }
                else {
                    x = (i - 10) * 16 + 32;
                    y = 48;
                }
                Draw.rect(x, y, 12, 12, color);
            }

            // HUD - Experience
            Draw.text("POW      " + warrior.attack, 32, 72, Config.font_style);
            Draw.text("EXP      " + warrior.exp, 32, 86, Config.font_style);
            Draw.text("NEXT     " + warrior.exp_required, 32, 100, Config.font_style);

            // HUD - Enemy Info
            var tile:Tile = get_tile(selected_col, selected_row);
            var ey:Number = FP.height - 164;
            if (tile && tile.contents) {
                if (tile.contents.type == 'enemy') {
                    var enemy:Enemy = tile.contents as Enemy;
                    Draw.text(enemy.tag, 32, ey, Config.font_style); 

                    for (i = 0; i < enemy.max_health; i++) {
                        if (i >= enemy.health)
                            color = 0x880000;
                        else
                            color = 0xFF0000;

                        if (i < 10) {
                            x = i * 16 + 32;
                            y = ey + 22;
                        }
                        else {
                            x = (i - 10) * 16 + 32;
                            y = ey + 38;
                        }
                        Draw.rect(x, y, 12, 12, color);
                    }
                    Draw.text("POW      " + enemy.attack, 32, ey + 62, Config.font_style);
                    Draw.text("EXP      " + enemy.experience_points, 32, ey + 76, Config.font_style);
                }
                else if (tile.contents.type == 'heart') {
                    var heart:Heart = tile.contents as Heart;
                    Draw.text("Heart", 32, ey, Config.font_style);
                    Draw.text("Restore HP", 32, ey + 22, Config.font_style);
                }
                else if (tile.contents.type == 'stairs') {
                    var stairs:StairsDown = tile.contents as StairsDown;
                    var enemy_count:int = typeCount("enemy");
                    if (enemy_count > 1) {
                        Draw.text("Stairs [Locked]", 32, ey, Config.font_style);
                        Draw.text(enemy_count + " enemies left", 32, ey + 22, Config.font_style);
                    }
                    else if (enemy_count == 1) {
                        Draw.text("Stairs [Locked]", 32, ey, Config.font_style);
                        Draw.text("1 enemy left\n", 32, ey + 22, Config.font_style);
                    }
                    else {
                        Draw.text("Stairs Down", 32, ey, Config.font_style);
                        Draw.text("Floor Complete!", 32, ey + 22, Config.font_style);
                    }
                }
            }
        }

        private function create_tiles():void {
            for (var row:Number = 0; row < MAX_ROWS; row++) {
                for (var col:Number = 0; col < MAX_COLS; col++) {
                    var tile:Tile = new Tile(row, col, true);
                    add(tile);
                }
            }
        }
    }
}

package
{
    import net.flashpunk.graphics.Spritemap;

    public class Goblin extends Enemy {
        
        public function Goblin(row:int, column:int) {
            super(row, column);
            tag = 'Goblin';
            max_health = 3;
            attack = 1;
            experience_points = 3;
            health = max_health;
            
            sprite = new Spritemap(Config.SPRITES, 32, 32);
            sprite.add("IDLE", [4]);
            sprite.play("IDLE");
            graphic = sprite;
        }
    }
}


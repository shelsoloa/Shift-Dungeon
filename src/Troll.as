package
{
    import net.flashpunk.graphics.Spritemap;

    public class Troll extends Enemy {
    
        public function Troll(row:int, column:int) {
            super(row, column);
            tag = 'Troll';
            max_health = 12;
            attack = 4;
            experience_points = 8;
            health = max_health;

            sprite = new Spritemap(Config.SPRITES, 32, 32);
            sprite.add("IDLE", [6]);
            sprite.play("IDLE");
            graphic = sprite;
        }
    }
}

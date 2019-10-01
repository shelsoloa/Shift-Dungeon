package
{
    import net.flashpunk.graphics.Spritemap;

    public class Skeleton extends Enemy {

        public function Skeleton(row:int, column:int) {
            super(row, column);
            tag = 'Skeleton';
            max_health = 5;
            attack = 2;
            experience_points = 5;
            health = max_health;

            sprite = new Spritemap(Config.SPRITES, 32, 32);
            sprite.add("IDLE", [5]);
            sprite.play("IDLE");
            graphic = sprite;
        }
    }
}

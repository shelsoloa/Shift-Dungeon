package
{
    import net.flashpunk.graphics.Spritemap;

    public class Dragon extends Enemy {
    
        public function Dragon(row:int, column:int) {
            super(row, column);
            tag = 'Dragon';
            max_health = 20;
            attack = 5;
            experience_points = 16;
            health = max_health;

            sprite = new Spritemap(Config.SPRITES, 32, 32);
            sprite.add("IDLE", [7]);
            sprite.play("IDLE");
            graphic = sprite;
        }
		
		override public function update():void { }
    }
}

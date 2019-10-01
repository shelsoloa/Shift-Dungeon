package
{
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;

    public class Heart extends Actor {

        public function Heart(row:int, column:int) {
            super();
            type = 'heart';
            move_to(row, column);

            sprite = new Spritemap(Config.SPRITES, 32, 32);
            sprite.add("IDLE", [8]);
            sprite.play("IDLE");
            graphic = sprite;
        }

        public function consume():void {
            current_tile.contents = null;
            FP.world.remove(this);
        }
    }
}

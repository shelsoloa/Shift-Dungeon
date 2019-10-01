package
{
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    public class GameOver extends World {
        public function GameOver() {
            super();
        }

        override public function update():void {
            if (Input.pressed(Key.ANY))
                FP.world = new FirstFloor();
            // TODO reset or back to start
        }
    }
}

package
{
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.utils.Draw;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    public class MainMenu extends World {

        private const PLAY:int = 0;
        private const HELP:int = 1;
        private const SELECTIONS:Array = ["PLAY", "HELP"];
        private var selection:int = 0;

        public function MainMenu() {
            super();
        }

        override public function render():void {
            var selection:String = '';
            for (var i:int = 0; i < SELECTIONS.length; i++) {
                Draw.text(SELECTIONS[i], 32, i * 32 + 32, Config.font_style);
            }
        }

        override public function update():void {
            if (Input.pressed(Key.UP)) {
                selection -= 1
                if (selection < 0)
                    selection = 0;
            }
            if (Input.pressed(Key.DOWN)) {
                selection += 1;
                if (selection >= SELECTIONS.length)
                    selection = SELECTIONS.length - 1;
            }
            if (Input.pressed(Key.ENTER)) {
                if (selection == PLAY)
                    FP.world = new FirstFloor();
            }
        }
    }
}

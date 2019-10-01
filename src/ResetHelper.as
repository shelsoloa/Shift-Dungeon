package
{
    import net.flashpunk.FP;
    import net.flashpunk.World;

    public class ResetHelper extends World {
    
        private var dungeon:Dungeon = null;
        
        public function ResetHelper(dungeon:Dungeon) {
            this.dungeon = dungeon;
            this.dungeon.reset();
        }
        
        override public function update():void {
            FP.world = dungeon;
        }
    }
}

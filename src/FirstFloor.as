package
{
    import net.flashpunk.FP;
    
    public class FirstFloor extends Dungeon {

        public function FirstFloor() {
            super(new Warrior);
        }

        override public function begin():void {
            get_tile(5, 1).solid = false;
            get_tile(5, 2).solid = false;
            get_tile(5, 3).solid = false;
            get_tile(5, 4).solid = false;
            get_tile(6, 5).solid = false;
            get_tile(5, 6).solid = false;
            get_tile(5, 7).solid = false;
            get_tile(5, 8).solid = false;
            get_tile(5, 9).solid = false;

            warrior.move_to(5, 1);
            
            add(new Goblin(5, 6));
            add(new StairsDown(5, 9));
        }

        override public function advance():void {
            remove(warrior);
            FP.world = new SecondFloor(warrior);
        }
    }
}

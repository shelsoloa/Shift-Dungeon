package
{
    import net.flashpunk.FP;
    
    public class SecondFloor extends Dungeon {

        public function SecondFloor(warrior:Warrior) {
            super(warrior);
        }

        override public function begin():void {
            get_tile(1, 4).solid = false;
            get_tile(2, 4).solid = false;
            // get_tile(3, 3).solid = false;
            get_tile(4, 3).solid = false;
            get_tile(5, 3).solid = false;
			get_tile(5, 4).solid = false;
            get_tile(6, 3).solid = false;
            // get_tile(7, 3).solid = false;
            get_tile(9, 4).solid = false;

            // get_tile(2, 4).solid = false;
            get_tile(2, 6).solid = false;
            get_tile(2, 7).solid = false;
            get_tile(2, 8).solid = false;

            get_tile(5, 5).solid = false;
            get_tile(5, 6).solid = false;
            get_tile(5, 7).solid = false;

            get_tile(8, 8).solid = false;
            get_tile(9, 7).solid = false;
            get_tile(9, 8).solid = false;

            warrior.move_to(1, 4);
            warrior.direction = Actor.WEST;

            add(new Goblin(2, 8));
            add(new Goblin(9, 8));
            add(new Skeleton(5, 7));
            add(new StairsDown(8, 8));
            add(new Heart(9, 4));
        }

        override public function advance():void {
            remove(warrior);
            FP.world = new ThirdFloor(warrior);
        }
    }
}

package
{
    public class FourthFloor extends Dungeon {
        public function FourthFloor(warrior:Warrior) {
            super(warrior);
        }

        override public function begin():void {
            get_tile(1, 2).solid = false;
            get_tile(1, 3).solid = false;
            get_tile(1, 4).solid = false;
            get_tile(2, 4).solid = false;
            get_tile(3, 4).solid = false;

            get_tile(3, 9).solid = false;

            get_tile(4, 1).solid = false;
            get_tile(4, 2).solid = false;
            get_tile(4, 6).solid = false;
            get_tile(4, 7).solid = false;
            get_tile(4, 8).solid = false;

            get_tile(5, 0).solid = false;
            get_tile(5, 1).solid = false;
            get_tile(5, 2).solid = false;
            get_tile(5, 6).solid = false;
            get_tile(5, 8).solid = false;
            get_tile(5, 10).solid = false;

            get_tile(6, 1).solid = false;
            get_tile(6, 2).solid = false;
            get_tile(6, 6).solid = false;
            get_tile(6, 7).solid = false;
            get_tile(6, 8).solid = false;

            get_tile(7, 4).solid = false;
            get_tile(7, 9).solid = false;

            get_tile(8, 4).solid = false;

            get_tile(9, 2).solid = false;
            get_tile(9, 3).solid = false;
            get_tile(9, 4).solid = false;

            warrior.move_to(5, 10);
			

            add(new Heart(5, 0));
            add(new Skeleton(4, 8));
			var g:Goblin = new Goblin(6, 6);
			g.direction = Actor.NORTH;
            add(g);
            add(new Troll(3, 4));
            add(new Troll(9, 2));
            add(new Dragon(5, 1));
        }
    }
}

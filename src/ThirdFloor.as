package
{
    import net.flashpunk.FP;
    
    public class ThirdFloor extends Dungeon {
        public function ThirdFloor(warrior:Warrior) {
            super(warrior);
        }

        override public function begin():void {
            get_tile(2, 5).solid = false;
            get_tile(3, 3).solid = false;
            get_tile(3, 7).solid = false;
            get_tile(5, 2).solid = false;
            get_tile(5, 5).solid = false;
            get_tile(5, 8).solid = false;
            get_tile(6, 9).solid = false;
            get_tile(7, 3).solid = false;
            get_tile(7, 7).solid = false;
            get_tile(8, 5).solid = false;
            
            warrior.move_to(5, 5);

            add(new Heart(5, 2));
            add(new Goblin(7, 3));
            add(new Troll(2, 5));
            add(new Skeleton(5, 8));
            add(new Skeleton(8, 5));
            add(new StairsDown(6, 9));
        }
        
        override public function advance():void {
            remove(warrior);
            FP.world = new FourthFloor(warrior);
        }
    }
}

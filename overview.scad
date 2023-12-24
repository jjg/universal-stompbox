/*

    breadboard dimensions (incl. extension tabs)
    length: 85
    width: 56
    height: 9.6
    
    TODO: Adafruit perma-proto dimensions
    length:
    width:
    height:
    mounting holes
    
    TODO: potentiometer dimensions
    TODO: 1/4" jack dimensions
    TODO: power jack dimensions
    TODO: knob dimensions
    TODO: footswitch dimensions
    
    overall pedal dimensions
    length: 127 // 5 inches
    width: 76   // 3 inches
    height: 80  // ??? inches
    
*/
OVERALL_LENGTH = 130;
OVERALL_HEIGHT = 80;

WALL_THICKNESS = 3;

PHONE_JACK_OPENING = 5; // a guess
POWER_JACK_OPENING = 3; // a guess
BREADBOARD_LENGTH = 85;

module breadboard(){
    L = 85;
    W = 56;
    H = 9.6;
    cube([L, W, H]);
}

module knob(){
    D = 10; // a guess
    cylinder(r=D/2,h=10);
}

module base(){
    
    L = OVERALL_LENGTH;
    W = 80;
    H = OVERALL_HEIGHT * .5;  // half the overall height, might need to go lower
    
    difference(){
        cube([L,W,H]);
        
        // carve-out for breadboard, power supply
        translate([WALL_THICKNESS,WALL_THICKNESS,WALL_THICKNESS]){
            cube([L-(WALL_THICKNESS*2), W-(WALL_THICKNESS*2), H]);
        }
    }
}

module control_panel(){
    L = OVERALL_LENGTH * .25;  // one-quarter overall lenght, might change
    W = 80;
    H = OVERALL_HEIGHT * .5;    // the other half of the height
    
    difference(){
        cube([L,W,H]);
        
        // TODO: cutout for pots
        translate([WALL_THICKNESS,WALL_THICKNESS,-1]){
            cube([L,W-(WALL_THICKNESS*2),H-WALL_THICKNESS+1]);
        }
        // TODO: cutouts for pot shafts
    } 
}


// preview
base();

translate([OVERALL_LENGTH-BREADBOARD_LENGTH-WALL_THICKNESS,0,WALL_THICKNESS]){
    breadboard();
}

translate([0,0,OVERALL_HEIGHT*.5]){
    control_panel();
}
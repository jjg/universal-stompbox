/*

    breadboard dimensions (incl. extension tabs)
    length: 85
    width: 56
    height: 9.6
    
    TODO: measure actual potentiometer dimensions
    TODO: measure actual 1/4" jack dimensions
    TODO: measure actual power jack dimensions
    TODO: measure actual knob dimensions
    TODO: measure actual footswitch dimensions
    
    starting point for overall pedal dimensions
    length: 127 // 5 inches
    width: 76   // 3 inches
    height: 80  // ??? inches
    
*/

OVERALL_LENGTH = 130;
OVERALL_WIDTH = 80;
OVERALL_HEIGHT = 60; // 80;

WALL_THICKNESS = 3;

PHONE_JACK_OPENING = 10;        // a guess
POWER_JACK_OPENING = 5;         // a guess
POT_SHAFT_DIAMETER = 10;        // a guess
FOOTSWITCH_SHAFT_DIAMETER = 10; // a guess
KNOB_DIAMETER = 15;             // a guess
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

// TODO: base needs some kind of attachment to cover, control panel
module base(){
    
    L = OVERALL_LENGTH;
    W = OVERALL_WIDTH;
    H = OVERALL_HEIGHT - OVERALL_HEIGHT *.3;  // 2/3 the overall height, might need to go lower
    
    difference(){
        cube([L,W,H]);
        
        // carve-out for breadboard, power supply
        translate([WALL_THICKNESS,WALL_THICKNESS,WALL_THICKNESS]){
            cube([L-(WALL_THICKNESS*2), W-(WALL_THICKNESS*2), H]);
        }
        
        // cutout for phone, power jacks
        // TODO: this spacing needs to accomodate actual
        // jack body dimensions
        translate([-WALL_THICKNESS/2,W/4,H/2]){
            rotate([0,90,0]){
                cylinder(r=PHONE_JACK_OPENING/2,h=WALL_THICKNESS*2);
            }
        }
        translate([-WALL_THICKNESS/2,W-(W/4),H/2]){
            rotate([0,90,0]){
                cylinder(r=PHONE_JACK_OPENING/2,h=WALL_THICKNESS*2);
            }
        }
        translate([-WALL_THICKNESS/2,W/2,H/2]){
            rotate([0,90,0]){
                cylinder(r=POWER_JACK_OPENING/2,h=WALL_THICKNESS*2);
            }
        }
    }
}

// TODO: control panel needs some kind of attachment to base
module control_panel(){
    L = OVERALL_LENGTH * .3;    // one-third overall length, might change
    W = OVERALL_WIDTH;
    H = OVERALL_HEIGHT * .3;    // the other third of the height
    
    difference(){
        cube([L,W,H]);
        
        // cutout for pots
        translate([WALL_THICKNESS,WALL_THICKNESS,-1]){
            cube([L,W-(WALL_THICKNESS*2),H-WALL_THICKNESS+1]);
        }
        
        // cutouts for pot shafts
        // TODO: make number of pots dynamic
        // TODO: this spacing needs to accomodate knob diameter &
        // potentiometer body diameter (whichever is greater)
        translate([L/2,W/3-(KNOB_DIAMETER/2),H-WALL_THICKNESS-1]){
            cylinder(r=FOOTSWITCH_SHAFT_DIAMETER/2,h=WALL_THICKNESS*2);
        }
        translate([L/2,W/2,H-WALL_THICKNESS-1]){
            cylinder(r=FOOTSWITCH_SHAFT_DIAMETER/2,h=WALL_THICKNESS*2);
        }
        translate([L/2,(W-W/3)+(KNOB_DIAMETER/2),H-WALL_THICKNESS-1]){
            cylinder(r=FOOTSWITCH_SHAFT_DIAMETER/2,h=WALL_THICKNESS*2);
        }
        
        // TODO: cutout(s) for LED(s) or other indicators
    } 
}

// TODO: cover needs some kind of attachment to base
// TODO: might be cool to angle the cover a bit toward the foot
module cover(){
    L = OVERALL_LENGTH - (OVERALL_LENGTH * .3);
    W = OVERALL_WIDTH;
    H = OVERALL_HEIGHT * .3;    // other half of the height

    difference(){
        cube([L,W,H]);
        
        // cutout
        translate([-1,WALL_THICKNESS,-1]){
            cube([L-(WALL_THICKNESS)+1,W-(WALL_THICKNESS*2),H-WALL_THICKNESS+1]);
        }
        
        // cutout for footswitch
        translate([L/2,W/2,H-WALL_THICKNESS-1]){
            cylinder(r=FOOTSWITCH_SHAFT_DIAMETER/2,h=WALL_THICKNESS*2);
        }
    }
}

// preview
EXPLODE = 1.25;

base();

translate([OVERALL_LENGTH-BREADBOARD_LENGTH-WALL_THICKNESS,0,WALL_THICKNESS]){
    breadboard();
}

translate([0,0,(OVERALL_HEIGHT - (OVERALL_HEIGHT*.3))*EXPLODE]){
    control_panel();
}

translate([OVERALL_LENGTH*.5,0,(OVERALL_HEIGHT - (OVERALL_HEIGHT*.3))*EXPLODE]){
    cover();
}
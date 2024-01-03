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
VERSION = "V.04";

OVERALL_LENGTH = 130;
OVERALL_WIDTH = 80;
OVERALL_HEIGHT = 40; //60; // 80;
EXTRA_BASE = 12;                // temporary

WALL_THICKNESS = 3;
TOLERANCE = 1;

PHONE_JACK_OPENING = 9.5;        // 9.53 actual
POWER_JACK_OPENING = 8;
POT_BODY_DIAMETER = 25;
POT_SHAFT_DIAMETER = 6.5;
SWITCH_SHAFT_DIAMETER = 5;
FOOTSWITCH_SHAFT_DIAMETER = 12;
LED_DIAMETER = 5.5;
BREADBOARD_LENGTH = 85;

// knobs
KNOB_DIAMETER = 15;
KNOB_HEIGHT = 16.5;
KNOB_HOLE_DIAMETER = 6;

module breadboard(){
    L = 85;
    W = 56;
    H = 9.6;
    cube([L, W, H]);
}

module knob(knurls=5,position=-1,topper=false){
    difference(){
        union(){
            hull(){
                cylinder(r=KNOB_DIAMETER/2,h=KNOB_HEIGHT);
                
                // positive position indicator
                if(position > 0){
                    rotate([0,0,(360/knurls)*1.5]){
                        translate([KNOB_DIAMETER/2.5,-0.25,0]){
                            cube([4,0.5,KNOB_HEIGHT]);
                        }
                    }
                }
                
                // topper
                if(topper){
                    translate([0,0,KNOB_HEIGHT]){
                        sphere(r=KNOB_DIAMETER/2);
                    }
                }
            }
            
        }
        translate([0,0,-WALL_THICKNESS]){
            
            // pot post opening
            cylinder(r=KNOB_HOLE_DIAMETER/2,h=KNOB_HEIGHT);
            
            // knurls
            for(i=[1:knurls]){
                rotate([0,0,(360/knurls)*i]){
                    translate([KNOB_DIAMETER/1.5,0,WALL_THICKNESS*2]){
                        cylinder(r=KNOB_DIAMETER/4,h=KNOB_HEIGHT+WALL_THICKNESS);
                    }
                }
            }
            
            // negative position indicator
            if(position < 0){
                rotate([0,0,(360/knurls)*1.5]){
                    translate([KNOB_DIAMETER/3,-0.5,WALL_THICKNESS*2]){
                        cube([4,1,KNOB_HEIGHT]);
                    }
                }
            }
        }
    }
}

// TODO: base needs some kind of attachment to cover
// TODO: Add something to hold 9v in place
module base(){
    
    L = OVERALL_LENGTH;
    W = OVERALL_WIDTH;
    H = OVERALL_HEIGHT - OVERALL_HEIGHT *.3;  // 2/3 the overall height, might need to go lower
    
    difference(){
        union(){
            
            cube([L,W,H]);
            
            // TODO: integrate this temporary addition into the parametric model
            translate([0,0,-EXTRA_BASE]){
                cube([L,W,EXTRA_BASE]);
            }
            
            // incorporate control panel
            translate([0,0,OVERALL_HEIGHT - (OVERALL_HEIGHT*.3)]){
                control_panel();
            }            
        }
        
        // carve-out for breadboard, power supply
        translate([WALL_THICKNESS,WALL_THICKNESS,WALL_THICKNESS]){
            //cube([L-(WALL_THICKNESS*2), W-(WALL_THICKNESS*2), H]);
            
            // TODO: integrate this temporary addition into the parameteric model
            translate([0,0,-EXTRA_BASE]){
                cube([L-(WALL_THICKNESS*2), W-(WALL_THICKNESS*2), H+EXTRA_BASE]);
            }
        }
        
        // cutout for cover
        translate([(L*.3)-8,0,H*.3+3]){
            rotate([0,15,0]){
                cover();
            }
        }
        // TODO: this is kind of jacked-up and will break if sized
        translate([L*.5,0,H*.59]){
            cube([L,W,H]);
        }
        
        // cutout for phone, power jacks
        // TODO: this spacing needs to accomodate actual
        // jack body dimensions
        translate([L*.15,WALL_THICKNESS+1,H*.6]){
            rotate([90,0,0]){
                cylinder(r=(PHONE_JACK_OPENING+TOLERANCE)/2,h=WALL_THICKNESS*2);
            }
        }
        translate([L*.15,W+1,H*.6]){
            rotate([90,0,0]){
                cylinder(r=(PHONE_JACK_OPENING+TOLERANCE)/2,h=WALL_THICKNESS*2);
            }
        }
        translate([-WALL_THICKNESS/2,W/2,H*.6]){
            rotate([0,90,0]){
                cylinder(r=(POWER_JACK_OPENING+TOLERANCE)/2,h=WALL_THICKNESS*2);
            }
        }
        
        // stamp with version
        translate([L-1,WALL_THICKNESS,WALL_THICKNESS]){
            rotate([90,0,90]){
                linear_extrude(2){
                    text(VERSION);
                }
            }
        }
    }
}

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
        // TODO: make number of pots dynamic (maybe widen box if needed...)
        translate([L/2,W/3-(POT_BODY_DIAMETER/2),H-WALL_THICKNESS-1]){
            cylinder(r=(POT_SHAFT_DIAMETER+TOLERANCE)/2,h=WALL_THICKNESS*2);
        }
        translate([L/2,W/2,H-WALL_THICKNESS-1]){
            cylinder(r=(SWITCH_SHAFT_DIAMETER+TOLERANCE)/2,h=WALL_THICKNESS*2);
        }
        translate([L/2,(W-W/3)+(POT_BODY_DIAMETER/2),H-WALL_THICKNESS-1]){
            cylinder(r=(POT_SHAFT_DIAMETER+TOLERANCE)/2,h=WALL_THICKNESS*2);
        }
        
        // cutouts for LEDs, etc.
        translate([WALL_THICKNESS*2+TOLERANCE,W*.33,H-WALL_THICKNESS-1]){
            cylinder(r=(LED_DIAMETER)/2,h=WALL_THICKNESS*2);
        }
    } 
}

// TODO: cover needs some kind of attachment to base
module cover(){
    L = OVERALL_LENGTH - (OVERALL_LENGTH * .3);
    W = OVERALL_WIDTH;
    H = OVERALL_HEIGHT * .75;    // other 3/4 of the height

    difference(){
        cube([L,W,H]);
        
        // hollow
        translate([-1,WALL_THICKNESS,-1]){
            cube([L-(WALL_THICKNESS)+1,W-(WALL_THICKNESS*2),H-WALL_THICKNESS+1]);
        }
        
        // cut angle
        translate([0,-1,-H]){
            rotate([0,-15,0]){
                cube([L*1.25,W+2,H]);
            }
        }
        
        // cutout for footswitch
        translate([L/2,W/2,H-WALL_THICKNESS-1]){
            cylinder(r=(FOOTSWITCH_SHAFT_DIAMETER+TOLERANCE)/2,h=WALL_THICKNESS*2);
        }
    }
    
    // tabs to keep cover locked in y dimension
    translate([0,WALL_THICKNESS,1.05]){
        cube([10,WALL_THICKNESS,5]);
    }
    translate([0,W-WALL_THICKNESS*2,1.05]){
        cube([10,WALL_THICKNESS,10]);
    }
    translate([L-10-WALL_THICKNESS,WALL_THICKNESS,H-5-WALL_THICKNESS]){
        cube([10,WALL_THICKNESS,5]);
    }
    translate([L-10-WALL_THICKNESS,W-WALL_THICKNESS*2,H-5-WALL_THICKNESS]){
        cube([10,WALL_THICKNESS,5]);
    }
}

// preview
$fn=50;

EXPLODE = 3;//1.25;

color("lime")
base();

translate([OVERALL_LENGTH-BREADBOARD_LENGTH-WALL_THICKNESS-1,WALL_THICKNESS+1,WALL_THICKNESS]){
    //breadboard();
}

color("purple")
translate([((OVERALL_LENGTH*.3)-8)*(EXPLODE*.5),0,((OVERALL_HEIGHT *.3)-1)*EXPLODE]){
    rotate([0,15,0]){
        cover();
    }
}

color("purple")
translate([(OVERALL_LENGTH * .3/2),OVERALL_WIDTH/3-(POT_BODY_DIAMETER/2),OVERALL_HEIGHT+EXPLODE]){
    knob(knurls=5,position=-1,topper=false);
}
color("purple")
translate([(OVERALL_LENGTH * .3)/2,OVERALL_WIDTH-(OVERALL_WIDTH/3-(POT_BODY_DIAMETER/2)),OVERALL_HEIGHT+EXPLODE]){
    knob(knurls=5,position=-1,topper=false);
}

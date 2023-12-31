# Universal Stompbox
Any pedal you can think of.

![preview render of stompbox parts](images/overview_render_v4.png)

I got this idea while reading [Electronics Projects for Musicians](https://archive.org/details/electronicprojec0000ande).  There's a lot of cool projects in there, but like most guitarists you want something that has a sound that suits you, and I wasn't sure about building these whole projects without being able to try them out a bit.

I thought about breadboarding the circuits to try them out, but it's hard to hook-up an instrument to a bunch of parts on the bench and give it a workout under normal playing conditions.  I like to try different amps, rooms, etc.

Then the idea came to keep the pedal form-factor but make replacing the electronics easier by replacing the circuit board with a breadboard.  Not only does this make changing the pedal completely possible, it makes tweaking the design "in-situ" simple.

I also chose a breadboard size that exactly matches the [Adafruit perma-proto](https://www.adafruit.com/product/571) so it can also be used for permanent designs if so desired.

Additional details about this project can be found in this [blog post](https://jasongullickson.com/universal-stompbox.html)

## Minerals
* 3PDT footswitch ([Amazon](https://www.amazon.com/ESUPPORT-Guitar-Effect-Switch-Bypass/dp/B012CF181K/ref=sr_1_3?crid=3OFZ0CN4QBI8L&keywords=true%2Bbypass%2Bfootswitch&qid=1704382921&sprefix=true%2Bbypass%2Bfootswitch%2Caps%2C122&sr=8-3&th=1)
* Potentiometers (BK10, 24mm x 17mm x 25mm) ([Adafruit](https://www.adafruit.com/product/562))
* 5mm LED ([Adafruit](https://www.adafruit.com/product/4203))
* Phone jacks ([Amazon](https://www.amazon.com/6-35mm-Female-Microphone-Connector-Adapter/dp/B08MT66VPX/ref=sr_1_4?crid=277SYRYCNU1DJ&keywords=phone+jack+mono&qid=1704383187&sprefix=phone+jack+mono%2Caps%2C145&sr=8-4))
* Power jack ([Amazon](https://www.amazon.com/DIYhz-Socket-Female-Mounting-Connector/dp/B09W9SJ1B6/ref=sr_1_6?crid=1748WOZ1SW6FB&keywords=dc%2Bpower%2Bjack&qid=1704383393&s=industrial&sprefix=dc%2Bpower%2Bjack%2Cindustrial%2C152&sr=1-6&th=1))
* Breadboard ([Adafruit](https://www.adafruit.com/product/4539))
* Toggle switch ([Adafruit](https://www.adafruit.com/product/3221))

## Printing

Ready-to-print files can be found in the [stls](stls) directory.  If you want to customize things, the [OpenSCAD](https://openscad.org/) source is provided in [overview.scad](overview.scad) (be warned, it's a bit rough yet)

Parts are designed to print without support if placed in the vertical position like this:
![parts in vertical orientation in slicing software](images/usb_complete_slicing.png)

## Electronics

Currently all connections are made with point-to-point wiring to bring the input and control signals to the breadboard.  Eventually I'll design a circuit board for this to eliminate some of this wiring.

![photo of inside of pedal showing footswitch wiring](images/inside.jpeg)

The footswich is wired for [true bypass](https://www.coda-effects.com/2015/03/3pdt-and-true-bypass-wiring.html), leaving 3-4 connections leading to the breadboard for signal input and output (I say 3-4 because you could probably get away with a single ground).

## TODO

* Finish parametricness (some things will respond to parameter changes OK now, but there are exceptions)
* Add some way to more permanently attach the cover
* Fix some weird bugs (like the tiny lip just below the control panel)
* Clean-up the code for modularity, configurability
* Add something to hold breadboard in place
* Add a schematic for the footswitch wiring 
* Replace raw pushbutton with smaller internal button and turn cover into moving pedal piece


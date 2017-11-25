all: gen/boxmaker_thingiverse.scad

gen:
	mkdir -p gen

gen/boxmaker_thingiverse.scad: gen simple_box.scad boxmaker.scad
	cat simple_box.scad boxmaker.scad | sed -e '/^include/ d' > $@

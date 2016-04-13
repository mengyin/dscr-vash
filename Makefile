.PHONY:	all clean output plots paper

all:	output plots paper

clean:	
	cd plots && $(MAKE) clean

output:	
	cd code && $(MAKE)

plots:
	cd plots && $(MAKE)

paper:
	cd paper && $(MAKE)
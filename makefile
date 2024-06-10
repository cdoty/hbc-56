# Set the name of the output ROM.
name		= Test

# Set the output file extension. Some emulators look for specific extension.
extension	= o

# Set the console type, based on the directories in tms9918lib.
console		= HBC56

# Set the ROM and RAM start addresses
cseg		= FFFA-FFFF,8000-FFF9
dseg	 	= 0200-7EFF
zseg		= 20

# Set the tools path.
TOOLS_PATH	= ../../Tools

# Set the CATE compiler path. Bin and lib are expected to exist inside the directory.
CATE_PATH	= $(TOOLS_PATH)/Cate
BIN_PATH	= $(CATE_PATH)/bin
LIB_PATH	= $(CATE_PATH)/lib

# CATE/ASM8/Lib compile ID. (ie CATEXX.exe)
compileType	= 65

# Customize the processor type and the TMS-9918 interface type, if needed.
Shared_S	= $(wildcard SystemLib/6502/Decompression/*.s)
Shared_S	+= $(wildcard SystemLib/6502/Graphics/Graphics/*.s)
Shared_S	+= $(wildcard SystemLib/6502/Graphics/Sprite/*.s)
Shared_S	+= $(wildcard SystemLib/6502/Shared/*.s)
Shared_S	+= $(wildcard SystemLib/6502/Sound/AY38910/*.s)

System_S	= $(wildcard SystemLib/$(console)/crt0/Rom.s)
System_S	+= $(wildcard SystemLib/$(console)/*.s)
System_S	+= $(wildcard System/*.s)
Game_C		= $(wildcard Game/*.c)
Graphics_S	= $(wildcard Graphics/*.s)
Vectors_S	= $(wildcard SystemLib/$(console)/Vectors/Vectors.s)

system 		= $(System_S:.s=.obj)
vectors		= $(Vectors_S:.s=.obj)

objects 	= $(Shared_S:.s=.obj)
objects 	+= $(Game_C:.c=.obj)

graphics 	= $(Graphics_S:.s=.obj)

libs 		= $(LIB_PATH)/cate$(compileType).lib

lists 		= $(System_S:.s=.lst)
lists 		+= $(Shared_S:.s=.lst)
lists 		+= $(Game_C:.c=.lst)
lists 		+= $(Graphics_S:.s=.lst)

all: $(name).$(extension)

clean:
	rm -f $(system)
	rm -f $(vectors)
	rm -f $(objects)
	rm -f $(graphics)
	rm -f $(lists)
	rm -f $(name).$(extension)
	rm -f $(name).symbols.txt

%.asm: %.c
	$(BIN_PATH)/Cate$(compileType) $<

%.obj: %.asm
	$(BIN_PATH)/Asm$(compileType) $<
	
%.obj: %.s
	$(BIN_PATH)/Asm$(compileType) -65C02 $<
	
$(name).$(extension): $(vectors) $(system) $(objects) $(graphics)
	$(BIN_PATH)/LinkLE $(name).$(extension) $(cseg) $(dseg) $(zseg) $(vectors) $(system) $(objects) $(graphics) $(libs)

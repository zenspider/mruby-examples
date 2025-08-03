01_DIR=01_hello_world
02_DIR=02_hello_bytecode
03_DIR=03_hello_c_code
04_DIR=04_hello_classes
05_DIR=05_hello_embedded

BUILD_DIR=build

MRUBY=mruby
MRBC=mrbc
CC       = $(shell mruby-config --cc)
LD       = $(shell mruby-config --ld)
CFLAGS   = $(shell mruby-config --cflags)
LDFLAGS1 = $(shell mruby-config --ldflags-before-libs)
LIBS     = $(shell mruby-config --libs)
LDFLAGS2 = $(shell mruby-config --ldflags)

all: hello_world hello_bytecode hello_c_code hello_classes hello_embedded

clean:
	mkdir -p build
	rm -fr build/* \
		*/*.o \
		$(03_DIR)/hello_c_code_ruby.c \
		$(04_DIR)/fish_program.c \
		$(05_DIR)/hello_embedded_ruby.c

hello_world: clean $(01_DIR)/hello_world.c
	$(CC) -c $(01_DIR)/hello_world.c -o $(01_DIR)/hello_world.o $(CFLAGS)
	$(LD) -o $(BUILD_DIR)/hello_world $(01_DIR)/hello_world.o $(LDFLAGS1) $(LIBS) $(LDFLAGS2)
	$(BUILD_DIR)/hello_world

hello_bytecode: clean $(02_DIR)/hello_bytecode.rb
	$(MRBC)  -o $(BUILD_DIR)/hello_bytecode.mrb $(02_DIR)/hello_bytecode.rb
	$(MRUBY) -b $(BUILD_DIR)/hello_bytecode.mrb

hello_c_code: clean $(03_DIR)/hello_c_code.c $(03_DIR)/hello_c_code_ruby.rb
	$(MRBC) -B hello_c_code_ruby $(03_DIR)/hello_c_code_ruby.rb
	$(CC) -c $(03_DIR)/hello_c_code.c -o $(03_DIR)/hello_c_code.o $(CFLAGS)
	$(LD) -o $(BUILD_DIR)/hello_c_code $(03_DIR)/hello_c_code.o $(LDFLAGS1) $(LIBS) $(LDFLAGS2)
	$(BUILD_DIR)/hello_c_code

hello_classes: clean $(04_DIR)/hello_classes.c $(04_DIR)/fish_program.rb
	$(MRBC) -B fish_program $(04_DIR)/fish_program.rb
	$(CC) -c $(04_DIR)/hello_classes.c -o $(04_DIR)/hello_classes.o $(CFLAGS)
	$(LD) -o $(BUILD_DIR)/hello_classes $(04_DIR)/hello_classes.o $(LDFLAGS1) $(LIBS) $(LDFLAGS2)
	$(BUILD_DIR)/hello_classes

hello_embedded: clean $(05_DIR)/fake_led.c $(05_DIR)/hello_embedded_ruby.rb $(05_DIR)/hello_embedded.c
	$(MRBC) -B hello_embedded_ruby $(05_DIR)/hello_embedded_ruby.rb
	$(CC) -c $(05_DIR)/hello_embedded.c -o $(05_DIR)/hello_embedded.o $(CFLAGS)
	$(LD) -o $(BUILD_DIR)/hello_embedded $(05_DIR)/hello_embedded.o $(LDFLAGS1) $(LIBS) $(LDFLAGS2)
	$(BUILD_DIR)/hello_embedded

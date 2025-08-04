.SUFFIXES:
.SUFFIXES: .c .o .rb
.PHONY: Makefile

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

.PHONY: clean hello_world hello_bytecode hello_c_code hello_classes hello_embedded

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

### 01 hello world

$(BUILD_DIR)/hello_world: $(01_DIR)/hello_world.o
	$(LD) -o $(BUILD_DIR)/hello_world $(01_DIR)/hello_world.o $(LDFLAGS1) $(LIBS) $(LDFLAGS2)

hello_world: $(BUILD_DIR)/hello_world
	@$(BUILD_DIR)/hello_world

### 02 hello bytecode

$(BUILD_DIR)/hello_bytecode.mrb: $(02_DIR)/hello_bytecode.rb
	$(MRBC) -o $(BUILD_DIR)/hello_bytecode.mrb $(02_DIR)/hello_bytecode.rb

hello_bytecode: $(BUILD_DIR)/hello_bytecode.mrb
	@$(MRUBY) -b $(BUILD_DIR)/hello_bytecode.mrb

### 03 hello c code

$(03_DIR)/hello_c_code_ruby.c: $(03_DIR)/hello_c_code_ruby.rb
	$(MRBC) -B hello_c_code_ruby $(03_DIR)/hello_c_code_ruby.rb

$(03_DIR)/hello_c_code.o: $(03_DIR)/hello_c_code_ruby.c

$(BUILD_DIR)/hello_c_code: $(03_DIR)/hello_c_code.o
	$(LD) -o $(BUILD_DIR)/hello_c_code $(03_DIR)/hello_c_code.o $(LDFLAGS1) $(LIBS) $(LDFLAGS2)

hello_c_code: $(BUILD_DIR)/hello_c_code
	@$(BUILD_DIR)/hello_c_code

### 04 hello classes

$(04_DIR)/fish_program.c: $(04_DIR)/fish_program.rb
	$(MRBC) -B fish_program $(04_DIR)/fish_program.rb

$(04_DIR)/hello_classes.o: $(04_DIR)/fish_program.c

$(BUILD_DIR)/hello_classes: $(04_DIR)/hello_classes.o
	$(LD) -o $(BUILD_DIR)/hello_classes $(04_DIR)/hello_classes.o $(LDFLAGS1) $(LIBS) $(LDFLAGS2)

hello_classes: $(BUILD_DIR)/hello_classes
	@$(BUILD_DIR)/hello_classes

### 05 hello embedded

$(05_DIR)/hello_embedded_ruby.c: $(05_DIR)/hello_embedded_ruby.rb
	$(MRBC) -B hello_embedded_ruby $(05_DIR)/hello_embedded_ruby.rb

# fake_led.c isn't actually compiled, just #included
$(05_DIR)/hello_embedded.o: $(05_DIR)/hello_embedded_ruby.c $(05_DIR)/fake_led.c 

$(BUILD_DIR)/hello_embedded: $(05_DIR)/hello_embedded_ruby.c $(05_DIR)/hello_embedded.o
	$(LD) -o $(BUILD_DIR)/hello_embedded $(05_DIR)/hello_embedded.o $(LDFLAGS1) $(LIBS) $(LDFLAGS2)

hello_embedded: $(BUILD_DIR)/hello_embedded
	@$(BUILD_DIR)/hello_embedded

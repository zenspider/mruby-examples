import "mruby.rake"

task default: "hello_world"

task all: %w[ hello_world hello_bytecode hello_c_code hello_classes hello_embedded  hello_mruby ]

task :clean do
  rm_rf Dir["build/*",
            "*/*.o",
            "02_hello_bytecode/hello_bytecode.mrb",
            "03_hello_c_code/hello_c_code_ruby.c",
            "04_hello_classes/fish_program.c",
            "05_hello_embedded/hello_embedded_ruby.c"]
end

directory "build"

# ### 01 hello world

file "01_hello_world/hello_world.o"

file "build/hello_world": "01_hello_world/hello_world.o" do |t|
  link t.name, *t.sources
end

task hello_world: %w[ build build/hello_world ] do
  sh "./build/hello_world"
end

### 02 hello bytecode

task :hello_bytecode => "02_hello_bytecode/hello_bytecode.mrb" do
  sh "mruby", "-b", "02_hello_bytecode/hello_bytecode.mrb"
end

### 03 hello c code

file "03_hello_c_code/hello_c_code.o" => "03_hello_c_code/hello_c_code_ruby.c"

file "build/hello_c_code" => "03_hello_c_code/hello_c_code.o" do |t|
  link t.name, *t.sources
end

task hello_c_code: %w[ build build/hello_c_code ] do
  sh "./build/hello_c_code"
end

### 04 hello classes

file "04_hello_classes/hello_classes.o" => "04_hello_classes/fish_program.c"

file "build/hello_classes" => "04_hello_classes/hello_classes.o" do |t|
  link t.name, *t.sources
end

task hello_classes: %w[ build build/hello_classes ] do
  sh "./build/hello_classes"
end

### 05 hello embedded

# fake_led.c isn't actually compiled, just #included
file "build/hello_embedded" => %w[ 05_hello_embedded/hello_embedded_ruby.c 05_hello_embedded/fake_led.c 05_hello_embedded/hello_embedded.o ] do |t|
  link t.name, "05_hello_embedded/hello_embedded.o"
end

task hello_embedded: %w[ build build/hello_embedded ] do
  sh "./build/hello_embedded"
end

### 06 hello mruby

# TODO: why do I need to draw this dependency? should be wired up??
file "06_hello_mruby/hello_mruby.o" => "06_hello_mruby/hello_mruby.c"

file "build/hello_mruby": "06_hello_mruby/hello_mruby.o" do |t|
  link t.name, *t.sources
end

task hello_mruby: %w[ build build/hello_mruby ] do
  sh "./build/hello_mruby 06_hello_mruby/main.rb"
end

task hello_bin: %w[ build ] do
  abort "not yet"
end

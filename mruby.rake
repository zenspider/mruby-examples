require "shellwords"

module Rake::DSL
  def link(out, *sources) = sh ld, "-o", out, *sources, *ldflags1, *libs, *ldflags2
end

rule '.o' => '.c' do |t|
  sh cc, '-c', *cflags, t.source, '-o', t.name
end

rule '.c' => '.rb' do |t|
  sh "mrbc", '-B', File.basename(t.source, ".rb"), '-o', t.name, t.source
end

rule '.mrb' => '.rb' do |t|
  sh "mrbc", '-o', t.name, t.source
end

def cc       = @cc       ||= `mruby-config --cc`.chomp
def ld       = @ld       ||= `mruby-config --ld`.chomp
def cflags   = @cflags   ||= `mruby-config --cflags`.chomp.shellsplit
def ldflags1 = @ldflags1 ||= `mruby-config --ldflags-before-libs`.chomp.shellsplit
def libs     = @libs     ||= `mruby-config --libs`.chomp.shellsplit
def ldflags2 = @ldflags2 ||= `mruby-config --ldflags`.chomp.shellsplit

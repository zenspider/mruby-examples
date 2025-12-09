MRuby::Gem::Specification.new('mruby-hello') do |spec|
  spec.author   = 'Ryan Davis <ryand-mruby@zenspider.com>'
  spec.license  = 'MIT'
  spec.summary  = 'Hello World binary gem example'
  spec.homepage = 'https://github.com/zenspider/mruby-examples'
  spec.bins     = %w(mruby-hello)

  # MRuby::Gem::Specification.new('mruby-bin-example') do |spec|
  #   spec.license = 'MIT'
  #   spec.author  = 'mruby developers'
  #   spec.summary = 'Example for executable command gem'
  #   spec.bins = %w(mruby-example)    # <- this is binary name
  # end

  # spec.build.defines << 'MRB_USE_BIGINT'
  # spec.build.linker.libraries << 'gmp' # when uses libgmp

  # spec.build.libmruby_core_objs << Dir.glob(File.join(__dir__, 'core/**/*.c')).map { |fn|
  #   objfile(fn.relative_path_from(__dir__).pathmap("#{spec.build_dir}/%X"))
  # }

  # spec.add_dependency 'mruby-enum-ext',    core: 'mruby-enum-ext'
  # spec.add_dependency 'mruby-enumerator',  core: 'mruby-enumerator'
  # spec.add_dependency 'mruby-eval',        core: 'mruby-eval'
  # spec.add_dependency 'mruby-exit',        core: 'mruby-exit'
  # spec.add_dependency 'mruby-hash-ext',    core: 'mruby-hash-ext'
  # spec.add_dependency 'mruby-io',          core: 'mruby-io'
  # spec.add_dependency 'mruby-kernel-ext',  core: 'mruby-kernel-ext'
  # spec.add_dependency 'mruby-object-ext',  core: 'mruby-object-ext'
  # spec.add_dependency 'mruby-print',       core: 'mruby-print'
  # spec.add_dependency 'mruby-struct',      core: 'mruby-struct'
  # spec.add_dependency 'mruby-symbol-ext',  core: 'mruby-symbol-ext'
  #
  # spec.add_dependency 'mruby-at_exit',     mgem: 'mruby-at_exit'
  # spec.add_dependency 'mruby-dir',         mgem: 'mruby-dir'
  # spec.add_dependency 'mruby-dir-glob',    mgem: 'mruby-dir-glob'
  # spec.add_dependency 'mruby-env',         mgem: 'mruby-env'
  # spec.add_dependency 'mruby-file-stat',   mgem: 'mruby-file-stat'
  # spec.add_dependency 'mruby-hashie',      mgem: 'mruby-hashie'
  # spec.add_dependency 'mruby-json',        mgem: 'mruby-json'
  # spec.add_dependency 'mruby-open3',       mgem: 'mruby-open3'
  # spec.add_dependency 'mruby-optparse',    mgem: 'mruby-optparse'
  # spec.add_dependency 'mruby-shellwords',  mgem: 'mruby-shellwords'
  # spec.add_dependency 'mruby-specinfra',   mgem: 'mruby-specinfra'
  #
  # spec.add_dependency 'mruby-tempfile',  github: 'k0kubun/mruby-tempfile'
  # spec.add_dependency 'mruby-yaml',      github: 'mrbgems/mruby-yaml'
  # spec.add_dependency 'mruby-erb',       github: 'k0kubun/mruby-erb'
  # spec.add_dependency 'mruby-etc',       github: 'eagletmt/mruby-etc'
  # spec.add_dependency 'mruby-uri',       github: 'zzak/mruby-uri'
  # spec.add_dependency 'mruby-schash',    github: 'tatsushid/mruby-schash'
end


# # Hints for creating your own bigint GEM
#
# This example gem, mruby-YOUR-bigint, is available under the Creative Commons Zero License (CC0).
#
# This file is placed for the purpose of describing hints for creating a `mruby-bigint` compatible GEM to realize multiple integers.
#
# The file structure in this example is as follows:
#
# ```
# +- mruby-YOUR-bigint/   <-  Make this directory public if necessary.
#     |                       Change the name of copied directory.
#     |
#     +- TODO-HINT.md     <-  You are currently viewing this file.
#     |                       Remove this from copied directory.
#     |
#     +- core/
#     |   |
#     |   +- bigint.c     <-  Body of the implementation.
#     |
#     +- mrbgem.rake      <-  GEM name is "mruby-bigint".
#                             May be depended on by other GEMs.
# ```
#
# Implementers of their own bigints should copy below this directory to another directory and do the following:
#
# - Rewrite `spec.author`, `spec.license`, `spec.homepage` and `spec.summary` in `<gem-dir>/mrbgem.rake` file to those of your own implementers.
# - Implement the respective functions in `<gem-dir>/core/bigint.c`.
#   - Define and use an object structure for `MRB_TT_BIGINT` type-tag.
#     It is recommended to use `mrb_static_assert_object_size()` to ensure that the size of the object structure is within six words.
# - Delete this file from the destination of the copy.
#
# If you wish to use it as an alternative to the `mruby-bigint` provided by mruby, please leave the GEM name in `<gem-dir>/mrbgem.rake` as it is.
# This is an important factor when it is depended from other GEMs with `spec.add_dependency 'mruby-bigint'`.
#
# The name of the top directory of the GEM can be changed arbitrarily.
# The name of the Git repository can also be changed arbitrarily.
#
# Note that there is no need for an initialization function as there is in a normal GEM.
# If you need it, create a file `<gem-dir>/src/bigint.c` for example, and implement the `mrb_mruby_bigint_gem_init()` function.

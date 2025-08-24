#include <stdio.h>
#include <stdlib.h>
#include <mruby.h>
#include <mruby/compile.h>

int main(int argc, char **argv) {
  mrb_state *mrb;
  mrb_ccontext *cxt;
  FILE *fp;
  mrb_value obj;

  mrb = mrb_open();
  if (mrb == NULL) { return 1; }

  cxt = mrb_ccontext_new(mrb);
  cxt->capture_errors = TRUE;

  for (size_t i = 0; i < argc; i++) {
    fp = fopen(argv[i], "r");
    if (fp == NULL) { return 2; }

    obj = mrb_load_file_cxt(mrb, fp, cxt);

    fclose(fp);
    mrb_ccontext_cleanup_local_variables(mrb, cxt);
  }

  mrb_funcall(mrb, obj, "__main__", 0);

  if (mrb->exc) {
    mrb_print_error(mrb);
    mrb->exc = 0;
    mrb_close(mrb);
    return EXIT_FAILURE;
  }

  mrb_close(mrb);
  return EXIT_SUCCESS;
}

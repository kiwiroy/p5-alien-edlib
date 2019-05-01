## -*- mode: perl; -*-
use strict;
use warnings;
use Test::More;
use Test::Alien::CPP;
use Alien::Edlib;

alien_ok 'Alien::Edlib', 'loads';

ok +Alien::Edlib->version, 'version is set';

my $xs = do { local $/ = undef; <DATA> };
xs_ok {
  xs => $xs,
  verbose => $ENV{TEST_VERBOSE},
}, 'build edlib xs', with_subtest {
  is Edlib->isloaded(), 1, 'isloaded returns 1';
  is Edlib->align("Hello", "Hola"), 3, 'edit distance == 3';
  ok 1;
};

done_testing;

__DATA__
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <edlib.h>

MODULE = Edlib PACKAGE = Edlib

int isloaded(klass)
  char *klass;
  CODE:
    RETVAL = 1;
  OUTPUT:
    RETVAL

int align(klass, query, subject)
  char *klass;
  char *query;
  char *subject;
  CODE:
  {
    int ret = 0;
    EdlibAlignResult result = edlibAlign(query, strlen(query),
      subject, strlen(subject), edlibDefaultAlignConfig());
    if (result.status == EDLIB_STATUS_OK) {
      ret = result.editDistance;
      printf("edit_distance(%s, %s) = %d\n", query, subject, result.editDistance);
    }
    edlibFreeAlignResult(result);
    RETVAL = ret;
  }
  OUTPUT:
    RETVAL

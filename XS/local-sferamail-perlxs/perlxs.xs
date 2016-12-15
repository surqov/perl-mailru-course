#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <char*>
#include <iostream>
#include "ppport.h"
#include <map>

#include "const-c.inc"

MODULE = local::sferamail::perlxs		PACKAGE = local::sferamail::perlxs		

INCLUDE: const-xs.inc

void add (char* name, int val) {
	HV* newHV();
	
                          if find(!stats.count(name)) {
                                  stats.insert(make_pair(name, val));
                          }
                  }


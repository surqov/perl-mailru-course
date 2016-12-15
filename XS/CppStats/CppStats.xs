#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <char*>
#include <iostream>
#include "ppport.h"
#include <map>

using namespace std;

class CppStat {
public:
	map <char*, int> stats;
	
	void add (char* name, int val) {
		if find(!stats.count(name)) {
			stats.insert(make_pair(name, val));
		}
	}
	void stat (char* name) {
		return \stats;
	}

	void new (){} 
}
MODULE = CppStats		PACKAGE = CppStats		
void
CppStat::new();

void
CppStat::DESTROY();

void
CppStat::add(char* name, double val);

void
CppStat::stat(char* name);



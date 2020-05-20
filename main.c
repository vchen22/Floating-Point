#include <stdio.h>
#include <stdlib.h>
#include <error.h>
#include <inttypes.h>
#include <assert.h>

extern unsigned int quidFP2float(unsigned int);

union uf {
	unsigned int i;
	float f;
};
typedef union uf uf_t;

/*
 * This function will read in a binary file of 8-bit numbers
 * encoded in the Quidditch-FP format, convert them into 32-bit
 * floats, and print out the resutls to stdout. It also checks
 * that registers are left unmodified by the quidFP2float() call.
 */
int main(int argc, char *argv[]) {
	uf_t cvt;
	FILE *fp;
	if((fp = fopen(argv[1], "r")) == NULL) {
		fclose(fp);

	}
	uint8_t quidFP;
	while(fread(&quidFP, 1, 1, fp)) {
		register int l0 = 0xffffff0;
		register int l1 = 0xffffff1;
		register int l2 = 0xffffff2;
		register int l3 = 0xffffff3;
		register int l4 = 0xffffff4;
		register int l5 = 0xffffff5;
		register int l6 = 0xffffff6;
		register int l7 = 0xffffff7;
		register int l8 = 0xffffff8;
		register int l9 = 0xffffff9;
		register int la = 0xffffffa;
		cvt.i = quidFP2float((uint32_t)quidFP);
		assert(l0 == 0xffffff0);
		assert(l1 == 0xffffff1);
		assert(l2 == 0xffffff2);
		assert(l3 == 0xffffff3);
		assert(l4 == 0xffffff4);
		assert(l5 == 0xffffff5);
		assert(l6 == 0xffffff6);
		assert(l7 == 0xffffff7);
		assert(l8 == 0xffffff8);
		assert(l9 == 0xffffff9);
		assert(la == 0xffffffa);
		printf("%02x\t", quidFP);
		printf("%08x\t", cvt.i);
		printf("%12.7f\n", cvt.f);
	}
	fclose(fp);
}

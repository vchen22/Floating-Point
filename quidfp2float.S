	.arch	armv6
	.cpu	cortex-a53
	.equ	NUL, 0
	.equ	FP_OFFSET, 32 		// (# of regs saved - 1) * 4




	.global	quidFP2float	

quidFP2float:
	// quidFP2float's prolog (do not edit)
	push    {r4-r10, fp, lr}   	// using SP to save preserved regs that might be modified
	add  	fp, sp, #FP_OFFSET	// using SP to update FP to the new stackframe

  //=================== YOUR CODE GOES IN THE SECTION BELOW ===================//


	CMP r0, #0			// if (r0 == 0)
	BEQ zero			//	zero()
					// .
	CMP r0, #128			// if (r0 != -0)
	BNE convert			// 	convert()
					// .
zero:					// else
	BL  zeroQuidFP2float		// 	zeroQuidFP2float()
	b done				// return	
					//
convert:				//	
	AND r1, r0, #0x80		// 	r1 = r0 & 1000_0000 (extract sign bit)
	AND r2, r0, #0x70		//	r2 = r0 & 0111_0000 (extract exponent)
	AND r3, r0, #0x0f		//	r3 = r0 & 0000_1111 (extract mantissa)
					// 	.
	LSL r1, r1, #24			//	r2 = r2 << 24 (make sign bit leftmost bit of 32 bit)
					//	.
	LSR r2, r2, #4			//	r2 = r2 >> 4 (get exponent decimal value)
	SUB r2, r2, #3			//	r2 = r2 - 3 (remove bias of 3)
	ADD r2, r2, #127		//	r2 = r2 + 127 (add bias of 127)
	LSL r2, r2, #23 		// 	r2 = r2 << 23 (shift exp to bit 2-9)
					//	.
	LSL r3, r3, #19			// 	r3 = r3 << 19 (shift mantissa to bit 10-32)
					// 	.
	MOV r0, #0			// 	r0 = 0
	ORR r0, r0, r1			//	r0 = r0 | r1 (set sign bit)
	ORR r0, r0, r2			//	r0 = r0 | r2 (set exp)
	ORR r0, r0, r3			//	r0 = r0 | r3 (set mantissa)

done:
  //===========================================================================//

	// quidFP2float's epilog (do not edit)
	sub	sp, fp, #FP_OFFSET	// using FP to restore SP to the old stackframe
	pop     {r4-r10, fp, lr}   	// using SP to restore regs saved in prolog
	bx 	lr                      // using LR to update PC and thereby return




	.global zeroQuidFP2float

zeroQuidFP2float:
	// zeroQuidFP2float's prolog (do not edit)
	push    {r4-r10, fp, lr}   	// using SP to save preserved regs that might be modified
	add	fp, sp, #FP_OFFSET	// using SP to update FP to the new stackframe

  //=================== YOUR CODE GOES IN THE SECTION BELOW ===================//


	LSL r0, #24			// r0 = r0 << 24		 


  //===========================================================================//

	// zeroQuidFP2float's epilog (do not edit)
	sub	sp, fp, #FP_OFFSET	// using FP to restore SP to the old stackframe
	pop     {r4-r10, fp, lr}   	// using SP to restore regs saved in prolog
	bx 	lr                      // using LR to update PC and thereby return

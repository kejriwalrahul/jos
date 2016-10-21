/* See COPYRIGHT for copyright information. */

#include <inc/mmu.h>
#include <inc/memlayout.h>
#include <inc/trap.h>

#include <kern/picirq.h>


###################################################################
# exceptions/interrupts
###################################################################

/* TRAPHANDLER defines a globally-visible function for handling a trap.
 * It pushes a trap number onto the stack, then jumps to _alltraps.
 * Use TRAPHANDLER for traps where the CPU automatically pushes an error code.
 *
 * You shouldn't call a TRAPHANDLER function from C, but you may
 * need to _declare_ one in C (for instance, to get a function pointer
 * during IDT setup).  You can declare the function with
 *   void NAME();
 * where NAME is the argument passed to TRAPHANDLER.
 */
#define TRAPHANDLER(name, num)						\
	.globl name;		/* define global symbol for 'name' */	\
	.type name, @function;	/* symbol type is function */		\
	.align 2;		/* align function definition */		\
	name:			/* function starts here */		\
	pushl $(num);							\
	jmp _alltraps

/* Use TRAPHANDLER_NOEC for traps where the CPU doesn't push an error code.
 * It pushes a 0 in place of the error code, so the trap frame has the same
 * format in either case.
 */
#define TRAPHANDLER_NOEC(name, num)					\
	.globl name;							\
	.type name, @function;						\
	.align 2;							\
	name:								\
	pushl $0;							\
	pushl $(num);							\
	jmp _alltraps

.text

/*
 * Lab 3: Your code here for generating entry points for the different traps.
 */

TRAPHANDLER_NOEC(int_div,T_DIVIDE)
TRAPHANDLER_NOEC(int_deb,T_DEBUG)
TRAPHANDLER_NOEC(int_nmi,T_NMI)
TRAPHANDLER_NOEC(int_brk,T_BRKPT)
TRAPHANDLER_NOEC(int_ofl,T_OFLOW)
TRAPHANDLER_NOEC(int_bou,T_BOUND)
TRAPHANDLER_NOEC(int_ill,T_ILLOP)
TRAPHANDLER_NOEC(int_dev,T_DEVICE)
TRAPHANDLER(int_dbl,T_DBLFLT)
TRAPHANDLER(int_tss,T_TSS)
TRAPHANDLER(int_seg,T_SEGNP)
TRAPHANDLER(int_sta,T_STACK)
TRAPHANDLER(int_gpf,T_GPFLT)
TRAPHANDLER(int_pgf,T_PGFLT)
TRAPHANDLER_NOEC(int_fpe,T_FPERR)
TRAPHANDLER(int_ali,T_ALIGN)
TRAPHANDLER_NOEC(int_mch,T_MCHK)
TRAPHANDLER_NOEC(int_sim,T_SIMDERR)

TRAPHANDLER_NOEC(int_sys_call,T_SYSCALL)

TRAPHANDLER_NOEC(int_irq0, 32)
TRAPHANDLER_NOEC(int_irq1, 33)
TRAPHANDLER_NOEC(int_irq2, 34)
TRAPHANDLER_NOEC(int_irq3, 35)
TRAPHANDLER_NOEC(int_irq4, 36)
TRAPHANDLER_NOEC(int_irq5, 37)
TRAPHANDLER_NOEC(int_irq6, 38)
TRAPHANDLER_NOEC(int_irq7, 39)
TRAPHANDLER_NOEC(int_irq8, 40)
TRAPHANDLER_NOEC(int_irq9, 41)
TRAPHANDLER_NOEC(int_irq10, 42)
TRAPHANDLER_NOEC(int_irq11, 43)
TRAPHANDLER_NOEC(int_irq12, 44)
TRAPHANDLER_NOEC(int_irq13, 45)
TRAPHANDLER_NOEC(int_irq14, 46)
TRAPHANDLER_NOEC(int_irq15, 47)

/*
 * Lab 3: Your code here for _alltraps
 */

_alltraps:	
	 
	pushw $0x0;
	pushw %ds;
	pushw $0x0;
	pushw %es;
	pushal;
	
	movl $GD_KD, %eax;
	movl %eax, %ds;
	movl %eax, %es;

	pushl %esp;
	call trap;
	.file	"file9.c"
	.comm	_mutexFuel, 4, 2
	.comm	_condFuel, 4, 2
	.globl	_fuel
	.bss
	.align 4
_fuel:
	.space 4
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "Failed to create thread!\0"
LC1:
	.ascii "Failed to join thread!\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB27:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$48, %esp
	call	___main
	movl	$0, 4(%esp)
	movl	$_mutexFuel, (%esp)
	call	_pthread_mutex_init
	movl	$0, 4(%esp)
	movl	$_condFuel, (%esp)
	call	_pthread_cond_init
	movl	$0, 44(%esp)
	jmp	L2
L6:
	cmpl	$1, 44(%esp)
	jne	L3
	leal	24(%esp), %eax
	movl	44(%esp), %edx
	sall	$3, %edx
	addl	%edx, %eax
	movl	$0, 12(%esp)
	movl	$_fuel_filling, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_pthread_create
	testl	%eax, %eax
	je	L5
	movl	$LC0, (%esp)
	call	_perror
	jmp	L5
L3:
	leal	24(%esp), %eax
	movl	44(%esp), %edx
	sall	$3, %edx
	addl	%edx, %eax
	movl	$0, 12(%esp)
	movl	$_car, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_pthread_create
	testl	%eax, %eax
	je	L5
	movl	$LC0, (%esp)
	call	_perror
L5:
	addl	$1, 44(%esp)
L2:
	cmpl	$1, 44(%esp)
	jle	L6
	movl	$0, 40(%esp)
	jmp	L7
L9:
	movl	$0, 8(%esp)
	movl	40(%esp), %eax
	movl	28(%esp,%eax,8), %edx
	movl	24(%esp,%eax,8), %eax
	movl	%eax, (%esp)
	movl	%edx, 4(%esp)
	call	_pthread_join
	testl	%eax, %eax
	je	L8
	movl	$LC1, (%esp)
	call	_perror
L8:
	addl	$1, 40(%esp)
L7:
	cmpl	$1, 40(%esp)
	jle	L9
	movl	$_mutexFuel, (%esp)
	call	_pthread_mutex_destroy
	movl	$_condFuel, (%esp)
	call	_pthread_cond_destroy
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE27:
	.section .rdata,"dr"
LC2:
	.ascii "Filled fuel...%d\12\0"
	.text
	.globl	_fuel_filling
	.def	_fuel_filling;	.scl	2;	.type	32;	.endef
_fuel_filling:
LFB28:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	$0, -12(%ebp)
	jmp	L12
L13:
	movl	$_mutexFuel, (%esp)
	call	_pthread_mutex_lock
	movl	_fuel, %eax
	addl	$15, %eax
	movl	%eax, _fuel
	movl	_fuel, %eax
	movl	%eax, 4(%esp)
	movl	$LC2, (%esp)
	call	_printf
	movl	$_mutexFuel, (%esp)
	call	_pthread_mutex_unlock
	movl	$_condFuel, (%esp)
	call	_pthread_cond_signal
	movl	$1, (%esp)
	call	_sleep
	addl	$1, -12(%ebp)
L12:
	cmpl	$4, -12(%ebp)
	jle	L13
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE28:
	.section .rdata,"dr"
LC3:
	.ascii "No fuel. Waiting...\0"
LC4:
	.ascii "Got fuel. Now left: %d\12\0"
	.text
	.globl	_car
	.def	_car;	.scl	2;	.type	32;	.endef
_car:
LFB29:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$_mutexFuel, (%esp)
	call	_pthread_mutex_lock
	jmp	L15
L16:
	movl	$LC3, (%esp)
	call	_puts
	movl	$_mutexFuel, 4(%esp)
	movl	$_condFuel, (%esp)
	call	_pthread_cond_wait
L15:
	movl	_fuel, %eax
	cmpl	$39, %eax
	jle	L16
	movl	_fuel, %eax
	subl	$40, %eax
	movl	%eax, _fuel
	movl	_fuel, %eax
	movl	%eax, 4(%esp)
	movl	$LC4, (%esp)
	call	_printf
	movl	$_mutexFuel, (%esp)
	call	_pthread_mutex_unlock
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE29:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	_pthread_mutex_init;	.scl	2;	.type	32;	.endef
	.def	_pthread_cond_init;	.scl	2;	.type	32;	.endef
	.def	_pthread_create;	.scl	2;	.type	32;	.endef
	.def	_perror;	.scl	2;	.type	32;	.endef
	.def	_pthread_join;	.scl	2;	.type	32;	.endef
	.def	_pthread_mutex_destroy;	.scl	2;	.type	32;	.endef
	.def	_pthread_cond_destroy;	.scl	2;	.type	32;	.endef
	.def	_pthread_mutex_lock;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_pthread_mutex_unlock;	.scl	2;	.type	32;	.endef
	.def	_pthread_cond_signal;	.scl	2;	.type	32;	.endef
	.def	_sleep;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
	.def	_pthread_cond_wait;	.scl	2;	.type	32;	.endef

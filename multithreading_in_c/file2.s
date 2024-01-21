	.file	"file2.c"
	.globl	_mails
	.bss
	.align 4
_mails:
	.space 4
	.text
	.globl	_routine
	.def	_routine;	.scl	2;	.type	32;	.endef
_routine:
LFB16:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -4(%ebp)
	jmp	L2
L3:
	movl	_mails, %eax
	addl	$1, %eax
	movl	%eax, _mails
	addl	$1, -4(%ebp)
L2:
	cmpl	$999999, -4(%ebp)
	jle	L3
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE16:
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "Failed to create a thread 1.\0"
LC1:
	.ascii "Failed to create a thread 2.\0"
LC2:
	.ascii "Number of mails: %d\12\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB17:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$32, %esp
	call	___main
	movl	$0, 12(%esp)
	movl	$_routine, 8(%esp)
	movl	$0, 4(%esp)
	leal	24(%esp), %eax
	movl	%eax, (%esp)
	call	_pthread_create
	testl	%eax, %eax
	je	L5
	movl	$LC0, (%esp)
	call	_puts
	movl	$1, %eax
	jmp	L10
L5:
	movl	$0, 12(%esp)
	movl	$_routine, 8(%esp)
	movl	$0, 4(%esp)
	leal	16(%esp), %eax
	movl	%eax, (%esp)
	call	_pthread_create
	testl	%eax, %eax
	je	L7
	movl	$LC1, (%esp)
	call	_puts
	movl	$2, %eax
	jmp	L10
L7:
	movl	$0, 8(%esp)
	movl	24(%esp), %eax
	movl	28(%esp), %edx
	movl	%eax, (%esp)
	movl	%edx, 4(%esp)
	call	_pthread_join
	testl	%eax, %eax
	je	L8
	movl	$3, %eax
	jmp	L10
L8:
	movl	$0, 8(%esp)
	movl	16(%esp), %eax
	movl	20(%esp), %edx
	movl	%eax, (%esp)
	movl	%edx, 4(%esp)
	call	_pthread_join
	testl	%eax, %eax
	je	L9
	movl	$4, %eax
	jmp	L10
L9:
	movl	_mails, %eax
	movl	%eax, 4(%esp)
	movl	$LC2, (%esp)
	call	_printf
	movl	$0, %eax
L10:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE17:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	_pthread_create;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
	.def	_pthread_join;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef

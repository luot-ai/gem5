	.text
	.file	"square1.cpp"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function main
.LCPI0_0:
	.quad	0x401e848000000000              # double 7.62939453125
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI0_1:
	.quad	2                               # 0x2
	.quad	3                               # 0x3
.LCPI0_2:
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	1                               # 0x1
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
.LCPI0_3:
	.long	0x3fcf1aa0                      # float 1.61800003
	.long	0x3fcf1aa0                      # float 1.61800003
	.long	0x3fcf1aa0                      # float 1.61800003
	.long	0x3fcf1aa0                      # float 1.61800003
.LCPI0_4:
	.quad	4                               # 0x4
	.quad	4                               # 0x4
.LCPI0_5:
	.quad	8                               # 0x8
	.quad	8                               # 0x8
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$1592, %rsp                     # imm = 0x638
	.cfi_def_cfa_offset 1616
	.cfi_offset %rbx, -24
	.cfi_offset %rbp, -16
	leaq	120(%rsp), %rdi
	xorl	%esi, %esi
	callq	hipGetDevicePropertiesR0600
	testl	%eax, %eax
	jne	.LBB0_1
# %bb.2:
	leaq	120(%rsp), %rsi
	movl	$.L.str.2, %edi
	xorl	%eax, %eax
	callq	printf
	movsd	.LCPI0_0(%rip), %xmm0           # xmm0 = [7.62939453125E+0,0.0E+0]
	movl	$.L.str.3, %edi
	movb	$1, %al
	callq	printf
	leaq	8(%rsp), %rdi
	movl	$4000000, %esi                  # imm = 0x3D0900
	xorl	%edx, %edx
	callq	hipHostMalloc
	testl	%eax, %eax
	jne	.LBB0_3
# %bb.4:
	leaq	16(%rsp), %rdi
	movl	$4000000, %esi                  # imm = 0x3D0900
	xorl	%edx, %edx
	callq	hipHostMalloc
	testl	%eax, %eax
	jne	.LBB0_41
# %bb.5:                                # %.preheader
	movdqa	.LCPI0_1(%rip), %xmm0           # xmm0 = [2,3]
	movdqa	.LCPI0_2(%rip), %xmm1           # xmm1 = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
	movl	$4, %eax
	movq	8(%rsp), %rcx
	movaps	.LCPI0_3(%rip), %xmm2           # xmm2 = [1.61800003E+0,1.61800003E+0,1.61800003E+0,1.61800003E+0]
	movdqa	.LCPI0_4(%rip), %xmm3           # xmm3 = [4,4]
	movdqa	.LCPI0_5(%rip), %xmm4           # xmm4 = [8,8]
	jmp	.LBB0_6
	.p2align	4, 0x90
.LBB0_29:                               # %vector.body
                                        #   in Loop: Header=BB0_6 Depth=1
	xorps	%xmm8, %xmm8
	cvtsi2ss	%rdx, %xmm8
.LBB0_30:                               # %vector.body
                                        #   in Loop: Header=BB0_6 Depth=1
	unpcklps	%xmm8, %xmm7                    # xmm7 = xmm7[0],xmm8[0],xmm7[1],xmm8[1]
	unpcklps	%xmm6, %xmm5                    # xmm5 = xmm5[0],xmm6[0],xmm5[1],xmm6[1]
	movlhps	%xmm7, %xmm5                    # xmm5 = xmm5[0],xmm7[0]
	addps	%xmm2, %xmm5
	movups	%xmm5, (%rcx,%rax,4)
	paddq	%xmm4, %xmm1
	paddq	%xmm4, %xmm0
	addq	$8, %rax
	cmpq	$1000004, %rax                  # imm = 0xF4244
	je	.LBB0_31
.LBB0_6:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	movq	%xmm1, %rdx
	testq	%rdx, %rdx
	js	.LBB0_7
# %bb.8:                                # %vector.body
                                        #   in Loop: Header=BB0_6 Depth=1
	xorps	%xmm5, %xmm5
	cvtsi2ss	%rdx, %xmm5
	pshufd	$238, %xmm1, %xmm6              # xmm6 = xmm1[2,3,2,3]
	movq	%xmm6, %rdx
	testq	%rdx, %rdx
	jns	.LBB0_11
.LBB0_10:                               #   in Loop: Header=BB0_6 Depth=1
	movq	%rdx, %rsi
	shrq	%rsi
	andl	$1, %edx
	orq	%rsi, %rdx
	xorps	%xmm6, %xmm6
	cvtsi2ss	%rdx, %xmm6
	addss	%xmm6, %xmm6
	movq	%xmm0, %rdx
	testq	%rdx, %rdx
	jns	.LBB0_14
.LBB0_13:                               #   in Loop: Header=BB0_6 Depth=1
	movq	%rdx, %rsi
	shrq	%rsi
	andl	$1, %edx
	orq	%rsi, %rdx
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rdx, %xmm7
	addss	%xmm7, %xmm7
	pshufd	$238, %xmm0, %xmm8              # xmm8 = xmm0[2,3,2,3]
	movq	%xmm8, %rdx
	testq	%rdx, %rdx
	jns	.LBB0_17
.LBB0_16:                               #   in Loop: Header=BB0_6 Depth=1
	movq	%rdx, %rsi
	shrq	%rsi
	andl	$1, %edx
	orq	%rsi, %rdx
	xorps	%xmm8, %xmm8
	cvtsi2ss	%rdx, %xmm8
	addss	%xmm8, %xmm8
	jmp	.LBB0_18
	.p2align	4, 0x90
.LBB0_7:                                #   in Loop: Header=BB0_6 Depth=1
	movq	%rdx, %rsi
	shrq	%rsi
	andl	$1, %edx
	orq	%rsi, %rdx
	xorps	%xmm5, %xmm5
	cvtsi2ss	%rdx, %xmm5
	addss	%xmm5, %xmm5
	pshufd	$238, %xmm1, %xmm6              # xmm6 = xmm1[2,3,2,3]
	movq	%xmm6, %rdx
	testq	%rdx, %rdx
	js	.LBB0_10
.LBB0_11:                               # %vector.body
                                        #   in Loop: Header=BB0_6 Depth=1
	xorps	%xmm6, %xmm6
	cvtsi2ss	%rdx, %xmm6
	movq	%xmm0, %rdx
	testq	%rdx, %rdx
	js	.LBB0_13
.LBB0_14:                               # %vector.body
                                        #   in Loop: Header=BB0_6 Depth=1
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rdx, %xmm7
	pshufd	$238, %xmm0, %xmm8              # xmm8 = xmm0[2,3,2,3]
	movq	%xmm8, %rdx
	testq	%rdx, %rdx
	js	.LBB0_16
.LBB0_17:                               # %vector.body
                                        #   in Loop: Header=BB0_6 Depth=1
	xorps	%xmm8, %xmm8
	cvtsi2ss	%rdx, %xmm8
.LBB0_18:                               # %vector.body
                                        #   in Loop: Header=BB0_6 Depth=1
	unpcklps	%xmm8, %xmm7                    # xmm7 = xmm7[0],xmm8[0],xmm7[1],xmm8[1]
	unpcklps	%xmm6, %xmm5                    # xmm5 = xmm5[0],xmm6[0],xmm5[1],xmm6[1]
	movlhps	%xmm7, %xmm5                    # xmm5 = xmm5[0],xmm7[0]
	addps	%xmm2, %xmm5
	movups	%xmm5, -16(%rcx,%rax,4)
	movdqa	%xmm1, %xmm6
	paddq	%xmm3, %xmm6
	movq	%xmm6, %rdx
	testq	%rdx, %rdx
	js	.LBB0_19
# %bb.20:                               # %vector.body
                                        #   in Loop: Header=BB0_6 Depth=1
	xorps	%xmm5, %xmm5
	cvtsi2ss	%rdx, %xmm5
	pshufd	$238, %xmm6, %xmm6              # xmm6 = xmm6[2,3,2,3]
	movq	%xmm6, %rdx
	testq	%rdx, %rdx
	jns	.LBB0_23
.LBB0_22:                               #   in Loop: Header=BB0_6 Depth=1
	movq	%rdx, %rsi
	shrq	%rsi
	andl	$1, %edx
	orq	%rsi, %rdx
	xorps	%xmm6, %xmm6
	cvtsi2ss	%rdx, %xmm6
	addss	%xmm6, %xmm6
	jmp	.LBB0_24
	.p2align	4, 0x90
.LBB0_19:                               #   in Loop: Header=BB0_6 Depth=1
	movq	%rdx, %rsi
	shrq	%rsi
	andl	$1, %edx
	orq	%rsi, %rdx
	xorps	%xmm5, %xmm5
	cvtsi2ss	%rdx, %xmm5
	addss	%xmm5, %xmm5
	pshufd	$238, %xmm6, %xmm6              # xmm6 = xmm6[2,3,2,3]
	movq	%xmm6, %rdx
	testq	%rdx, %rdx
	js	.LBB0_22
.LBB0_23:                               # %vector.body
                                        #   in Loop: Header=BB0_6 Depth=1
	xorps	%xmm6, %xmm6
	cvtsi2ss	%rdx, %xmm6
.LBB0_24:                               # %vector.body
                                        #   in Loop: Header=BB0_6 Depth=1
	movdqa	%xmm0, %xmm8
	paddq	%xmm3, %xmm8
	movq	%xmm8, %rdx
	testq	%rdx, %rdx
	js	.LBB0_25
# %bb.26:                               # %vector.body
                                        #   in Loop: Header=BB0_6 Depth=1
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rdx, %xmm7
	pshufd	$238, %xmm8, %xmm8              # xmm8 = xmm8[2,3,2,3]
	movq	%xmm8, %rdx
	testq	%rdx, %rdx
	jns	.LBB0_29
	jmp	.LBB0_28
	.p2align	4, 0x90
.LBB0_25:                               #   in Loop: Header=BB0_6 Depth=1
	movq	%rdx, %rsi
	shrq	%rsi
	andl	$1, %edx
	orq	%rsi, %rdx
	xorps	%xmm7, %xmm7
	cvtsi2ss	%rdx, %xmm7
	addss	%xmm7, %xmm7
	pshufd	$238, %xmm8, %xmm8              # xmm8 = xmm8[2,3,2,3]
	movq	%xmm8, %rdx
	testq	%rdx, %rdx
	jns	.LBB0_29
.LBB0_28:                               #   in Loop: Header=BB0_6 Depth=1
	movq	%rdx, %rsi
	shrq	%rsi
	andl	$1, %edx
	orq	%rsi, %rdx
	xorps	%xmm8, %xmm8
	cvtsi2ss	%rdx, %xmm8
	addss	%xmm8, %xmm8
	jmp	.LBB0_30
.LBB0_31:                               # %middle.block
	movl	$.Lstr, %edi
	callq	puts@PLT
	movabsq	$4294967552, %rdx               # imm = 0x100000100
	leaq	256(%rdx), %rdi
	movl	$1, %esi
	movl	$1, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	__hipPushCallConfiguration
	testl	%eax, %eax
	jne	.LBB0_33
# %bb.32:
	movq	16(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 88(%rsp)
	movq	%rcx, 80(%rsp)
	movq	$1000000, 72(%rsp)              # imm = 0xF4240
	leaq	88(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	56(%rsp), %rdi
	leaq	40(%rsp), %rsi
	leaq	32(%rsp), %rdx
	leaq	24(%rsp), %rcx
	callq	__hipPopCallConfiguration
	movq	56(%rsp), %rsi
	movl	64(%rsp), %edx
	movq	40(%rsp), %rcx
	movl	48(%rsp), %r8d
	leaq	96(%rsp), %r9
	movl	$_Z13vector_squareIfEvPT_PKS0_m, %edi
	pushq	24(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	40(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
.LBB0_33:
	callq	hipDeviceSynchronize
	movl	$.Lstr.1, %edi
	callq	puts@PLT
	movq	16(%rsp), %rax
	movl	$3, %ecx
	movq	8(%rsp), %rdx
	.p2align	4, 0x90
.LBB0_38:                               # =>This Inner Loop Header: Depth=1
	movss	-12(%rax,%rcx,4), %xmm0         # xmm0 = mem[0],zero,zero,zero
	movss	-12(%rdx,%rcx,4), %xmm1         # xmm1 = mem[0],zero,zero,zero
	mulss	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.LBB0_39
	jp	.LBB0_39
# %bb.34:                               #   in Loop: Header=BB0_38 Depth=1
	movss	-8(%rax,%rcx,4), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movss	-8(%rdx,%rcx,4), %xmm1          # xmm1 = mem[0],zero,zero,zero
	mulss	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.LBB0_39
	jp	.LBB0_39
# %bb.35:                               #   in Loop: Header=BB0_38 Depth=1
	movss	-4(%rax,%rcx,4), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movss	-4(%rdx,%rcx,4), %xmm1          # xmm1 = mem[0],zero,zero,zero
	mulss	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.LBB0_39
	jp	.LBB0_39
# %bb.36:                               #   in Loop: Header=BB0_38 Depth=1
	movss	(%rax,%rcx,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	movss	(%rdx,%rcx,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
	mulss	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.LBB0_39
	jp	.LBB0_39
# %bb.37:                               #   in Loop: Header=BB0_38 Depth=1
	addq	$4, %rcx
	cmpq	$1000003, %rcx                  # imm = 0xF4243
	jne	.LBB0_38
# %bb.42:
	movl	$.Lstr.2, %edi
	callq	puts@PLT
	xorl	%eax, %eax
	addq	$1592, %rsp                     # imm = 0x638
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB0_39:
	.cfi_def_cfa_offset 1616
	movq	stderr(%rip), %rbx
	movl	$999, %edi                      # imm = 0x3E7
	callq	hipGetErrorString
	movl	$.L.str, %esi
	movl	$.L.str.1, %r8d
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$999, %ecx                      # imm = 0x3E7
	movl	$95, %r9d
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %edi
	callq	exit
.LBB0_1:
	movq	stderr(%rip), %rbx
	movl	%eax, %edi
	movl	%eax, %ebp
	callq	hipGetErrorString
	movl	$.L.str, %esi
	movl	$.L.str.1, %r8d
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	%ebp, %ecx
	movl	$71, %r9d
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %edi
	callq	exit
.LBB0_3:
	movq	stderr(%rip), %rbx
	movl	%eax, %edi
	movl	%eax, %ebp
	callq	hipGetErrorString
	movl	$.L.str, %esi
	movl	$.L.str.1, %r8d
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	%ebp, %ecx
	movl	$77, %r9d
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %edi
	callq	exit
.LBB0_41:
	movq	stderr(%rip), %rbx
	movl	%eax, %edi
	movl	%eax, %ebp
	callq	hipGetErrorString
	movl	$.L.str, %esi
	movl	$.L.str.1, %r8d
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	%ebp, %ecx
	movl	$78, %r9d
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %edi
	callq	exit
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.section	.text._Z28__device_stub__vector_squareIfEvPT_PKS0_m,"axG",@progbits,_Z28__device_stub__vector_squareIfEvPT_PKS0_m,comdat
	.weak	_Z28__device_stub__vector_squareIfEvPT_PKS0_m # -- Begin function _Z28__device_stub__vector_squareIfEvPT_PKS0_m
	.p2align	4, 0x90
	.type	_Z28__device_stub__vector_squareIfEvPT_PKS0_m,@function
_Z28__device_stub__vector_squareIfEvPT_PKS0_m: # @_Z28__device_stub__vector_squareIfEvPT_PKS0_m
	.cfi_startproc
# %bb.0:
	subq	$104, %rsp
	.cfi_def_cfa_offset 112
	movq	%rdi, 72(%rsp)
	movq	%rsi, 64(%rsp)
	movq	%rdx, 56(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 80(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 88(%rsp)
	leaq	56(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	40(%rsp), %rdi
	leaq	24(%rsp), %rsi
	leaq	16(%rsp), %rdx
	leaq	8(%rsp), %rcx
	callq	__hipPopCallConfiguration
	movq	40(%rsp), %rsi
	movl	48(%rsp), %edx
	movq	24(%rsp), %rcx
	movl	32(%rsp), %r8d
	leaq	80(%rsp), %r9
	movl	$_Z13vector_squareIfEvPT_PKS0_m, %edi
	pushq	8(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	24(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel
	addq	$120, %rsp
	.cfi_adjust_cfa_offset -120
	retq
.Lfunc_end1:
	.size	_Z28__device_stub__vector_squareIfEvPT_PKS0_m, .Lfunc_end1-_Z28__device_stub__vector_squareIfEvPT_PKS0_m
	.cfi_endproc
                                        # -- End function
	.text
	.p2align	4, 0x90                         # -- Begin function __hip_module_ctor
	.type	__hip_module_ctor,@function
__hip_module_ctor:                      # @__hip_module_ctor
	.cfi_startproc
# %bb.0:
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	__hip_gpubin_handle_8e4ad2cb2993f7(%rip), %rdi
	testq	%rdi, %rdi
	jne	.LBB2_2
# %bb.1:
	movl	$__hip_fatbin_wrapper, %edi
	callq	__hipRegisterFatBinary
	movq	%rax, %rdi
	movq	%rax, __hip_gpubin_handle_8e4ad2cb2993f7(%rip)
.LBB2_2:
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movl	$_Z13vector_squareIfEvPT_PKS0_m, %esi
	movl	$.L__unnamed_1, %edx
	movl	$.L__unnamed_1, %ecx
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction
	movl	$__hip_module_dtor, %edi
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	jmp	atexit                          # TAILCALL
.Lfunc_end2:
	.size	__hip_module_ctor, .Lfunc_end2-__hip_module_ctor
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function __hip_module_dtor
	.type	__hip_module_dtor,@function
__hip_module_dtor:                      # @__hip_module_dtor
	.cfi_startproc
# %bb.0:
	movq	__hip_gpubin_handle_8e4ad2cb2993f7(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB3_2
# %bb.1:
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	__hipUnregisterFatBinary
	movq	$0, __hip_gpubin_handle_8e4ad2cb2993f7(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
.LBB3_2:
	retq
.Lfunc_end3:
	.size	__hip_module_dtor, .Lfunc_end3-__hip_module_dtor
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"error: '%s'(%d) at %s:%d\n"
	.size	.L.str, 26

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"square1.cpp"
	.size	.L.str.1, 12

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"info: running on device %s\n"
	.size	.L.str.2, 28

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"info: allocate host and device mem (%6.2f MB)\n"
	.size	.L.str.3, 47

	.type	_Z13vector_squareIfEvPT_PKS0_m,@object # @_Z13vector_squareIfEvPT_PKS0_m
	.section	.rodata._Z13vector_squareIfEvPT_PKS0_m,"aG",@progbits,_Z13vector_squareIfEvPT_PKS0_m,comdat
	.weak	_Z13vector_squareIfEvPT_PKS0_m
	.p2align	3, 0x0
_Z13vector_squareIfEvPT_PKS0_m:
	.quad	_Z28__device_stub__vector_squareIfEvPT_PKS0_m
	.size	_Z13vector_squareIfEvPT_PKS0_m, 8

	.type	.L__unnamed_1,@object           # @0
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__unnamed_1:
	.asciz	"_Z13vector_squareIfEvPT_PKS0_m"
	.size	.L__unnamed_1, 31

	.type	__hip_fatbin_wrapper,@object    # @__hip_fatbin_wrapper
	.section	.hipFatBinSegment,"a",@progbits
	.p2align	3, 0x0
__hip_fatbin_wrapper:
	.long	1212764230                      # 0x48495046
	.long	1                               # 0x1
	.quad	__hip_fatbin_8e4ad2cb2993f7
	.quad	0
	.size	__hip_fatbin_wrapper, 24

	.hidden	__hip_gpubin_handle_8e4ad2cb2993f7
	.section	.init_array,"aw",@init_array
	.p2align	3, 0x0
	.quad	__hip_module_ctor
	.type	__hip_cuid_8e4ad2cb2993f7,@object # @__hip_cuid_8e4ad2cb2993f7
	.bss
	.globl	__hip_cuid_8e4ad2cb2993f7
__hip_cuid_8e4ad2cb2993f7:
	.byte	0                               # 0x0
	.size	__hip_cuid_8e4ad2cb2993f7, 1

	.type	.Lstr,@object                   # @str
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lstr:
	.asciz	"info: launch 'vector_square' kernel"
	.size	.Lstr, 36

	.type	.Lstr.1,@object                 # @str.1
.Lstr.1:
	.asciz	"info: check result"
	.size	.Lstr.1, 19

	.type	.Lstr.2,@object                 # @str.2
.Lstr.2:
	.asciz	"PASSED!"
	.size	.Lstr.2, 8

	.ident	"AMD clang version 19.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.4.0 25133 c7fe45cf4b819c5991fe208aaa96edf142730f1d)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym _Z28__device_stub__vector_squareIfEvPT_PKS0_m
	.addrsig_sym __hip_module_ctor
	.addrsig_sym __hip_module_dtor
	.addrsig_sym _Z13vector_squareIfEvPT_PKS0_m
	.addrsig_sym __hip_fatbin_8e4ad2cb2993f7
	.addrsig_sym __hip_fatbin_wrapper
	.addrsig_sym __hip_cuid_8e4ad2cb2993f7

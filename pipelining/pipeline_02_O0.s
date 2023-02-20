	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"pipeline_02.c"
	.text
	.section	.rodata
	.align	2
.LC1:
	.ascii	"%d\000"
	.align	2
.LC2:
	.ascii	"Error\000"
	.align	2
.LC3:
	.ascii	"A\000"
	.align	2
.LC4:
	.ascii	"B\000"
	.align	2
.LC5:
	.ascii	"C\000"
	.align	2
.LC6:
	.ascii	"D\000"
	.align	2
.LC7:
	.ascii	"F\000"
	.align	2
.LC0:
	.word	80
	.word	70
	.word	60
	.word	50
	.text
	.align	2
	.global	main
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	ldr	r3, .L10
	sub	ip, fp, #28
	ldm	r3, {r0, r1, r2, r3}
	stm	ip, {r0, r1, r2, r3}
	sub	r3, fp, #28
	add	r3, r3, #8
	str	r3, [fp, #-8]
	sub	r3, fp, #12
	mov	r1, r3
	ldr	r0, .L10+4
	bl	scanf
	ldr	r3, [fp, #-12]
	cmp	r3, #100
	ble	.L2
	ldr	r0, .L10+8
	bl	puts
	b	.L3
.L2:
	ldr	r3, [fp, #-12]
	cmp	r3, #80
	ble	.L4
	ldr	r0, .L10+12
	bl	puts
	b	.L3
.L4:
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-12]
	cmp	r2, r3
	bge	.L5
	ldr	r0, .L10+16
	bl	puts
	b	.L3
.L5:
	ldr	r3, [fp, #-8]
	ldr	r2, [r3]
	ldr	r3, [fp, #-12] 
	cmp	r2, r3
	bge	.L6
	ldr	r0, .L10+20
	bl	puts
	b	.L3
.L6:
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-12]
	cmp	r2, r3
	bgt	.L7
	ldr	r0, .L10+24
	bl	puts
	b	.L3
.L7:
	ldr	r3, [fp, #-12]
	cmp	r3, #0
	blt	.L8
	ldr	r0, .L10+28
	bl	puts
	b	.L3
.L8:
	ldr	r0, .L10+8
	bl	puts
.L3:
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L11:
	.align	2
.L10:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.size	main, .-main
	.ident	"GCC: (GNU Arm Embedded Toolchain 10-2020-q4-major) 10.2.1 20201103 (release)"


opt:     file format elf64-x86-64


Disassembly of section .init:

0000000000001000 <_init>:
    1000:	f3 0f 1e fa          	endbr64
    1004:	48 83 ec 08          	sub    $0x8,%rsp
    1008:	48 8b 05 d9 2f 00 00 	mov    0x2fd9(%rip),%rax        # 3fe8 <__gmon_start__@Base>
    100f:	48 85 c0             	test   %rax,%rax
    1012:	74 02                	je     1016 <_init+0x16>
    1014:	ff d0                	call   *%rax
    1016:	48 83 c4 08          	add    $0x8,%rsp
    101a:	c3                   	ret

Disassembly of section .plt:

0000000000001020 <.plt>:
    1020:	ff 35 52 2f 00 00    	push   0x2f52(%rip)        # 3f78 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	ff 25 54 2f 00 00    	jmp    *0x2f54(%rip)        # 3f80 <_GLOBAL_OFFSET_TABLE_+0x10>
    102c:	0f 1f 40 00          	nopl   0x0(%rax)
    1030:	f3 0f 1e fa          	endbr64
    1034:	68 00 00 00 00       	push   $0x0
    1039:	e9 e2 ff ff ff       	jmp    1020 <_init+0x20>
    103e:	66 90                	xchg   %ax,%ax
    1040:	f3 0f 1e fa          	endbr64
    1044:	68 01 00 00 00       	push   $0x1
    1049:	e9 d2 ff ff ff       	jmp    1020 <_init+0x20>
    104e:	66 90                	xchg   %ax,%ax
    1050:	f3 0f 1e fa          	endbr64
    1054:	68 02 00 00 00       	push   $0x2
    1059:	e9 c2 ff ff ff       	jmp    1020 <_init+0x20>
    105e:	66 90                	xchg   %ax,%ax
    1060:	f3 0f 1e fa          	endbr64
    1064:	68 03 00 00 00       	push   $0x3
    1069:	e9 b2 ff ff ff       	jmp    1020 <_init+0x20>
    106e:	66 90                	xchg   %ax,%ax
    1070:	f3 0f 1e fa          	endbr64
    1074:	68 04 00 00 00       	push   $0x4
    1079:	e9 a2 ff ff ff       	jmp    1020 <_init+0x20>
    107e:	66 90                	xchg   %ax,%ax
    1080:	f3 0f 1e fa          	endbr64
    1084:	68 05 00 00 00       	push   $0x5
    1089:	e9 92 ff ff ff       	jmp    1020 <_init+0x20>
    108e:	66 90                	xchg   %ax,%ax
    1090:	f3 0f 1e fa          	endbr64
    1094:	68 06 00 00 00       	push   $0x6
    1099:	e9 82 ff ff ff       	jmp    1020 <_init+0x20>
    109e:	66 90                	xchg   %ax,%ax
    10a0:	f3 0f 1e fa          	endbr64
    10a4:	68 07 00 00 00       	push   $0x7
    10a9:	e9 72 ff ff ff       	jmp    1020 <_init+0x20>
    10ae:	66 90                	xchg   %ax,%ax
    10b0:	f3 0f 1e fa          	endbr64
    10b4:	68 08 00 00 00       	push   $0x8
    10b9:	e9 62 ff ff ff       	jmp    1020 <_init+0x20>
    10be:	66 90                	xchg   %ax,%ax
    10c0:	f3 0f 1e fa          	endbr64
    10c4:	68 09 00 00 00       	push   $0x9
    10c9:	e9 52 ff ff ff       	jmp    1020 <_init+0x20>
    10ce:	66 90                	xchg   %ax,%ax

Disassembly of section .plt.got:

00000000000010d0 <__cxa_finalize@plt>:
    10d0:	f3 0f 1e fa          	endbr64
    10d4:	ff 25 1e 2f 00 00    	jmp    *0x2f1e(%rip)        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    10da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

Disassembly of section .plt.sec:

00000000000010e0 <clock_gettime@plt>:
    10e0:	f3 0f 1e fa          	endbr64
    10e4:	ff 25 9e 2e 00 00    	jmp    *0x2e9e(%rip)        # 3f88 <clock_gettime@GLIBC_2.17>
    10ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000010f0 <__stack_chk_fail@plt>:
    10f0:	f3 0f 1e fa          	endbr64
    10f4:	ff 25 96 2e 00 00    	jmp    *0x2e96(%rip)        # 3f90 <__stack_chk_fail@GLIBC_2.4>
    10fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001100 <__assert_fail@plt>:
    1100:	f3 0f 1e fa          	endbr64
    1104:	ff 25 8e 2e 00 00    	jmp    *0x2e8e(%rip)        # 3f98 <__assert_fail@GLIBC_2.2.5>
    110a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001110 <logf@plt>:
    1110:	f3 0f 1e fa          	endbr64
    1114:	ff 25 86 2e 00 00    	jmp    *0x2e86(%rip)        # 3fa0 <logf@GLIBC_2.27>
    111a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001120 <srand@plt>:
    1120:	f3 0f 1e fa          	endbr64
    1124:	ff 25 7e 2e 00 00    	jmp    *0x2e7e(%rip)        # 3fa8 <srand@GLIBC_2.2.5>
    112a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001130 <time@plt>:
    1130:	f3 0f 1e fa          	endbr64
    1134:	ff 25 76 2e 00 00    	jmp    *0x2e76(%rip)        # 3fb0 <time@GLIBC_2.2.5>
    113a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001140 <sqrtf@plt>:
    1140:	f3 0f 1e fa          	endbr64
    1144:	ff 25 6e 2e 00 00    	jmp    *0x2e6e(%rip)        # 3fb8 <sqrtf@GLIBC_2.2.5>
    114a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001150 <__printf_chk@plt>:
    1150:	f3 0f 1e fa          	endbr64
    1154:	ff 25 66 2e 00 00    	jmp    *0x2e66(%rip)        # 3fc0 <__printf_chk@GLIBC_2.3.4>
    115a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001160 <sqrt@plt>:
    1160:	f3 0f 1e fa          	endbr64
    1164:	ff 25 5e 2e 00 00    	jmp    *0x2e5e(%rip)        # 3fc8 <sqrt@GLIBC_2.2.5>
    116a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001170 <rand@plt>:
    1170:	f3 0f 1e fa          	endbr64
    1174:	ff 25 56 2e 00 00    	jmp    *0x2e56(%rip)        # 3fd0 <rand@GLIBC_2.2.5>
    117a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

Disassembly of section .text:

0000000000001180 <main>:
    1180:	f3 0f 1e fa          	endbr64
    1184:	41 57                	push   %r15
    1186:	4c 8d 05 93 2e 00 00 	lea    0x2e93(%rip),%r8        # 4020 <t3>
    118d:	48 8d 0d ec 2e 00 00 	lea    0x2eec(%rip),%rcx        # 4080 <t2>
    1194:	bf 02 00 00 00       	mov    $0x2,%edi
    1199:	48 8d 15 40 2f 00 00 	lea    0x2f40(%rip),%rdx        # 40e0 <t1>
    11a0:	48 8d 35 8d 0e 00 00 	lea    0xe8d(%rip),%rsi        # 2034 <_IO_stdin_used+0x34>
    11a7:	31 c0                	xor    %eax,%eax
    11a9:	41 56                	push   %r14
    11ab:	41 55                	push   %r13
    11ad:	41 54                	push   %r12
    11af:	41 bc 00 80 00 00    	mov    $0x8000,%r12d
    11b5:	55                   	push   %rbp
    11b6:	48 8d 2d 83 2f 00 00 	lea    0x2f83(%rip),%rbp        # 4140 <heat2>
    11bd:	53                   	push   %rbx
    11be:	48 8d 1d 1b 31 00 00 	lea    0x311b(%rip),%rbx        # 42e0 <heat>
    11c5:	48 83 ec 18          	sub    $0x18,%rsp
    11c9:	e8 82 ff ff ff       	call   1150 <__printf_chk@plt>
    11ce:	c5 fb 10 05 52 0f 00 	vmovsd 0xf52(%rip),%xmm0        # 2128 <__PRETTY_FUNCTION__.0+0xa>
    11d5:	00 
    11d6:	48 8d 35 67 0e 00 00 	lea    0xe67(%rip),%rsi        # 2044 <_IO_stdin_used+0x44>
    11dd:	bf 02 00 00 00       	mov    $0x2,%edi
    11e2:	b8 01 00 00 00       	mov    $0x1,%eax
    11e7:	e8 64 ff ff ff       	call   1150 <__printf_chk@plt>
    11ec:	c5 fb 10 05 3c 0f 00 	vmovsd 0xf3c(%rip),%xmm0        # 2130 <__PRETTY_FUNCTION__.0+0x12>
    11f3:	00 
    11f4:	48 8d 35 62 0e 00 00 	lea    0xe62(%rip),%rsi        # 205d <_IO_stdin_used+0x5d>
    11fb:	bf 02 00 00 00       	mov    $0x2,%edi
    1200:	b8 01 00 00 00       	mov    $0x1,%eax
    1205:	e8 46 ff ff ff       	call   1150 <__printf_chk@plt>
    120a:	ba 00 80 00 00       	mov    $0x8000,%edx
    120f:	48 8d 35 60 0e 00 00 	lea    0xe60(%rip),%rsi        # 2076 <_IO_stdin_used+0x76>
    1216:	bf 02 00 00 00       	mov    $0x2,%edi
    121b:	31 c0                	xor    %eax,%eax
    121d:	e8 2e ff ff ff       	call   1150 <__printf_chk@plt>
    1222:	31 ff                	xor    %edi,%edi
    1224:	e8 07 ff ff ff       	call   1130 <time@plt>
    1229:	89 c7                	mov    %eax,%edi
    122b:	e8 f0 fe ff ff       	call   1120 <srand@plt>
    1230:	e8 cb 02 00 00       	call   1500 <wtime>
    1235:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
    123b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    1240:	48 89 ee             	mov    %rbp,%rsi
    1243:	48 89 df             	mov    %rbx,%rdi
    1246:	e8 15 03 00 00       	call   1560 <photon>
    124b:	41 ff cc             	dec    %r12d
    124e:	75 f0                	jne    1240 <main+0xc0>
    1250:	e8 ab 02 00 00       	call   1500 <wtime>
    1255:	c5 f9 2f 44 24 08    	vcomisd 0x8(%rsp),%xmm0
    125b:	0f 82 8b 01 00 00    	jb     13ec <main+0x26c>
    1261:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
    1267:	48 8d 35 35 0e 00 00 	lea    0xe35(%rip),%rsi        # 20a3 <_IO_stdin_used+0xa3>
    126e:	bf 02 00 00 00       	mov    $0x2,%edi
    1273:	b8 01 00 00 00       	mov    $0x1,%eax
    1278:	45 31 f6             	xor    %r14d,%r14d
    127b:	4c 8d 2d 77 0e 00 00 	lea    0xe77(%rip),%r13        # 20f9 <_IO_stdin_used+0xf9>
    1282:	45 31 e4             	xor    %r12d,%r12d
    1285:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
    128b:	e8 c0 fe ff ff       	call   1150 <__printf_chk@plt>
    1290:	c5 fb 10 0d a0 0e 00 	vmovsd 0xea0(%rip),%xmm1        # 2138 <__PRETTY_FUNCTION__.0+0x1a>
    1297:	00 
    1298:	c5 fb 10 44 24 08    	vmovsd 0x8(%rsp),%xmm0
    129e:	48 8d 35 0d 0e 00 00 	lea    0xe0d(%rip),%rsi        # 20b2 <_IO_stdin_used+0xb2>
    12a5:	bf 02 00 00 00       	mov    $0x2,%edi
    12aa:	b8 01 00 00 00       	mov    $0x1,%eax
    12af:	c5 f3 5e c0          	vdivsd %xmm0,%xmm1,%xmm0
    12b3:	e8 98 fe ff ff       	call   1150 <__printf_chk@plt>
    12b8:	48 8d 35 0f 0e 00 00 	lea    0xe0f(%rip),%rsi        # 20ce <_IO_stdin_used+0xce>
    12bf:	bf 02 00 00 00       	mov    $0x2,%edi
    12c4:	31 c0                	xor    %eax,%eax
    12c6:	e8 85 fe ff ff       	call   1150 <__printf_chk@plt>
    12cb:	48 8d 35 0b 0e 00 00 	lea    0xe0b(%rip),%rsi        # 20dd <_IO_stdin_used+0xdd>
    12d2:	bf 02 00 00 00       	mov    $0x2,%edi
    12d7:	31 c0                	xor    %eax,%eax
    12d9:	e8 72 fe ff ff       	call   1150 <__printf_chk@plt>
    12de:	c5 d0 57 ed          	vxorps %xmm5,%xmm5,%xmm5
    12e2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    12e8:	c4 a1 7a 10 0c b3    	vmovss (%rbx,%r14,4),%xmm1
    12ee:	c4 a1 7a 10 44 b5 00 	vmovss 0x0(%rbp,%r14,4),%xmm0
    12f5:	c4 c1 f9 6e f4       	vmovq  %r12,%xmm6
    12fa:	45 89 f7             	mov    %r14d,%r15d
    12fd:	c5 f2 59 d1          	vmulss %xmm1,%xmm1,%xmm2
    1301:	c5 ea 59 15 fb 0c 00 	vmulss 0xcfb(%rip),%xmm2,%xmm2        # 2004 <_IO_stdin_used+0x4>
    1308:	00 
    1309:	c5 fa 5c c2          	vsubss %xmm2,%xmm0,%xmm0
    130d:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
    1311:	c5 f9 2e f0          	vucomisd %xmm0,%xmm6
    1315:	0f 87 b7 00 00 00    	ja     13d2 <main+0x252>
    131b:	c5 fb 51 c0          	vsqrtsd %xmm0,%xmm0,%xmm0
    131f:	c5 f2 5e 0d e5 0c 00 	vdivss 0xce5(%rip),%xmm1,%xmm1        # 200c <_IO_stdin_used+0xc>
    1326:	00 
    1327:	c5 f2 5a e1          	vcvtss2sd %xmm1,%xmm1,%xmm4
    132b:	c5 fb 5e 05 0d 0e 00 	vdivsd 0xe0d(%rip),%xmm0,%xmm0        # 2140 <__PRETTY_FUNCTION__.0+0x22>
    1332:	00 
    1333:	c4 c1 52 2a de       	vcvtsi2ss %r14d,%xmm5,%xmm3
    1338:	41 8d 47 01          	lea    0x1(%r15),%eax
    133c:	4c 89 ee             	mov    %r13,%rsi
    133f:	bf 02 00 00 00       	mov    $0x2,%edi
    1344:	49 ff c6             	inc    %r14
    1347:	41 0f af c7          	imul   %r15d,%eax
    134b:	c5 e2 59 1d bd 0c 00 	vmulss 0xcbd(%rip),%xmm3,%xmm3        # 2010 <_IO_stdin_used+0x10>
    1352:	00 
    1353:	c5 d2 2a d0          	vcvtsi2ss %eax,%xmm5,%xmm2
    1357:	c5 d3 2a c8          	vcvtsi2sd %eax,%xmm5,%xmm1
    135b:	b8 03 00 00 00       	mov    $0x3,%eax
    1360:	c5 ea 58 15 a0 0c 00 	vaddss 0xca0(%rip),%xmm2,%xmm2        # 2008 <_IO_stdin_used+0x8>
    1367:	00 
    1368:	c5 e2 5a db          	vcvtss2sd %xmm3,%xmm3,%xmm3
    136c:	c5 f3 58 0d d4 0d 00 	vaddsd 0xdd4(%rip),%xmm1,%xmm1        # 2148 <__PRETTY_FUNCTION__.0+0x2a>
    1373:	00 
    1374:	c5 ea 5a d2          	vcvtss2sd %xmm2,%xmm2,%xmm2
    1378:	c5 fb 5e d2          	vdivsd %xmm2,%xmm0,%xmm2
    137c:	c5 e3 10 c3          	vmovsd %xmm3,%xmm3,%xmm0
    1380:	c5 db 5e c9          	vdivsd %xmm1,%xmm4,%xmm1
    1384:	e8 c7 fd ff ff       	call   1150 <__printf_chk@plt>
    1389:	49 83 fe 64          	cmp    $0x64,%r14
    138d:	c5 d0 57 ed          	vxorps %xmm5,%xmm5,%xmm5
    1391:	0f 85 51 ff ff ff    	jne    12e8 <main+0x168>
    1397:	c5 fa 10 3d 65 0c 00 	vmovss 0xc65(%rip),%xmm7        # 2004 <_IO_stdin_used+0x4>
    139e:	00 
    139f:	48 8d 35 68 0d 00 00 	lea    0xd68(%rip),%rsi        # 210e <_IO_stdin_used+0x10e>
    13a6:	bf 02 00 00 00       	mov    $0x2,%edi
    13ab:	b8 01 00 00 00       	mov    $0x1,%eax
    13b0:	c5 c2 59 05 b8 30 00 	vmulss 0x30b8(%rip),%xmm7,%xmm0        # 4470 <heat+0x190>
    13b7:	00 
    13b8:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
    13bc:	e8 8f fd ff ff       	call   1150 <__printf_chk@plt>
    13c1:	48 83 c4 18          	add    $0x18,%rsp
    13c5:	31 c0                	xor    %eax,%eax
    13c7:	5b                   	pop    %rbx
    13c8:	5d                   	pop    %rbp
    13c9:	41 5c                	pop    %r12
    13cb:	41 5d                	pop    %r13
    13cd:	41 5e                	pop    %r14
    13cf:	41 5f                	pop    %r15
    13d1:	c3                   	ret
    13d2:	c5 fa 11 4c 24 08    	vmovss %xmm1,0x8(%rsp)
    13d8:	e8 83 fd ff ff       	call   1160 <sqrt@plt>
    13dd:	c5 fa 10 4c 24 08    	vmovss 0x8(%rsp),%xmm1
    13e3:	c5 d0 57 ed          	vxorps %xmm5,%xmm5,%xmm5
    13e7:	e9 33 ff ff ff       	jmp    131f <main+0x19f>
    13ec:	48 8d 0d 2b 0d 00 00 	lea    0xd2b(%rip),%rcx        # 211e <__PRETTY_FUNCTION__.0>
    13f3:	ba 34 00 00 00       	mov    $0x34,%edx
    13f8:	48 8d 35 8d 0c 00 00 	lea    0xc8d(%rip),%rsi        # 208c <_IO_stdin_used+0x8c>
    13ff:	48 8d 3d 90 0c 00 00 	lea    0xc90(%rip),%rdi        # 2096 <_IO_stdin_used+0x96>
    1406:	e8 f5 fc ff ff       	call   1100 <__assert_fail@plt>
    140b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001410 <_start>:
    1410:	f3 0f 1e fa          	endbr64
    1414:	31 ed                	xor    %ebp,%ebp
    1416:	49 89 d1             	mov    %rdx,%r9
    1419:	5e                   	pop    %rsi
    141a:	48 89 e2             	mov    %rsp,%rdx
    141d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    1421:	50                   	push   %rax
    1422:	54                   	push   %rsp
    1423:	45 31 c0             	xor    %r8d,%r8d
    1426:	31 c9                	xor    %ecx,%ecx
    1428:	48 8d 3d 51 fd ff ff 	lea    -0x2af(%rip),%rdi        # 1180 <main>
    142f:	ff 15 a3 2b 00 00    	call   *0x2ba3(%rip)        # 3fd8 <__libc_start_main@GLIBC_2.34>
    1435:	f4                   	hlt
    1436:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    143d:	00 00 00 

0000000000001440 <deregister_tm_clones>:
    1440:	48 8d 3d d1 2c 00 00 	lea    0x2cd1(%rip),%rdi        # 4118 <__TMC_END__>
    1447:	48 8d 05 ca 2c 00 00 	lea    0x2cca(%rip),%rax        # 4118 <__TMC_END__>
    144e:	48 39 f8             	cmp    %rdi,%rax
    1451:	74 15                	je     1468 <deregister_tm_clones+0x28>
    1453:	48 8b 05 86 2b 00 00 	mov    0x2b86(%rip),%rax        # 3fe0 <_ITM_deregisterTMCloneTable@Base>
    145a:	48 85 c0             	test   %rax,%rax
    145d:	74 09                	je     1468 <deregister_tm_clones+0x28>
    145f:	ff e0                	jmp    *%rax
    1461:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1468:	c3                   	ret
    1469:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001470 <register_tm_clones>:
    1470:	48 8d 3d a1 2c 00 00 	lea    0x2ca1(%rip),%rdi        # 4118 <__TMC_END__>
    1477:	48 8d 35 9a 2c 00 00 	lea    0x2c9a(%rip),%rsi        # 4118 <__TMC_END__>
    147e:	48 29 fe             	sub    %rdi,%rsi
    1481:	48 89 f0             	mov    %rsi,%rax
    1484:	48 c1 ee 3f          	shr    $0x3f,%rsi
    1488:	48 c1 f8 03          	sar    $0x3,%rax
    148c:	48 01 c6             	add    %rax,%rsi
    148f:	48 d1 fe             	sar    $1,%rsi
    1492:	74 14                	je     14a8 <register_tm_clones+0x38>
    1494:	48 8b 05 55 2b 00 00 	mov    0x2b55(%rip),%rax        # 3ff0 <_ITM_registerTMCloneTable@Base>
    149b:	48 85 c0             	test   %rax,%rax
    149e:	74 08                	je     14a8 <register_tm_clones+0x38>
    14a0:	ff e0                	jmp    *%rax
    14a2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    14a8:	c3                   	ret
    14a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000014b0 <__do_global_dtors_aux>:
    14b0:	f3 0f 1e fa          	endbr64
    14b4:	80 3d 65 2c 00 00 00 	cmpb   $0x0,0x2c65(%rip)        # 4120 <completed.0>
    14bb:	75 2b                	jne    14e8 <__do_global_dtors_aux+0x38>
    14bd:	55                   	push   %rbp
    14be:	48 83 3d 32 2b 00 00 	cmpq   $0x0,0x2b32(%rip)        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    14c5:	00 
    14c6:	48 89 e5             	mov    %rsp,%rbp
    14c9:	74 0c                	je     14d7 <__do_global_dtors_aux+0x27>
    14cb:	48 8b 3d 36 2b 00 00 	mov    0x2b36(%rip),%rdi        # 4008 <__dso_handle>
    14d2:	e8 f9 fb ff ff       	call   10d0 <__cxa_finalize@plt>
    14d7:	e8 64 ff ff ff       	call   1440 <deregister_tm_clones>
    14dc:	c6 05 3d 2c 00 00 01 	movb   $0x1,0x2c3d(%rip)        # 4120 <completed.0>
    14e3:	5d                   	pop    %rbp
    14e4:	c3                   	ret
    14e5:	0f 1f 00             	nopl   (%rax)
    14e8:	c3                   	ret
    14e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000014f0 <frame_dummy>:
    14f0:	f3 0f 1e fa          	endbr64
    14f4:	e9 77 ff ff ff       	jmp    1470 <register_tm_clones>
    14f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001500 <wtime>:
    1500:	f3 0f 1e fa          	endbr64
    1504:	48 83 ec 28          	sub    $0x28,%rsp
    1508:	bf 04 00 00 00       	mov    $0x4,%edi
    150d:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    1514:	00 00 
    1516:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    151b:	31 c0                	xor    %eax,%eax
    151d:	48 89 e6             	mov    %rsp,%rsi
    1520:	e8 bb fb ff ff       	call   10e0 <clock_gettime@plt>
    1525:	c5 f0 57 c9          	vxorps %xmm1,%xmm1,%xmm1
    1529:	c4 e1 f3 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm1,%xmm0
    1530:	c4 e1 f3 2a 0c 24    	vcvtsi2sdq (%rsp),%xmm1,%xmm1
    1536:	c5 fb 59 05 12 0c 00 	vmulsd 0xc12(%rip),%xmm0,%xmm0        # 2150 <__PRETTY_FUNCTION__.0+0x32>
    153d:	00 
    153e:	c5 fb 58 c1          	vaddsd %xmm1,%xmm0,%xmm0
    1542:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    1547:	64 48 2b 04 25 28 00 	sub    %fs:0x28,%rax
    154e:	00 00 
    1550:	75 05                	jne    1557 <wtime+0x57>
    1552:	48 83 c4 28          	add    $0x28,%rsp
    1556:	c3                   	ret
    1557:	e8 94 fb ff ff       	call   10f0 <__stack_chk_fail@plt>
    155c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000001560 <photon>:
    1560:	f3 0f 1e fa          	endbr64
    1564:	41 55                	push   %r13
    1566:	c5 d0 57 ed          	vxorps %xmm5,%xmm5,%xmm5
    156a:	41 bd 00 00 80 3f    	mov    $0x3f800000,%r13d
    1570:	41 54                	push   %r12
    1572:	45 31 e4             	xor    %r12d,%r12d
    1575:	55                   	push   %rbp
    1576:	48 89 fd             	mov    %rdi,%rbp
    1579:	53                   	push   %rbx
    157a:	48 89 f3             	mov    %rsi,%rbx
    157d:	48 83 ec 28          	sub    $0x28,%rsp
    1581:	c5 fa 10 25 8b 0a 00 	vmovss 0xa8b(%rip),%xmm4        # 2014 <_IO_stdin_used+0x14>
    1588:	00 
    1589:	c5 fa 11 6c 24 0c    	vmovss %xmm5,0xc(%rsp)
    158f:	c5 fa 11 6c 24 08    	vmovss %xmm5,0x8(%rsp)
    1595:	c5 fa 11 6c 24 04    	vmovss %xmm5,0x4(%rsp)
    159b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    15a0:	c5 fa 11 64 24 10    	vmovss %xmm4,0x10(%rsp)
    15a6:	c5 fa 11 2c 24       	vmovss %xmm5,(%rsp)
    15ab:	e8 c0 fb ff ff       	call   1170 <rand@plt>
    15b0:	c5 c0 57 ff          	vxorps %xmm7,%xmm7,%xmm7
    15b4:	c5 c2 2a c0          	vcvtsi2ss %eax,%xmm7,%xmm0
    15b8:	c5 fa 59 05 58 0a 00 	vmulss 0xa58(%rip),%xmm0,%xmm0        # 2018 <_IO_stdin_used+0x18>
    15bf:	00 
    15c0:	e8 4b fb ff ff       	call   1110 <logf@plt>
    15c5:	c5 fa 10 2c 24       	vmovss (%rsp),%xmm5
    15ca:	c4 c1 79 6e e5       	vmovd  %r13d,%xmm4
    15cf:	ba 64 00 00 00       	mov    $0x64,%edx
    15d4:	c5 f8 57 05 84 0b 00 	vxorps 0xb84(%rip),%xmm0,%xmm0        # 2160 <__PRETTY_FUNCTION__.0+0x42>
    15db:	00 
    15dc:	c5 d2 59 e8          	vmulss %xmm0,%xmm5,%xmm5
    15e0:	c5 da 59 c8          	vmulss %xmm0,%xmm4,%xmm1
    15e4:	c5 d2 58 7c 24 04    	vaddss 0x4(%rsp),%xmm5,%xmm7
    15ea:	c4 c1 79 6e ec       	vmovd  %r12d,%xmm5
    15ef:	c5 d2 59 d0          	vmulss %xmm0,%xmm5,%xmm2
    15f3:	c5 f2 58 64 24 0c    	vaddss 0xc(%rsp),%xmm1,%xmm4
    15f9:	c5 c2 59 c7          	vmulss %xmm7,%xmm7,%xmm0
    15fd:	c5 fa 11 7c 24 04    	vmovss %xmm7,0x4(%rsp)
    1603:	c5 fa 11 64 24 0c    	vmovss %xmm4,0xc(%rsp)
    1609:	c5 ea 58 6c 24 08    	vaddss 0x8(%rsp),%xmm2,%xmm5
    160f:	c5 d2 59 cd          	vmulss %xmm5,%xmm5,%xmm1
    1613:	c5 fa 11 6c 24 08    	vmovss %xmm5,0x8(%rsp)
    1619:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
    161d:	c5 da 59 cc          	vmulss %xmm4,%xmm4,%xmm1
    1621:	c5 fa 10 64 24 10    	vmovss 0x10(%rsp),%xmm4
    1627:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
    162b:	c5 fa 51 c0          	vsqrtss %xmm0,%xmm0,%xmm0
    162f:	c5 fa 59 05 e5 09 00 	vmulss 0x9e5(%rip),%xmm0,%xmm0        # 201c <_IO_stdin_used+0x1c>
    1636:	00 
    1637:	c4 e1 fa 2c c0       	vcvttss2si %xmm0,%rax
    163c:	c5 da 59 05 dc 09 00 	vmulss 0x9dc(%rip),%xmm4,%xmm0        # 2020 <_IO_stdin_used+0x20>
    1643:	00 
    1644:	39 d0                	cmp    %edx,%eax
    1646:	0f 47 c2             	cmova  %edx,%eax
    1649:	89 c0                	mov    %eax,%eax
    164b:	48 c1 e0 02          	shl    $0x2,%rax
    164f:	48 8d 54 05 00       	lea    0x0(%rbp,%rax,1),%rdx
    1654:	48 01 d8             	add    %rbx,%rax
    1657:	c5 fa 58 02          	vaddss (%rdx),%xmm0,%xmm0
    165b:	c5 fa 11 02          	vmovss %xmm0,(%rdx)
    165f:	c5 da 59 05 bd 09 00 	vmulss 0x9bd(%rip),%xmm4,%xmm0        # 2024 <_IO_stdin_used+0x24>
    1666:	00 
    1667:	c5 fa 59 c4          	vmulss %xmm4,%xmm0,%xmm0
    166b:	c5 da 59 25 b5 09 00 	vmulss 0x9b5(%rip),%xmm4,%xmm4        # 2028 <_IO_stdin_used+0x28>
    1672:	00 
    1673:	c5 fa 58 00          	vaddss (%rax),%xmm0,%xmm0
    1677:	c5 fa 11 64 24 10    	vmovss %xmm4,0x10(%rsp)
    167d:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    1681:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1688:	e8 e3 fa ff ff       	call   1170 <rand@plt>
    168d:	c5 c8 57 f6          	vxorps %xmm6,%xmm6,%xmm6
    1691:	c5 ca 2a d0          	vcvtsi2ss %eax,%xmm6,%xmm2
    1695:	c5 ea 58 d2          	vaddss %xmm2,%xmm2,%xmm2
    1699:	c5 ea 59 15 77 09 00 	vmulss 0x977(%rip),%xmm2,%xmm2        # 2018 <_IO_stdin_used+0x18>
    16a0:	00 
    16a1:	c5 ea 5c 15 6b 09 00 	vsubss 0x96b(%rip),%xmm2,%xmm2        # 2014 <_IO_stdin_used+0x14>
    16a8:	00 
    16a9:	c5 fa 11 14 24       	vmovss %xmm2,(%rsp)
    16ae:	e8 bd fa ff ff       	call   1170 <rand@plt>
    16b3:	c5 c8 57 f6          	vxorps %xmm6,%xmm6,%xmm6
    16b7:	c5 fa 10 14 24       	vmovss (%rsp),%xmm2
    16bc:	c5 ca 2a c8          	vcvtsi2ss %eax,%xmm6,%xmm1
    16c0:	c5 ea 59 c2          	vmulss %xmm2,%xmm2,%xmm0
    16c4:	c5 f2 58 c9          	vaddss %xmm1,%xmm1,%xmm1
    16c8:	c5 f2 59 0d 48 09 00 	vmulss 0x948(%rip),%xmm1,%xmm1        # 2018 <_IO_stdin_used+0x18>
    16cf:	00 
    16d0:	c5 f2 5c 0d 3c 09 00 	vsubss 0x93c(%rip),%xmm1,%xmm1        # 2014 <_IO_stdin_used+0x14>
    16d7:	00 
    16d8:	c5 f2 59 d9          	vmulss %xmm1,%xmm1,%xmm3
    16dc:	c5 fa 58 c3          	vaddss %xmm3,%xmm0,%xmm0
    16e0:	c5 f8 2f 05 2c 09 00 	vcomiss 0x92c(%rip),%xmm0        # 2014 <_IO_stdin_used+0x14>
    16e7:	00 
    16e8:	77 9e                	ja     1688 <photon+0x128>
    16ea:	c5 fa 58 e8          	vaddss %xmm0,%xmm0,%xmm5
    16ee:	c5 fa 10 3d 1e 09 00 	vmovss 0x91e(%rip),%xmm7        # 2014 <_IO_stdin_used+0x14>
    16f5:	00 
    16f6:	c5 fa 10 64 24 10    	vmovss 0x10(%rsp),%xmm4
    16fc:	c5 d2 5c 2d 10 09 00 	vsubss 0x910(%rip),%xmm5,%xmm5        # 2014 <_IO_stdin_used+0x14>
    1703:	00 
    1704:	c5 d2 59 dd          	vmulss %xmm5,%xmm5,%xmm3
    1708:	c5 c2 5c db          	vsubss %xmm3,%xmm7,%xmm3
    170c:	c5 e2 5e d8          	vdivss %xmm0,%xmm3,%xmm3
    1710:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
    1714:	c5 f8 2e c3          	vucomiss %xmm3,%xmm0
    1718:	77 75                	ja     178f <photon+0x22f>
    171a:	c5 e2 51 db          	vsqrtss %xmm3,%xmm3,%xmm3
    171e:	c5 ea 59 fb          	vmulss %xmm3,%xmm2,%xmm7
    1722:	c4 c1 79 7e fc       	vmovd  %xmm7,%r12d
    1727:	c5 f2 59 fb          	vmulss %xmm3,%xmm1,%xmm7
    172b:	c4 c1 79 7e fd       	vmovd  %xmm7,%r13d
    1730:	c5 fa 10 3d f4 08 00 	vmovss 0x8f4(%rip),%xmm7        # 202c <_IO_stdin_used+0x2c>
    1737:	00 
    1738:	c5 f8 2f fc          	vcomiss %xmm4,%xmm7
    173c:	0f 86 5e fe ff ff    	jbe    15a0 <photon+0x40>
    1742:	c5 fa 11 64 24 10    	vmovss %xmm4,0x10(%rsp)
    1748:	c5 fa 11 2c 24       	vmovss %xmm5,(%rsp)
    174d:	e8 1e fa ff ff       	call   1170 <rand@plt>
    1752:	c5 c0 57 ff          	vxorps %xmm7,%xmm7,%xmm7
    1756:	c5 c2 2a c0          	vcvtsi2ss %eax,%xmm7,%xmm0
    175a:	c5 fa 59 05 b6 08 00 	vmulss 0x8b6(%rip),%xmm0,%xmm0        # 2018 <_IO_stdin_used+0x18>
    1761:	00 
    1762:	c5 f8 2f 05 c6 08 00 	vcomiss 0x8c6(%rip),%xmm0        # 2030 <_IO_stdin_used+0x30>
    1769:	00 
    176a:	77 18                	ja     1784 <photon+0x224>
    176c:	c5 fa 10 64 24 10    	vmovss 0x10(%rsp),%xmm4
    1772:	c5 fa 10 2c 24       	vmovss (%rsp),%xmm5
    1777:	c5 da 5e 25 b1 08 00 	vdivss 0x8b1(%rip),%xmm4,%xmm4        # 2030 <_IO_stdin_used+0x30>
    177e:	00 
    177f:	e9 1c fe ff ff       	jmp    15a0 <photon+0x40>
    1784:	48 83 c4 28          	add    $0x28,%rsp
    1788:	5b                   	pop    %rbx
    1789:	5d                   	pop    %rbp
    178a:	41 5c                	pop    %r12
    178c:	41 5d                	pop    %r13
    178e:	c3                   	ret
    178f:	c5 f8 28 c3          	vmovaps %xmm3,%xmm0
    1793:	c5 fa 11 64 24 1c    	vmovss %xmm4,0x1c(%rsp)
    1799:	c5 fa 11 4c 24 14    	vmovss %xmm1,0x14(%rsp)
    179f:	c5 fa 11 6c 24 18    	vmovss %xmm5,0x18(%rsp)
    17a5:	c5 fa 11 54 24 10    	vmovss %xmm2,0x10(%rsp)
    17ab:	c5 fa 11 1c 24       	vmovss %xmm3,(%rsp)
    17b0:	e8 8b f9 ff ff       	call   1140 <sqrtf@plt>
    17b5:	c5 fa 10 54 24 10    	vmovss 0x10(%rsp),%xmm2
    17bb:	c5 fa 10 1c 24       	vmovss (%rsp),%xmm3
    17c0:	c5 fa 59 ea          	vmulss %xmm2,%xmm0,%xmm5
    17c4:	c5 f8 28 c3          	vmovaps %xmm3,%xmm0
    17c8:	c4 c1 79 7e ec       	vmovd  %xmm5,%r12d
    17cd:	e8 6e f9 ff ff       	call   1140 <sqrtf@plt>
    17d2:	c5 fa 10 64 24 1c    	vmovss 0x1c(%rsp),%xmm4
    17d8:	c5 fa 10 6c 24 18    	vmovss 0x18(%rsp),%xmm5
    17de:	c5 fa 10 4c 24 14    	vmovss 0x14(%rsp),%xmm1
    17e4:	c5 f8 28 d8          	vmovaps %xmm0,%xmm3
    17e8:	e9 3a ff ff ff       	jmp    1727 <photon+0x1c7>

Disassembly of section .fini:

00000000000017f0 <_fini>:
    17f0:	f3 0f 1e fa          	endbr64
    17f4:	48 83 ec 08          	sub    $0x8,%rsp
    17f8:	48 83 c4 08          	add    $0x8,%rsp
    17fc:	c3                   	ret

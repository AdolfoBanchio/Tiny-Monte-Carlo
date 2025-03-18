
headless:     file format elf64-x86-64


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
    1020:	ff 35 4a 2f 00 00    	push   0x2f4a(%rip)        # 3f70 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	ff 25 4c 2f 00 00    	jmp    *0x2f4c(%rip)        # 3f78 <_GLOBAL_OFFSET_TABLE_+0x10>
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
    10d0:	f3 0f 1e fa          	endbr64
    10d4:	68 0a 00 00 00       	push   $0xa
    10d9:	e9 42 ff ff ff       	jmp    1020 <_init+0x20>
    10de:	66 90                	xchg   %ax,%ax

Disassembly of section .plt.got:

00000000000010e0 <__cxa_finalize@plt>:
    10e0:	f3 0f 1e fa          	endbr64
    10e4:	ff 25 0e 2f 00 00    	jmp    *0x2f0e(%rip)        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    10ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

Disassembly of section .plt.sec:

00000000000010f0 <puts@plt>:
    10f0:	f3 0f 1e fa          	endbr64
    10f4:	ff 25 86 2e 00 00    	jmp    *0x2e86(%rip)        # 3f80 <puts@GLIBC_2.2.5>
    10fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001100 <clock_gettime@plt>:
    1100:	f3 0f 1e fa          	endbr64
    1104:	ff 25 7e 2e 00 00    	jmp    *0x2e7e(%rip)        # 3f88 <clock_gettime@GLIBC_2.17>
    110a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001110 <__stack_chk_fail@plt>:
    1110:	f3 0f 1e fa          	endbr64
    1114:	ff 25 76 2e 00 00    	jmp    *0x2e76(%rip)        # 3f90 <__stack_chk_fail@GLIBC_2.4>
    111a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001120 <printf@plt>:
    1120:	f3 0f 1e fa          	endbr64
    1124:	ff 25 6e 2e 00 00    	jmp    *0x2e6e(%rip)        # 3f98 <printf@GLIBC_2.2.5>
    112a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001130 <__assert_fail@plt>:
    1130:	f3 0f 1e fa          	endbr64
    1134:	ff 25 66 2e 00 00    	jmp    *0x2e66(%rip)        # 3fa0 <__assert_fail@GLIBC_2.2.5>
    113a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001140 <logf@plt>:
    1140:	f3 0f 1e fa          	endbr64
    1144:	ff 25 5e 2e 00 00    	jmp    *0x2e5e(%rip)        # 3fa8 <logf@GLIBC_2.27>
    114a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001150 <srand@plt>:
    1150:	f3 0f 1e fa          	endbr64
    1154:	ff 25 56 2e 00 00    	jmp    *0x2e56(%rip)        # 3fb0 <srand@GLIBC_2.2.5>
    115a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001160 <time@plt>:
    1160:	f3 0f 1e fa          	endbr64
    1164:	ff 25 4e 2e 00 00    	jmp    *0x2e4e(%rip)        # 3fb8 <time@GLIBC_2.2.5>
    116a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001170 <sqrtf@plt>:
    1170:	f3 0f 1e fa          	endbr64
    1174:	ff 25 46 2e 00 00    	jmp    *0x2e46(%rip)        # 3fc0 <sqrtf@GLIBC_2.2.5>
    117a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001180 <sqrt@plt>:
    1180:	f3 0f 1e fa          	endbr64
    1184:	ff 25 3e 2e 00 00    	jmp    *0x2e3e(%rip)        # 3fc8 <sqrt@GLIBC_2.2.5>
    118a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001190 <rand@plt>:
    1190:	f3 0f 1e fa          	endbr64
    1194:	ff 25 36 2e 00 00    	jmp    *0x2e36(%rip)        # 3fd0 <rand@GLIBC_2.2.5>
    119a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

Disassembly of section .text:

00000000000011a0 <_start>:
    11a0:	f3 0f 1e fa          	endbr64
    11a4:	31 ed                	xor    %ebp,%ebp
    11a6:	49 89 d1             	mov    %rdx,%r9
    11a9:	5e                   	pop    %rsi
    11aa:	48 89 e2             	mov    %rsp,%rdx
    11ad:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    11b1:	50                   	push   %rax
    11b2:	54                   	push   %rsp
    11b3:	45 31 c0             	xor    %r8d,%r8d
    11b6:	31 c9                	xor    %ecx,%ecx
    11b8:	48 8d 3d ca 00 00 00 	lea    0xca(%rip),%rdi        # 1289 <main>
    11bf:	ff 15 13 2e 00 00    	call   *0x2e13(%rip)        # 3fd8 <__libc_start_main@GLIBC_2.34>
    11c5:	f4                   	hlt
    11c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    11cd:	00 00 00 

00000000000011d0 <deregister_tm_clones>:
    11d0:	48 8d 3d 39 2f 00 00 	lea    0x2f39(%rip),%rdi        # 4110 <__TMC_END__>
    11d7:	48 8d 05 32 2f 00 00 	lea    0x2f32(%rip),%rax        # 4110 <__TMC_END__>
    11de:	48 39 f8             	cmp    %rdi,%rax
    11e1:	74 15                	je     11f8 <deregister_tm_clones+0x28>
    11e3:	48 8b 05 f6 2d 00 00 	mov    0x2df6(%rip),%rax        # 3fe0 <_ITM_deregisterTMCloneTable@Base>
    11ea:	48 85 c0             	test   %rax,%rax
    11ed:	74 09                	je     11f8 <deregister_tm_clones+0x28>
    11ef:	ff e0                	jmp    *%rax
    11f1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    11f8:	c3                   	ret
    11f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001200 <register_tm_clones>:
    1200:	48 8d 3d 09 2f 00 00 	lea    0x2f09(%rip),%rdi        # 4110 <__TMC_END__>
    1207:	48 8d 35 02 2f 00 00 	lea    0x2f02(%rip),%rsi        # 4110 <__TMC_END__>
    120e:	48 29 fe             	sub    %rdi,%rsi
    1211:	48 89 f0             	mov    %rsi,%rax
    1214:	48 c1 ee 3f          	shr    $0x3f,%rsi
    1218:	48 c1 f8 03          	sar    $0x3,%rax
    121c:	48 01 c6             	add    %rax,%rsi
    121f:	48 d1 fe             	sar    $1,%rsi
    1222:	74 14                	je     1238 <register_tm_clones+0x38>
    1224:	48 8b 05 c5 2d 00 00 	mov    0x2dc5(%rip),%rax        # 3ff0 <_ITM_registerTMCloneTable@Base>
    122b:	48 85 c0             	test   %rax,%rax
    122e:	74 08                	je     1238 <register_tm_clones+0x38>
    1230:	ff e0                	jmp    *%rax
    1232:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1238:	c3                   	ret
    1239:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001240 <__do_global_dtors_aux>:
    1240:	f3 0f 1e fa          	endbr64
    1244:	80 3d d5 2e 00 00 00 	cmpb   $0x0,0x2ed5(%rip)        # 4120 <completed.0>
    124b:	75 2b                	jne    1278 <__do_global_dtors_aux+0x38>
    124d:	55                   	push   %rbp
    124e:	48 83 3d a2 2d 00 00 	cmpq   $0x0,0x2da2(%rip)        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    1255:	00 
    1256:	48 89 e5             	mov    %rsp,%rbp
    1259:	74 0c                	je     1267 <__do_global_dtors_aux+0x27>
    125b:	48 8b 3d a6 2d 00 00 	mov    0x2da6(%rip),%rdi        # 4008 <__dso_handle>
    1262:	e8 79 fe ff ff       	call   10e0 <__cxa_finalize@plt>
    1267:	e8 64 ff ff ff       	call   11d0 <deregister_tm_clones>
    126c:	c6 05 ad 2e 00 00 01 	movb   $0x1,0x2ead(%rip)        # 4120 <completed.0>
    1273:	5d                   	pop    %rbp
    1274:	c3                   	ret
    1275:	0f 1f 00             	nopl   (%rax)
    1278:	c3                   	ret
    1279:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001280 <frame_dummy>:
    1280:	f3 0f 1e fa          	endbr64
    1284:	e9 77 ff ff ff       	jmp    1200 <register_tm_clones>

0000000000001289 <main>:
    1289:	f3 0f 1e fa          	endbr64
    128d:	55                   	push   %rbp
    128e:	48 89 e5             	mov    %rsp,%rbp
    1291:	48 83 ec 30          	sub    $0x30,%rsp
    1295:	48 8d 05 24 2e 00 00 	lea    0x2e24(%rip),%rax        # 40c0 <t3>
    129c:	48 89 c1             	mov    %rax,%rcx
    129f:	48 8d 05 ba 2d 00 00 	lea    0x2dba(%rip),%rax        # 4060 <t2>
    12a6:	48 89 c2             	mov    %rax,%rdx
    12a9:	48 8d 05 70 2d 00 00 	lea    0x2d70(%rip),%rax        # 4020 <t1>
    12b0:	48 89 c6             	mov    %rax,%rsi
    12b3:	48 8d 05 4e 0d 00 00 	lea    0xd4e(%rip),%rax        # 2008 <_IO_stdin_used+0x8>
    12ba:	48 89 c7             	mov    %rax,%rdi
    12bd:	b8 00 00 00 00       	mov    $0x0,%eax
    12c2:	e8 59 fe ff ff       	call   1120 <printf@plt>
    12c7:	48 8b 05 2a 0e 00 00 	mov    0xe2a(%rip),%rax        # 20f8 <__PRETTY_FUNCTION__.0+0x8>
    12ce:	66 48 0f 6e c0       	movq   %rax,%xmm0
    12d3:	48 8d 05 3e 0d 00 00 	lea    0xd3e(%rip),%rax        # 2018 <_IO_stdin_used+0x18>
    12da:	48 89 c7             	mov    %rax,%rdi
    12dd:	b8 01 00 00 00       	mov    $0x1,%eax
    12e2:	e8 39 fe ff ff       	call   1120 <printf@plt>
    12e7:	48 8b 05 12 0e 00 00 	mov    0xe12(%rip),%rax        # 2100 <__PRETTY_FUNCTION__.0+0x10>
    12ee:	66 48 0f 6e c0       	movq   %rax,%xmm0
    12f3:	48 8d 05 37 0d 00 00 	lea    0xd37(%rip),%rax        # 2031 <_IO_stdin_used+0x31>
    12fa:	48 89 c7             	mov    %rax,%rdi
    12fd:	b8 01 00 00 00       	mov    $0x1,%eax
    1302:	e8 19 fe ff ff       	call   1120 <printf@plt>
    1307:	be 00 80 00 00       	mov    $0x8000,%esi
    130c:	48 8d 05 37 0d 00 00 	lea    0xd37(%rip),%rax        # 204a <_IO_stdin_used+0x4a>
    1313:	48 89 c7             	mov    %rax,%rdi
    1316:	b8 00 00 00 00       	mov    $0x0,%eax
    131b:	e8 00 fe ff ff       	call   1120 <printf@plt>
    1320:	bf 00 00 00 00       	mov    $0x0,%edi
    1325:	e8 36 fe ff ff       	call   1160 <time@plt>
    132a:	89 c7                	mov    %eax,%edi
    132c:	e8 1f fe ff ff       	call   1150 <srand@plt>
    1331:	e8 fe 02 00 00       	call   1634 <wtime>
    1336:	66 48 0f 7e c0       	movq   %xmm0,%rax
    133b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    133f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
    1346:	eb 1d                	jmp    1365 <main+0xdc>
    1348:	48 8d 05 91 2f 00 00 	lea    0x2f91(%rip),%rax        # 42e0 <heat2>
    134f:	48 89 c6             	mov    %rax,%rsi
    1352:	48 8d 05 e7 2d 00 00 	lea    0x2de7(%rip),%rax        # 4140 <heat>
    1359:	48 89 c7             	mov    %rax,%rdi
    135c:	e8 3f 03 00 00       	call   16a0 <photon>
    1361:	83 45 dc 01          	addl   $0x1,-0x24(%rbp)
    1365:	81 7d dc ff 7f 00 00 	cmpl   $0x7fff,-0x24(%rbp)
    136c:	76 da                	jbe    1348 <main+0xbf>
    136e:	e8 c1 02 00 00       	call   1634 <wtime>
    1373:	66 48 0f 7e c0       	movq   %xmm0,%rax
    1378:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    137c:	f2 0f 10 45 f0       	movsd  -0x10(%rbp),%xmm0
    1381:	66 0f 2f 45 e8       	comisd -0x18(%rbp),%xmm0
    1386:	73 28                	jae    13b0 <main+0x127>
    1388:	48 8d 05 61 0d 00 00 	lea    0xd61(%rip),%rax        # 20f0 <__PRETTY_FUNCTION__.0>
    138f:	48 89 c1             	mov    %rax,%rcx
    1392:	ba 34 00 00 00       	mov    $0x34,%edx
    1397:	48 8d 05 c2 0c 00 00 	lea    0xcc2(%rip),%rax        # 2060 <_IO_stdin_used+0x60>
    139e:	48 89 c6             	mov    %rax,%rsi
    13a1:	48 8d 05 c2 0c 00 00 	lea    0xcc2(%rip),%rax        # 206a <_IO_stdin_used+0x6a>
    13a8:	48 89 c7             	mov    %rax,%rdi
    13ab:	e8 80 fd ff ff       	call   1130 <__assert_fail@plt>
    13b0:	f2 0f 10 45 f0       	movsd  -0x10(%rbp),%xmm0
    13b5:	f2 0f 5c 45 e8       	subsd  -0x18(%rbp),%xmm0
    13ba:	f2 0f 11 45 f8       	movsd  %xmm0,-0x8(%rbp)
    13bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13c3:	66 48 0f 6e c0       	movq   %rax,%xmm0
    13c8:	48 8d 05 a8 0c 00 00 	lea    0xca8(%rip),%rax        # 2077 <_IO_stdin_used+0x77>
    13cf:	48 89 c7             	mov    %rax,%rdi
    13d2:	b8 01 00 00 00       	mov    $0x1,%eax
    13d7:	e8 44 fd ff ff       	call   1120 <printf@plt>
    13dc:	f2 0f 10 05 24 0d 00 	movsd  0xd24(%rip),%xmm0        # 2108 <__PRETTY_FUNCTION__.0+0x18>
    13e3:	00 
    13e4:	f2 0f 5e 45 f8       	divsd  -0x8(%rbp),%xmm0
    13e9:	66 48 0f 7e c0       	movq   %xmm0,%rax
    13ee:	66 48 0f 6e c0       	movq   %rax,%xmm0
    13f3:	48 8d 05 8c 0c 00 00 	lea    0xc8c(%rip),%rax        # 2086 <_IO_stdin_used+0x86>
    13fa:	48 89 c7             	mov    %rax,%rdi
    13fd:	b8 01 00 00 00       	mov    $0x1,%eax
    1402:	e8 19 fd ff ff       	call   1120 <printf@plt>
    1407:	48 8d 05 94 0c 00 00 	lea    0xc94(%rip),%rax        # 20a2 <_IO_stdin_used+0xa2>
    140e:	48 89 c7             	mov    %rax,%rdi
    1411:	e8 da fc ff ff       	call   10f0 <puts@plt>
    1416:	48 8d 05 93 0c 00 00 	lea    0xc93(%rip),%rax        # 20b0 <_IO_stdin_used+0xb0>
    141d:	48 89 c7             	mov    %rax,%rdi
    1420:	e8 cb fc ff ff       	call   10f0 <puts@plt>
    1425:	f3 0f 10 05 e3 0c 00 	movss  0xce3(%rip),%xmm0        # 2110 <__PRETTY_FUNCTION__.0+0x20>
    142c:	00 
    142d:	f3 0f 11 45 e4       	movss  %xmm0,-0x1c(%rbp)
    1432:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    1439:	e9 ab 01 00 00       	jmp    15e9 <main+0x360>
    143e:	8b 45 e0             	mov    -0x20(%rbp),%eax
    1441:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
    1448:	00 
    1449:	48 8d 05 90 2e 00 00 	lea    0x2e90(%rip),%rax        # 42e0 <heat2>
    1450:	f3 0f 10 04 02       	movss  (%rdx,%rax,1),%xmm0
    1455:	8b 45 e0             	mov    -0x20(%rbp),%eax
    1458:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
    145f:	00 
    1460:	48 8d 05 d9 2c 00 00 	lea    0x2cd9(%rip),%rax        # 4140 <heat>
    1467:	f3 0f 10 14 02       	movss  (%rdx,%rax,1),%xmm2
    146c:	8b 45 e0             	mov    -0x20(%rbp),%eax
    146f:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
    1476:	00 
    1477:	48 8d 05 c2 2c 00 00 	lea    0x2cc2(%rip),%rax        # 4140 <heat>
    147e:	f3 0f 10 0c 02       	movss  (%rdx,%rax,1),%xmm1
    1483:	f3 0f 59 ca          	mulss  %xmm2,%xmm1
    1487:	f3 0f 10 15 85 0c 00 	movss  0xc85(%rip),%xmm2        # 2114 <__PRETTY_FUNCTION__.0+0x24>
    148e:	00 
    148f:	f3 0f 5e ca          	divss  %xmm2,%xmm1
    1493:	f3 0f 5c c1          	subss  %xmm1,%xmm0
    1497:	66 0f ef ed          	pxor   %xmm5,%xmm5
    149b:	f3 0f 5a e8          	cvtss2sd %xmm0,%xmm5
    149f:	66 48 0f 7e e8       	movq   %xmm5,%rax
    14a4:	66 48 0f 6e c0       	movq   %rax,%xmm0
    14a9:	e8 d2 fc ff ff       	call   1180 <sqrt@plt>
    14ae:	66 48 0f 7e c0       	movq   %xmm0,%rax
    14b3:	66 0f ef c0          	pxor   %xmm0,%xmm0
    14b7:	f3 0f 5a 45 e4       	cvtss2sd -0x1c(%rbp),%xmm0
    14bc:	66 48 0f 6e c8       	movq   %rax,%xmm1
    14c1:	f2 0f 5e c8          	divsd  %xmm0,%xmm1
    14c5:	8b 45 e0             	mov    -0x20(%rbp),%eax
    14c8:	83 c0 01             	add    $0x1,%eax
    14cb:	0f af 45 e0          	imul   -0x20(%rbp),%eax
    14cf:	89 c0                	mov    %eax,%eax
    14d1:	48 85 c0             	test   %rax,%rax
    14d4:	78 0b                	js     14e1 <main+0x258>
    14d6:	66 0f ef c0          	pxor   %xmm0,%xmm0
    14da:	f3 48 0f 2a c0       	cvtsi2ss %rax,%xmm0
    14df:	eb 19                	jmp    14fa <main+0x271>
    14e1:	48 89 c2             	mov    %rax,%rdx
    14e4:	48 d1 ea             	shr    $1,%rdx
    14e7:	83 e0 01             	and    $0x1,%eax
    14ea:	48 09 c2             	or     %rax,%rdx
    14ed:	66 0f ef c0          	pxor   %xmm0,%xmm0
    14f1:	f3 48 0f 2a c2       	cvtsi2ss %rdx,%xmm0
    14f6:	f3 0f 58 c0          	addss  %xmm0,%xmm0
    14fa:	f3 0f 10 15 16 0c 00 	movss  0xc16(%rip),%xmm2        # 2118 <__PRETTY_FUNCTION__.0+0x28>
    1501:	00 
    1502:	f3 0f 58 c2          	addss  %xmm2,%xmm0
    1506:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    150a:	66 0f 28 e1          	movapd %xmm1,%xmm4
    150e:	f2 0f 5e e0          	divsd  %xmm0,%xmm4
    1512:	8b 45 e0             	mov    -0x20(%rbp),%eax
    1515:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
    151c:	00 
    151d:	48 8d 05 1c 2c 00 00 	lea    0x2c1c(%rip),%rax        # 4140 <heat>
    1524:	f3 0f 10 04 02       	movss  (%rdx,%rax,1),%xmm0
    1529:	f3 0f 5e 45 e4       	divss  -0x1c(%rbp),%xmm0
    152e:	66 0f ef c9          	pxor   %xmm1,%xmm1
    1532:	f3 0f 5a c8          	cvtss2sd %xmm0,%xmm1
    1536:	8b 45 e0             	mov    -0x20(%rbp),%eax
    1539:	83 c0 01             	add    $0x1,%eax
    153c:	0f af 45 e0          	imul   -0x20(%rbp),%eax
    1540:	89 c0                	mov    %eax,%eax
    1542:	48 85 c0             	test   %rax,%rax
    1545:	78 0b                	js     1552 <main+0x2c9>
    1547:	66 0f ef c0          	pxor   %xmm0,%xmm0
    154b:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    1550:	eb 19                	jmp    156b <main+0x2e2>
    1552:	48 89 c2             	mov    %rax,%rdx
    1555:	48 d1 ea             	shr    $1,%rdx
    1558:	83 e0 01             	and    $0x1,%eax
    155b:	48 09 c2             	or     %rax,%rdx
    155e:	66 0f ef c0          	pxor   %xmm0,%xmm0
    1562:	f2 48 0f 2a c2       	cvtsi2sd %rdx,%xmm0
    1567:	f2 0f 58 c0          	addsd  %xmm0,%xmm0
    156b:	f2 0f 10 15 ad 0b 00 	movsd  0xbad(%rip),%xmm2        # 2120 <__PRETTY_FUNCTION__.0+0x30>
    1572:	00 
    1573:	f2 0f 58 c2          	addsd  %xmm2,%xmm0
    1577:	66 0f 28 d9          	movapd %xmm1,%xmm3
    157b:	f2 0f 5e d8          	divsd  %xmm0,%xmm3
    157f:	8b 45 e0             	mov    -0x20(%rbp),%eax
    1582:	48 85 c0             	test   %rax,%rax
    1585:	78 0b                	js     1592 <main+0x309>
    1587:	66 0f ef c0          	pxor   %xmm0,%xmm0
    158b:	f3 48 0f 2a c0       	cvtsi2ss %rax,%xmm0
    1590:	eb 19                	jmp    15ab <main+0x322>
    1592:	48 89 c2             	mov    %rax,%rdx
    1595:	48 d1 ea             	shr    $1,%rdx
    1598:	83 e0 01             	and    $0x1,%eax
    159b:	48 09 c2             	or     %rax,%rdx
    159e:	66 0f ef c0          	pxor   %xmm0,%xmm0
    15a2:	f3 48 0f 2a c2       	cvtsi2ss %rdx,%xmm0
    15a7:	f3 0f 58 c0          	addss  %xmm0,%xmm0
    15ab:	f3 0f 10 0d 75 0b 00 	movss  0xb75(%rip),%xmm1        # 2128 <__PRETTY_FUNCTION__.0+0x38>
    15b2:	00 
    15b3:	f3 0f 59 c1          	mulss  %xmm1,%xmm0
    15b7:	66 0f ef f6          	pxor   %xmm6,%xmm6
    15bb:	f3 0f 5a f0          	cvtss2sd %xmm0,%xmm6
    15bf:	66 48 0f 7e f0       	movq   %xmm6,%rax
    15c4:	66 0f 28 d4          	movapd %xmm4,%xmm2
    15c8:	66 0f 28 cb          	movapd %xmm3,%xmm1
    15cc:	66 48 0f 6e c0       	movq   %rax,%xmm0
    15d1:	48 8d 05 f3 0a 00 00 	lea    0xaf3(%rip),%rax        # 20cb <_IO_stdin_used+0xcb>
    15d8:	48 89 c7             	mov    %rax,%rdi
    15db:	b8 03 00 00 00       	mov    $0x3,%eax
    15e0:	e8 3b fb ff ff       	call   1120 <printf@plt>
    15e5:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
    15e9:	83 7d e0 63          	cmpl   $0x63,-0x20(%rbp)
    15ed:	0f 86 4b fe ff ff    	jbe    143e <main+0x1b5>
    15f3:	f3 0f 10 05 d5 2c 00 	movss  0x2cd5(%rip),%xmm0        # 42d0 <heat+0x190>
    15fa:	00 
    15fb:	f3 0f 10 0d 11 0b 00 	movss  0xb11(%rip),%xmm1        # 2114 <__PRETTY_FUNCTION__.0+0x24>
    1602:	00 
    1603:	f3 0f 5e c1          	divss  %xmm1,%xmm0
    1607:	66 0f ef ff          	pxor   %xmm7,%xmm7
    160b:	f3 0f 5a f8          	cvtss2sd %xmm0,%xmm7
    160f:	66 48 0f 7e f8       	movq   %xmm7,%rax
    1614:	66 48 0f 6e c0       	movq   %rax,%xmm0
    1619:	48 8d 05 c0 0a 00 00 	lea    0xac0(%rip),%rax        # 20e0 <_IO_stdin_used+0xe0>
    1620:	48 89 c7             	mov    %rax,%rdi
    1623:	b8 01 00 00 00       	mov    $0x1,%eax
    1628:	e8 f3 fa ff ff       	call   1120 <printf@plt>
    162d:	b8 00 00 00 00       	mov    $0x0,%eax
    1632:	c9                   	leave
    1633:	c3                   	ret

0000000000001634 <wtime>:
    1634:	f3 0f 1e fa          	endbr64
    1638:	55                   	push   %rbp
    1639:	48 89 e5             	mov    %rsp,%rbp
    163c:	48 83 ec 20          	sub    $0x20,%rsp
    1640:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    1647:	00 00 
    1649:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    164d:	31 c0                	xor    %eax,%eax
    164f:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
    1653:	48 89 c6             	mov    %rax,%rsi
    1656:	bf 04 00 00 00       	mov    $0x4,%edi
    165b:	e8 a0 fa ff ff       	call   1100 <clock_gettime@plt>
    1660:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1664:	66 0f ef c9          	pxor   %xmm1,%xmm1
    1668:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    166d:	f2 0f 10 05 bb 0a 00 	movsd  0xabb(%rip),%xmm0        # 2130 <__PRETTY_FUNCTION__.0+0x40>
    1674:	00 
    1675:	f2 0f 59 c8          	mulsd  %xmm0,%xmm1
    1679:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    167d:	66 0f ef c0          	pxor   %xmm0,%xmm0
    1681:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    1686:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    168a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    168e:	64 48 2b 04 25 28 00 	sub    %fs:0x28,%rax
    1695:	00 00 
    1697:	74 05                	je     169e <wtime+0x6a>
    1699:	e8 72 fa ff ff       	call   1110 <__stack_chk_fail@plt>
    169e:	c9                   	leave
    169f:	c3                   	ret

00000000000016a0 <photon>:
    16a0:	f3 0f 1e fa          	endbr64
    16a4:	55                   	push   %rbp
    16a5:	48 89 e5             	mov    %rsp,%rbp
    16a8:	48 83 ec 50          	sub    $0x50,%rsp
    16ac:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    16b0:	48 89 75 b0          	mov    %rsi,-0x50(%rbp)
    16b4:	f3 0f 10 05 84 0a 00 	movss  0xa84(%rip),%xmm0        # 2140 <__PRETTY_FUNCTION__.0+0x50>
    16bb:	00 
    16bc:	f3 0f 11 45 ec       	movss  %xmm0,-0x14(%rbp)
    16c1:	f3 0f 10 05 7b 0a 00 	movss  0xa7b(%rip),%xmm0        # 2144 <__PRETTY_FUNCTION__.0+0x54>
    16c8:	00 
    16c9:	f3 0f 11 45 f0       	movss  %xmm0,-0x10(%rbp)
    16ce:	66 0f ef c0          	pxor   %xmm0,%xmm0
    16d2:	f3 0f 11 45 cc       	movss  %xmm0,-0x34(%rbp)
    16d7:	66 0f ef c0          	pxor   %xmm0,%xmm0
    16db:	f3 0f 11 45 d0       	movss  %xmm0,-0x30(%rbp)
    16e0:	66 0f ef c0          	pxor   %xmm0,%xmm0
    16e4:	f3 0f 11 45 d4       	movss  %xmm0,-0x2c(%rbp)
    16e9:	66 0f ef c0          	pxor   %xmm0,%xmm0
    16ed:	f3 0f 11 45 d8       	movss  %xmm0,-0x28(%rbp)
    16f2:	66 0f ef c0          	pxor   %xmm0,%xmm0
    16f6:	f3 0f 11 45 dc       	movss  %xmm0,-0x24(%rbp)
    16fb:	f3 0f 10 05 45 0a 00 	movss  0xa45(%rip),%xmm0        # 2148 <__PRETTY_FUNCTION__.0+0x58>
    1702:	00 
    1703:	f3 0f 11 45 e0       	movss  %xmm0,-0x20(%rbp)
    1708:	f3 0f 10 05 38 0a 00 	movss  0xa38(%rip),%xmm0        # 2148 <__PRETTY_FUNCTION__.0+0x58>
    170f:	00 
    1710:	f3 0f 11 45 e4       	movss  %xmm0,-0x1c(%rbp)
    1715:	e8 76 fa ff ff       	call   1190 <rand@plt>
    171a:	66 0f ef c0          	pxor   %xmm0,%xmm0
    171e:	f3 0f 2a c0          	cvtsi2ss %eax,%xmm0
    1722:	f3 0f 10 0d 22 0a 00 	movss  0xa22(%rip),%xmm1        # 214c <__PRETTY_FUNCTION__.0+0x5c>
    1729:	00 
    172a:	f3 0f 5e c1          	divss  %xmm1,%xmm0
    172e:	66 0f 7e c0          	movd   %xmm0,%eax
    1732:	66 0f 6e c0          	movd   %eax,%xmm0
    1736:	e8 05 fa ff ff       	call   1140 <logf@plt>
    173b:	66 0f 7e c0          	movd   %xmm0,%eax
    173f:	f3 0f 10 05 09 0a 00 	movss  0xa09(%rip),%xmm0        # 2150 <__PRETTY_FUNCTION__.0+0x60>
    1746:	00 
    1747:	66 0f 6e d8          	movd   %eax,%xmm3
    174b:	0f 57 d8             	xorps  %xmm0,%xmm3
    174e:	0f 28 c3             	movaps %xmm3,%xmm0
    1751:	f3 0f 11 45 f4       	movss  %xmm0,-0xc(%rbp)
    1756:	f3 0f 10 45 f4       	movss  -0xc(%rbp),%xmm0
    175b:	f3 0f 59 45 d8       	mulss  -0x28(%rbp),%xmm0
    1760:	f3 0f 10 4d cc       	movss  -0x34(%rbp),%xmm1
    1765:	f3 0f 58 c1          	addss  %xmm1,%xmm0
    1769:	f3 0f 11 45 cc       	movss  %xmm0,-0x34(%rbp)
    176e:	f3 0f 10 45 f4       	movss  -0xc(%rbp),%xmm0
    1773:	f3 0f 59 45 dc       	mulss  -0x24(%rbp),%xmm0
    1778:	f3 0f 10 4d d0       	movss  -0x30(%rbp),%xmm1
    177d:	f3 0f 58 c1          	addss  %xmm1,%xmm0
    1781:	f3 0f 11 45 d0       	movss  %xmm0,-0x30(%rbp)
    1786:	f3 0f 10 45 f4       	movss  -0xc(%rbp),%xmm0
    178b:	f3 0f 59 45 e0       	mulss  -0x20(%rbp),%xmm0
    1790:	f3 0f 10 4d d4       	movss  -0x2c(%rbp),%xmm1
    1795:	f3 0f 58 c1          	addss  %xmm1,%xmm0
    1799:	f3 0f 11 45 d4       	movss  %xmm0,-0x2c(%rbp)
    179e:	f3 0f 10 45 cc       	movss  -0x34(%rbp),%xmm0
    17a3:	0f 28 c8             	movaps %xmm0,%xmm1
    17a6:	f3 0f 59 c8          	mulss  %xmm0,%xmm1
    17aa:	f3 0f 10 45 d0       	movss  -0x30(%rbp),%xmm0
    17af:	f3 0f 59 c0          	mulss  %xmm0,%xmm0
    17b3:	f3 0f 58 c8          	addss  %xmm0,%xmm1
    17b7:	f3 0f 10 45 d4       	movss  -0x2c(%rbp),%xmm0
    17bc:	f3 0f 59 c0          	mulss  %xmm0,%xmm0
    17c0:	f3 0f 58 c8          	addss  %xmm0,%xmm1
    17c4:	66 0f 7e c8          	movd   %xmm1,%eax
    17c8:	66 0f 6e c0          	movd   %eax,%xmm0
    17cc:	e8 9f f9 ff ff       	call   1170 <sqrtf@plt>
    17d1:	66 0f 7e c0          	movd   %xmm0,%eax
    17d5:	66 0f 6e c0          	movd   %eax,%xmm0
    17d9:	f3 0f 59 45 f0       	mulss  -0x10(%rbp),%xmm0
    17de:	f3 48 0f 2c c0       	cvttss2si %xmm0,%rax
    17e3:	89 45 e8             	mov    %eax,-0x18(%rbp)
    17e6:	83 7d e8 64          	cmpl   $0x64,-0x18(%rbp)
    17ea:	76 07                	jbe    17f3 <photon+0x153>
    17ec:	c7 45 e8 64 00 00 00 	movl   $0x64,-0x18(%rbp)
    17f3:	8b 45 e8             	mov    -0x18(%rbp),%eax
    17f6:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
    17fd:	00 
    17fe:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
    1802:	48 01 d0             	add    %rdx,%rax
    1805:	f3 0f 10 08          	movss  (%rax),%xmm1
    1809:	f3 0f 10 05 37 09 00 	movss  0x937(%rip),%xmm0        # 2148 <__PRETTY_FUNCTION__.0+0x58>
    1810:	00 
    1811:	f3 0f 5c 45 ec       	subss  -0x14(%rbp),%xmm0
    1816:	f3 0f 59 45 e4       	mulss  -0x1c(%rbp),%xmm0
    181b:	8b 45 e8             	mov    -0x18(%rbp),%eax
    181e:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
    1825:	00 
    1826:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
    182a:	48 01 d0             	add    %rdx,%rax
    182d:	f3 0f 58 c1          	addss  %xmm1,%xmm0
    1831:	f3 0f 11 00          	movss  %xmm0,(%rax)
    1835:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1838:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
    183f:	00 
    1840:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    1844:	48 01 d0             	add    %rdx,%rax
    1847:	f3 0f 10 08          	movss  (%rax),%xmm1
    184b:	f3 0f 10 05 f5 08 00 	movss  0x8f5(%rip),%xmm0        # 2148 <__PRETTY_FUNCTION__.0+0x58>
    1852:	00 
    1853:	0f 28 d0             	movaps %xmm0,%xmm2
    1856:	f3 0f 5c 55 ec       	subss  -0x14(%rbp),%xmm2
    185b:	f3 0f 10 05 e5 08 00 	movss  0x8e5(%rip),%xmm0        # 2148 <__PRETTY_FUNCTION__.0+0x58>
    1862:	00 
    1863:	f3 0f 5c 45 ec       	subss  -0x14(%rbp),%xmm0
    1868:	f3 0f 59 c2          	mulss  %xmm2,%xmm0
    186c:	f3 0f 59 45 e4       	mulss  -0x1c(%rbp),%xmm0
    1871:	f3 0f 59 45 e4       	mulss  -0x1c(%rbp),%xmm0
    1876:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1879:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
    1880:	00 
    1881:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    1885:	48 01 d0             	add    %rdx,%rax
    1888:	f3 0f 58 c1          	addss  %xmm1,%xmm0
    188c:	f3 0f 11 00          	movss  %xmm0,(%rax)
    1890:	f3 0f 10 45 e4       	movss  -0x1c(%rbp),%xmm0
    1895:	f3 0f 59 45 ec       	mulss  -0x14(%rbp),%xmm0
    189a:	f3 0f 11 45 e4       	movss  %xmm0,-0x1c(%rbp)
    189f:	e8 ec f8 ff ff       	call   1190 <rand@plt>
    18a4:	66 0f ef c0          	pxor   %xmm0,%xmm0
    18a8:	f3 0f 2a c0          	cvtsi2ss %eax,%xmm0
    18ac:	f3 0f 58 c0          	addss  %xmm0,%xmm0
    18b0:	f3 0f 10 0d 94 08 00 	movss  0x894(%rip),%xmm1        # 214c <__PRETTY_FUNCTION__.0+0x5c>
    18b7:	00 
    18b8:	f3 0f 5e c1          	divss  %xmm1,%xmm0
    18bc:	f3 0f 10 0d 84 08 00 	movss  0x884(%rip),%xmm1        # 2148 <__PRETTY_FUNCTION__.0+0x58>
    18c3:	00 
    18c4:	f3 0f 5c c1          	subss  %xmm1,%xmm0
    18c8:	f3 0f 11 45 f8       	movss  %xmm0,-0x8(%rbp)
    18cd:	e8 be f8 ff ff       	call   1190 <rand@plt>
    18d2:	66 0f ef c0          	pxor   %xmm0,%xmm0
    18d6:	f3 0f 2a c0          	cvtsi2ss %eax,%xmm0
    18da:	f3 0f 58 c0          	addss  %xmm0,%xmm0
    18de:	f3 0f 10 0d 66 08 00 	movss  0x866(%rip),%xmm1        # 214c <__PRETTY_FUNCTION__.0+0x5c>
    18e5:	00 
    18e6:	f3 0f 5e c1          	divss  %xmm1,%xmm0
    18ea:	f3 0f 10 0d 56 08 00 	movss  0x856(%rip),%xmm1        # 2148 <__PRETTY_FUNCTION__.0+0x58>
    18f1:	00 
    18f2:	f3 0f 5c c1          	subss  %xmm1,%xmm0
    18f6:	f3 0f 11 45 fc       	movss  %xmm0,-0x4(%rbp)
    18fb:	f3 0f 10 45 f8       	movss  -0x8(%rbp),%xmm0
    1900:	0f 28 c8             	movaps %xmm0,%xmm1
    1903:	f3 0f 59 c8          	mulss  %xmm0,%xmm1
    1907:	f3 0f 10 45 fc       	movss  -0x4(%rbp),%xmm0
    190c:	f3 0f 59 c0          	mulss  %xmm0,%xmm0
    1910:	f3 0f 58 c1          	addss  %xmm1,%xmm0
    1914:	f3 0f 11 45 f4       	movss  %xmm0,-0xc(%rbp)
    1919:	f3 0f 10 45 f4       	movss  -0xc(%rbp),%xmm0
    191e:	f3 0f 10 0d 22 08 00 	movss  0x822(%rip),%xmm1        # 2148 <__PRETTY_FUNCTION__.0+0x58>
    1925:	00 
    1926:	0f 2f c1             	comiss %xmm1,%xmm0
    1929:	0f 87 70 ff ff ff    	ja     189f <photon+0x1ff>
    192f:	f3 0f 10 45 f4       	movss  -0xc(%rbp),%xmm0
    1934:	f3 0f 58 c0          	addss  %xmm0,%xmm0
    1938:	f3 0f 10 0d 08 08 00 	movss  0x808(%rip),%xmm1        # 2148 <__PRETTY_FUNCTION__.0+0x58>
    193f:	00 
    1940:	f3 0f 5c c1          	subss  %xmm1,%xmm0
    1944:	f3 0f 11 45 d8       	movss  %xmm0,-0x28(%rbp)
    1949:	f3 0f 10 45 d8       	movss  -0x28(%rbp),%xmm0
    194e:	0f 28 c8             	movaps %xmm0,%xmm1
    1951:	f3 0f 59 c8          	mulss  %xmm0,%xmm1
    1955:	f3 0f 10 05 eb 07 00 	movss  0x7eb(%rip),%xmm0        # 2148 <__PRETTY_FUNCTION__.0+0x58>
    195c:	00 
    195d:	f3 0f 5c c1          	subss  %xmm1,%xmm0
    1961:	f3 0f 5e 45 f4       	divss  -0xc(%rbp),%xmm0
    1966:	66 0f 7e c0          	movd   %xmm0,%eax
    196a:	66 0f 6e c0          	movd   %eax,%xmm0
    196e:	e8 fd f7 ff ff       	call   1170 <sqrtf@plt>
    1973:	f3 0f 10 4d f8       	movss  -0x8(%rbp),%xmm1
    1978:	f3 0f 59 c1          	mulss  %xmm1,%xmm0
    197c:	f3 0f 11 45 dc       	movss  %xmm0,-0x24(%rbp)
    1981:	f3 0f 10 45 d8       	movss  -0x28(%rbp),%xmm0
    1986:	0f 28 c8             	movaps %xmm0,%xmm1
    1989:	f3 0f 59 c8          	mulss  %xmm0,%xmm1
    198d:	f3 0f 10 05 b3 07 00 	movss  0x7b3(%rip),%xmm0        # 2148 <__PRETTY_FUNCTION__.0+0x58>
    1994:	00 
    1995:	f3 0f 5c c1          	subss  %xmm1,%xmm0
    1999:	f3 0f 5e 45 f4       	divss  -0xc(%rbp),%xmm0
    199e:	66 0f 7e c0          	movd   %xmm0,%eax
    19a2:	66 0f 6e c0          	movd   %eax,%xmm0
    19a6:	e8 c5 f7 ff ff       	call   1170 <sqrtf@plt>
    19ab:	f3 0f 10 4d fc       	movss  -0x4(%rbp),%xmm1
    19b0:	f3 0f 59 c1          	mulss  %xmm1,%xmm0
    19b4:	f3 0f 11 45 e0       	movss  %xmm0,-0x20(%rbp)
    19b9:	f3 0f 10 05 9f 07 00 	movss  0x79f(%rip),%xmm0        # 2160 <__PRETTY_FUNCTION__.0+0x70>
    19c0:	00 
    19c1:	0f 2f 45 e4          	comiss -0x1c(%rbp),%xmm0
    19c5:	76 38                	jbe    19ff <photon+0x35f>
    19c7:	e8 c4 f7 ff ff       	call   1190 <rand@plt>
    19cc:	66 0f ef c0          	pxor   %xmm0,%xmm0
    19d0:	f3 0f 2a c0          	cvtsi2ss %eax,%xmm0
    19d4:	f3 0f 10 0d 70 07 00 	movss  0x770(%rip),%xmm1        # 214c <__PRETTY_FUNCTION__.0+0x5c>
    19db:	00 
    19dc:	f3 0f 5e c1          	divss  %xmm1,%xmm0
    19e0:	0f 2f 05 7d 07 00 00 	comiss 0x77d(%rip),%xmm0        # 2164 <__PRETTY_FUNCTION__.0+0x74>
    19e7:	77 1b                	ja     1a04 <photon+0x364>
    19e9:	f3 0f 10 45 e4       	movss  -0x1c(%rbp),%xmm0
    19ee:	f3 0f 10 0d 6e 07 00 	movss  0x76e(%rip),%xmm1        # 2164 <__PRETTY_FUNCTION__.0+0x74>
    19f5:	00 
    19f6:	f3 0f 5e c1          	divss  %xmm1,%xmm0
    19fa:	f3 0f 11 45 e4       	movss  %xmm0,-0x1c(%rbp)
    19ff:	e9 11 fd ff ff       	jmp    1715 <photon+0x75>
    1a04:	90                   	nop
    1a05:	90                   	nop
    1a06:	c9                   	leave
    1a07:	c3                   	ret

Disassembly of section .fini:

0000000000001a08 <_fini>:
    1a08:	f3 0f 1e fa          	endbr64
    1a0c:	48 83 ec 08          	sub    $0x8,%rsp
    1a10:	48 83 c4 08          	add    $0x8,%rsp
    1a14:	c3                   	ret

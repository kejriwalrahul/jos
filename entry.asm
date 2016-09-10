
obj/kern/entry.o:     file format elf32-i386


Disassembly of section .text:

00000000 <entry-0xc>:
   0:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
   6:	00 00                	add    %al,(%eax)
   8:	fe 4f 52             	decb   0x52(%edi)
   b:	e4 66                	in     $0x66,%al

0000000c <entry>:
   c:	66 c7 05 72 04 00 00 	movw   $0x1234,0x472
  13:	34 12 
  15:	b8 00 00 00 10       	mov    $0x10000000,%eax
  1a:	0f 22 d8             	mov    %eax,%cr3
  1d:	0f 20 c0             	mov    %cr0,%eax
  20:	0d 01 00 01 80       	or     $0x80010001,%eax
  25:	0f 22 c0             	mov    %eax,%cr0
  28:	b8 2f 00 00 00       	mov    $0x2f,%eax
  2d:	ff e0                	jmp    *%eax

0000002f <relocated>:
  2f:	bd 00 00 00 00       	mov    $0x0,%ebp
  34:	bc 00 00 00 00       	mov    $0x0,%esp
  39:	e8 fc ff ff ff       	call   3a <relocated+0xb>

0000003e <spin>:
  3e:	eb fe                	jmp    3e <spin>

Disassembly of section .data:

00000000 <bootstack>:
	...

Disassembly of section .stab:

00000000 <.stab>:
   0:	01 00                	add    %eax,(%eax)
   2:	00 00                	add    %al,(%eax)
   4:	00 00                	add    %al,(%eax)
   6:	0e                   	push   %cs
   7:	00 30                	add    %dh,(%eax)
   9:	00 00                	add    %al,(%eax)
   b:	00 12                	add    %dl,(%edx)
   d:	00 00                	add    %al,(%eax)
   f:	00 64 00 00          	add    %ah,0x0(%eax,%eax,1)
  13:	00 00                	add    %al,(%eax)
  15:	00 00                	add    %al,(%eax)
  17:	00 23                	add    %ah,(%ebx)
  19:	00 00                	add    %al,(%eax)
  1b:	00 84 00 00 00 0c 00 	add    %al,0xc0000(%eax,%eax,1)
  22:	00 00                	add    %al,(%eax)
  24:	00 00                	add    %al,(%eax)
  26:	00 00                	add    %al,(%eax)
  28:	44                   	inc    %esp
  29:	00 2c 00             	add    %ch,(%eax,%eax,1)
  2c:	0c 00                	or     $0x0,%al
  2e:	00 00                	add    %al,(%eax)
  30:	00 00                	add    %al,(%eax)
  32:	00 00                	add    %al,(%eax)
  34:	44                   	inc    %esp
  35:	00 39                	add    %bh,(%ecx)
  37:	00 15 00 00 00 00    	add    %dl,0x0
  3d:	00 00                	add    %al,(%eax)
  3f:	00 44 00 3a          	add    %al,0x3a(%eax,%eax,1)
  43:	00 1a                	add    %bl,(%edx)
  45:	00 00                	add    %al,(%eax)
  47:	00 00                	add    %al,(%eax)
  49:	00 00                	add    %al,(%eax)
  4b:	00 44 00 3c          	add    %al,0x3c(%eax,%eax,1)
  4f:	00 1d 00 00 00 00    	add    %bl,0x0
  55:	00 00                	add    %al,(%eax)
  57:	00 44 00 3d          	add    %al,0x3d(%eax,%eax,1)
  5b:	00 20                	add    %ah,(%eax)
  5d:	00 00                	add    %al,(%eax)
  5f:	00 00                	add    %al,(%eax)
  61:	00 00                	add    %al,(%eax)
  63:	00 44 00 3e          	add    %al,0x3e(%eax,%eax,1)
  67:	00 25 00 00 00 00    	add    %ah,0x0
  6d:	00 00                	add    %al,(%eax)
  6f:	00 44 00 43          	add    %al,0x43(%eax,%eax,1)
  73:	00 28                	add    %ch,(%eax)
  75:	00 00                	add    %al,(%eax)
  77:	00 00                	add    %al,(%eax)
  79:	00 00                	add    %al,(%eax)
  7b:	00 44 00 44          	add    %al,0x44(%eax,%eax,1)
  7f:	00 2d 00 00 00 00    	add    %ch,0x0
  85:	00 00                	add    %al,(%eax)
  87:	00 44 00 4a          	add    %al,0x4a(%eax,%eax,1)
  8b:	00 2f                	add    %ch,(%edi)
  8d:	00 00                	add    %al,(%eax)
  8f:	00 00                	add    %al,(%eax)
  91:	00 00                	add    %al,(%eax)
  93:	00 44 00 4d          	add    %al,0x4d(%eax,%eax,1)
  97:	00 34 00             	add    %dh,(%eax,%eax,1)
  9a:	00 00                	add    %al,(%eax)
  9c:	00 00                	add    %al,(%eax)
  9e:	00 00                	add    %al,(%eax)
  a0:	44                   	inc    %esp
  a1:	00 50 00             	add    %dl,0x0(%eax)
  a4:	39 00                	cmp    %eax,(%eax)
  a6:	00 00                	add    %al,(%eax)
  a8:	00 00                	add    %al,(%eax)
  aa:	00 00                	add    %al,(%eax)
  ac:	44                   	inc    %esp
  ad:	00 53 00             	add    %dl,0x0(%ebx)
  b0:	3e 00 00             	add    %al,%ds:(%eax)
	...

Disassembly of section .stabstr:

00000000 <.stabstr>:
   0:	00 7b 73             	add    %bh,0x73(%ebx)
   3:	74 61                	je     66 <spin+0x28>
   5:	6e                   	outsb  %ds:(%esi),(%dx)
   6:	64 61                	fs popa 
   8:	72 64                	jb     6e <spin+0x30>
   a:	20 69 6e             	and    %ch,0x6e(%ecx)
   d:	70 75                	jo     84 <spin+0x46>
   f:	74 7d                	je     8e <spin+0x50>
  11:	00 7b 73             	add    %bh,0x73(%ebx)
  14:	74 61                	je     77 <spin+0x39>
  16:	6e                   	outsb  %ds:(%esi),(%dx)
  17:	64 61                	fs popa 
  19:	72 64                	jb     7f <spin+0x41>
  1b:	20 69 6e             	and    %ch,0x6e(%ecx)
  1e:	70 75                	jo     95 <spin+0x57>
  20:	74 7d                	je     9f <spin+0x61>
  22:	00 6b 65             	add    %ch,0x65(%ebx)
  25:	72 6e                	jb     95 <spin+0x57>
  27:	2f                   	das    
  28:	65 6e                	outsb  %gs:(%esi),(%dx)
  2a:	74 72                	je     9e <spin+0x60>
  2c:	79 2e                	jns    5c <spin+0x1e>
  2e:	53                   	push   %ebx
	...

# MIPS 汇编

## MIPS 的 hello world

```S
.section .data
    output: .ascii "Hello, world!\n"
.section .text
    .globl __start
__start:
    li      $v0, 4004
    li      $a0, 1
    la      $a1, output
    li      $a2, 14
    syscall
    li      $v0, 4001
    li      $a0, 0
    syscall
```

## X86 环境下的交叉编译运行

使用下列命令安装对应工具：
```bash
sudo apt install gcc-mipsel-linux-gnu   # mips 交叉编译环境
sudo apt install qemu-user-static       # 模拟运行环境
sudo apt install gdb-multiarch          # 交叉调试环境
```

编译运行指令：
```bash
mipsel-linux-gnu-as hello.S -o hello.o  # 汇编
mipsel-linux-gnu-ld hello.o -o hello    # 链接
qemu-mipsel-static hello                # 运行
```
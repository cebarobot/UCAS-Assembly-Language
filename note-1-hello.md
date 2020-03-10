# 1 Hello world

编写一个汇编程序，输出“Hello world”。修改程序，输出“University of CAS\n”。

我们选择在 Linux 平台编写汇编语言程序，使用 GNU `as` 作为汇编器。

## as 汇编语法
这一节介绍 `as` 汇编器使用的与机器无关汇编语言语法。

* `/*` 和 `*/` 之间的内容以及从*行注释符号*开始至行尾之间的内容被视为**注释**；
  * 在 i386 体系中，*行注释符号* 为 `#`；
* **符号**由字母（大小写敏感）、数字和符号 `_.$` 组成；
* 符号后紧跟冒号 `:` 构成一个**标号**（label），表示这个位置的地址；
* 一条**陈述**以 0 个或多个标号开始，通常紧跟一个关键符号，以换行符结尾；
* 以字符 `.` 开头的符号通常为**汇编指导**；
* 单个字符 `.` 的符号为表示当前地址；
* **字符常量**写在两个单引号 `''` 之间，遵循与 C 相似的转义规则；
* **字符串常量**写在两个双引号 `""` 之间，遵循与 C 相似的转义规则；
* **整数常量**：
  * 二进制以 `0b` 或 `0B` 开头；
  * 八进制以 `0` 开头；
  * 十进制以非 `0` 数字开头；
  * 十六进制以 `0x` 或 `0X` 开头；
* 文件末尾必须有一空行。

## 以“Hello world\n”为例
### Linux-32
下面以 Linux-32 平台下 AT&T 语法的 Hello world 汇编程序为例，介绍汇编程序的一般框架。
```S
# hello.S                           # 注释
.section .data                      # 声明数据节开始
    output: .ascii "Hello world\n"  # ASCII 字符串类型的字符串常量，标号为 output
.section .text                      # 声明代码节开始
.global _start                      # 声明入口地址是全局符号
_start:                             # 程序入口地址
/* output */                        # 输出字符串 output
    movl    $4, %eax                # 将立即数 4 移入寄存器 eax，系统调用号，写文件
    movl    $1, %ebx                # 将立即数 1 移入寄存器 ebx，文件描述符，终端
    movl    $output, %ecx           # 将 output 标号地址移入寄存器 ecx，输出缓冲区地址
    movl    $12, %edx               # 将立即数 12 移入寄存器 edx，输出字节数
    int     $0x80                   # 触发 0x80 软中断，系统调用
/* exit */                          # 结束程序
    movl    $1, %eax                # 将立即数 4 移入寄存器 eax，系统调用号，程序退出
    movl    $0, %ebx                # 将立即数 1 移入寄存器 ebx，返回值
    int     $0x80                   # 触发 0x80 软中断，系统调用

```

里面用到了 `mov` 和 `int`两条指令：
* `mov`，数据传输指令，`mov <源>, <目的>`；
  * 指令后缀表示数据类型：`l` 表示 32 位，`w` 表示 16 位，`b` 表示 8 位
* `int`，软中断指令，`int <软中断向量号>`

将前面的汇编程序保存为 `hello.S` 用下面的命令进行汇编、链接、运行：
```bash
as --32 hello.S -o hello.o          # 汇编
ld -m elf_i386 hello.o -o hello     # 链接
./hello                             # 运行
```

### Linux-64
接下来我们切换到 Linux-64 平台，看看汇编代码会有什么变化。
```S
# hello_64.S
# hello.S
.section .data
    output: .ascii "Hello world\n"
.section .text
.global _start
_start:
# output
    movq $1, %rax                   # rax，系统调用号，写文件
    movq $1, %rdi                   # rdi，参数 1，文件描述符 fd，标准输出
    movq $output, %rsi              # rsi，参数 2，输出缓冲区地址
    movq $12, %rdx                  # rdx，参数 3，字节序列的长度
    syscall                         # 调用 Linux 系统调用
# exit
    movq $60, %rax                  # rax，系统调用号，退出
    movq $0, %rdi                   # rdi，参数 2，状态码/返回值
    syscall                         # 调用 Linux 系统调用

```

Linux-64 的汇编源码与 Linux-32 的有这些不同：
* 系统调用指令不同：`syscall` 代替了 `int 0x80`；
  * 在 Linux-64 系统中应当始终使用 `syscall` 调用系统调用；
* 系统调用号不同：写文件为 1，程序退出为 60；
* 参数寄存器不同；
* 命令后缀不同：`q` 表示 64 位数据。

同样，汇编、链接 Linux-64 源文件的命令也略有不同，不再需要特别的汇编参数。
```bash
as hello.S -o hello.o       # 汇编
ld hello.o -o hello         # 链接
./hello                     # 运行
```

稍微总结一下 AT&T 语法：
* 使用指令后缀表示内存操作数的大小，
  *  `b`, `w`, `l`, `q` 分别代表 8, 16, 32, 64 位数据；
* 寄存器前加 `%` 前缀，立即数、标号引用前加 `$` 前缀；
* 目的寄存器在最**右**边。

### Intel 语法
i386 平台汇编除去 AT&T 语法，还有一种 Intel 语法。Intel 语法的特点如下：
* 使用内存操作数前缀表示内存操作数的大小，
  *  `byte ptr`, `word ptr`, `dword ptr`, `qword ptr` 分别代表 8, 16, 32, 64 位数据；
* 寄存器、立即数不加前缀，标号引用前需要加 `offset`；
* 目的寄存器在最**左**边。

采用 Intel 语法的 hello world 如下：
```S
# hello.S
    .intel_syntax noprefix          # 采用 Intel 语法，寄存器名前不加%
.section .data
    output: .ascii "Hello world\n"
.section .text
.global _start
_start:
# output
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, offset output
    mov     rdx, 12
    syscall
# exit
    mov     rax, 60
    mov     rdi, 0
    syscall

```

至此，第一个汇编程序 hello 就介绍完了。之后我们的程序基本都使用 AT&T 语法，运行在 Linux-64 平台上。

练习：修改程序，输出“University of CAS\n”。

## 参考资料
* [AT&T 汇编入门 - Hello World](https://blog.csdn.net/chuck_huang/article/details/79922595)
* [Linux系统调用：使用syscall](https://blog.csdn.net/hq815601489/article/details/80034589)
* [Linux基础IO--文件描述符fd/重定向](https://blog.csdn.net/cherrydreamsover/article/details/79656356)
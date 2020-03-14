# 2 运行和调试

## 汇编、运行
第 1 篇笔记已经提过了如何汇编、运行汇编语言程序，这里在复述一遍：
```bash
# Linux-64 平台，AT&T 语法
as hello.S -o hello.o
ld hello.o -o hello
./hello
```

为了方便，我们可以写一个 bash 脚本来做汇编、链接、运行这几件事，这里我胡乱写了一个：
```bash
#! /bin/bash

echo assembling...
as $1.S -o $1.o

echo assembling...
ld $1.o -o $1

echo running $1...
echo -------------------------------------------------
./$1
RETURN_VALUE=$?

echo -------------------------------------------------
echo $1 exited with return value $RETURN_VALUE
```

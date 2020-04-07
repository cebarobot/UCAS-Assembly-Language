# 3 基础指令

## 数据传输指令
我们介绍 IA-32 的下面的数据传输指令。

### MOV 指令
格式：
* AT&T Syntax: `MOVx <source>, <destination>`
  * 其中 `x` 为 `b`、`w`、`l`、`q`，用于内存操作数的大小
* Intel Syntax: `MOV <destination>, <source>`

注意：
* 源操作数与目的操作数大小一致；
* 内存操作数最多只有一个；
* 立即数只能作为源操作数。

内存操作数寻址方式可规约到 `base + index * scale + disp`，其中：
* `base`：基址；
* `index`：变址，可选；
* `scale`：比例因数，可选；
* `disp`：位移量，可选；
* `segreg`：（我不知道这是啥……），可选；

寻址格式为：
* AT&T Syntax: `%segreg:disp(base, index, scale)`
* Intel Syntax: `segreg:[base + index * scale + disp]`
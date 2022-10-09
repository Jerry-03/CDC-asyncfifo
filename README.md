# CDC-asyncfifo
跨时钟域电路，异步FIFO设计

设计可以参考结构图，顶层模块中例化了4（5）个子模块，子模块功能说明如下：

①fifomem：异步FIFO内部的ram，采用RTL ram常用写法：读数据地址给到直接读，时钟上升沿写。
②sync_r2w/sync_w2r：两个同步寄存器，同步格雷码
③rptr_empty：产生读地址（二进制计数器后三位）和读指针（二进制计数器右移 异或本身生成格雷码）
④wptr_full：同理
//至于为什么是读指针总是指向下一个读地址，可以理解为RAM只要有读地址有数据就会直接把数据drive到output端。详细可参考论文原文

![image](https://user-images.githubusercontent.com/72872077/194750944-ea5666d5-44ae-447a-8189-605c0129c3bd.png)

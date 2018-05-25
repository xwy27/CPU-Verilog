# CPU-Verilog

<!-- TOC -->

- [CPU-Verilog](#cpu-verilog)
  - [SingleCycleCPU](#singlecyclecpu)
  - [SingleCycleCPU-Basys3](#singlecyclecpu-basys3)
  - [Verilog](#verilog)
    - [部分语法讲解](#部分语法讲解)
      - [注释(comment)](#注释comment)
      - [标识符(identifiers)](#标识符identifiers)
      - [数据类型和变量](#数据类型和变量)
      - [向量](#向量)
      - [基本运算符](#基本运算符)
      - [语句](#语句)
      - [模块结构](#模块结构)

<!-- /TOC -->

SYSU-CPU

建议先阅读 Verilog 讲解部分

## SingleCycleCPU

- 仿真测试通过

## SingleCycleCPU-Basys3

- 仿真测试通过
- 烧板测试通过

## Verilog

### 部分语法讲解

这里只涉及在接下来的单周期 CPU 设计与实现时使用到的语法知识。

#### 注释(comment)

Verilog 使用单行注释与多行注释。

- 单行注释：由 "//" 开始到行末的一行内容
- 多行注释：以 "/\*" 开始到 "\*/" 结束的所有内容

#### 标识符(identifiers)

Verilog 的标识符(通俗来讲，就是命名规则)可以是任意一组字母，数字或符号 "\$" 和 "_" 的组合，但其**第一个标识符必须是字母或者下划线**。

- 标识符是大小写敏感的。
- Verilog 内部关键字不可作为标识符。

#### 数据类型和变量

- 常量(constant)
  - 整数(integer)： +/- \<位宽>'\<进制>\<值>
    - **默认为十进制**
    - 4'hFFFF / 4'HFFFF: 4位十六进制数 FFFF
    - 4'd9999 / 4'D9999: 4位十进制数 9999
    - 4'o7777 / 4'O7777: 4位八进制数 7777
    - 4'b1111 / 4'B1111: 4位二进制数 1111
  - 实数(real)
    - 十进制表示法：2.0, 1.1
    - 科学记数法: 43_5.1e2 = 43510.0; 9.6E2 = 960.0; 5E-4 = 0.0005
  - 字符串(string)：双引号内的字符序列
    - **不能多行书写**
- 数据类型，变量
  - Net 型
    如同硬件电路中的物理连接，输出值紧跟输入值变化。
    *通过 assign 语句赋值。*
    - wire 变量
      ```verilog
      wire temp;          //位宽为1的 temp 变量
      wire[7:0] databus;  //位宽为8的 databus
      assign databus = 8'b11111111;
      ```
  - Variable 型
    必须放在过程语句(如initial、always)中，通过过程赋值语句赋值；**在always、initial等过程块内被赋值的信号必须定义成variable型**。  
    *variable型变量并不意味着一定对应着硬件上的一个触发器或寄存器等存储元件，在综合器进行综合时，variable型变量会根据具体情况来确定是映射成连线还是映射为触发器或寄存器。*
    - reg 变量
      reg 类型变量用于 always 块内或 initial 语句中被赋值。
      ```verilog
      reg a;        //寄存器类型 a 变量
      reg[7:0] b;   //位宽为8的寄存器类型 b 变量
      ```

#### 向量

- 标量和向量
  宽度为1位的变量称为标量，否则为向量。默认未声明位宽时为标量。  
  向量宽度采用 [msb:lsb] 定义。
- 位选择和域选择
  选择单个位为位选择，若选择相邻几位，则称为域选择。

  ```verilog
  A = databus[6];     //位选择
  B = databus[5:3];   //域选择
  ```

#### 基本运算符

- 算术运算符
  - \+  加
  - \-  减
  - \*  乘
  - \/  除
  - \%  取模
- 逻辑运算符
  - \&&  与
  - \||  或
  - \!   非
- 位运算符
  - \~   取反
  - \&   取与
  - \|   取或
  - \^   异或
- 关系运算符
  - \<    小于
  - \<=   小于等于
  - \>    大于
  - \>=   大于等于
- 等式运算符
  - \==    等于
  - \!=    不等
  - \===   全等
  - \!===  不全等
- 移位运算符
  - \>>   右移
  - \<<   左移
- 条件运算符
  - ? : 三目运算符
    ```verilog
    A = B ? C : D;  //当 B为真时，将 C 赋值给 A，否则将 D 赋值给 A
    ```
- 位接运算符
  - {} 将多个信号的位拼接起来
    ```verilog
    B[6:0] = 7'b1110010;
    C[4:0] = 5'b10010;
    A = {B[4:0], 0, C[1:0]};  //A = 10010010 = 10010,0,10
    ```

**注意优先级，建议使用括号。**

#### 语句

- 赋值语句(=; <=)
  - 阻塞赋值(=)
    用于组合逻辑模块，基本和编程语言中的赋值语句相同。
  - 非阻塞赋值(<=)
    用于时序逻辑模块，在一个时序触发结束时，所有非阻塞赋值语句同时执行。
  **举例比较:**注意看注释中的变量在赋值之后的结果值。

  ```verilog
  A = 2'd10;
  B = 2'd11;

  A = B;
  C = A;
  //A = 2'd11, B = 2'd11, C = 2'd11

  A = 2'd10;
  B = 2'd11;

  A <= B;
  C <= A;
  //A = 2'd11, B = 2'd11, C = 2'd10
  ```

- 块语句(begin-end)
  界定一组语句，可以大致类比在高级编程语言中的左右大括号。语句只有一条时，可省略。(*不同风格可以自行决定是否省略*)

  ```verilog
  begin
  A = B;
  C = A;
  end
  ```

- 条件语句(if-else,case)
  同高级编程语言，注意语法书写，使用块语句界定范围。
- 循环语句(for,while)
  同高级编程语言，注意语法书写，使用块语句界定范围。
- 过程语句(always,initial)
  - always
    通常是带有触发条件的，触发条件写在敏感信号表达式中，只有当触发条件满足时，其后的 begin-end 块语句才能被执行。
    ```verilog
    always @(<敏感信号表达式>) begin
    //过程赋值
    //if-else，case选择语句
    //while，repeat，for循环
    //function调用
    end
    ```
    - 时序信号触发
      ```verilog
      always  @(posedge CLK / negedge CLK) begin
      end
      ```
    - 电平信号触发
      ```verilog
      always @(Reset) begin
      end
      ```
    **两个触发方式不能混用！**
  - initial
    只执行一次，仿真开始时执行，不能综合。一般只用于初始化一些常量。
    ```verilog
    initial begin
    reg A[7:0] = 7'b10101111;
    end
    ```
- 宏替换语句

  ```verilog
  `define opAddi 8'b00000001
  ```

  使用宏替换语句后，我们可以直接使用

  ```verilog
  `opAddi
  ```

  来代替

  ```verilog
  8'b00000001
  ```

  。注意前面的符号 \`，无论在定义和使用时，都不能缺少。

#### 模块结构

模块的基础结构如下：

```verilog
module <顶层模块名> (<输入输出端口列表>);
input 输入端口列表; //输入端口声明
output 输出端口列表; //输出端口声明
/*定义数据，信号的类型，函数声明*/
reg 信号名;
//逻辑功能定义
assign <结果信号名> = <表达式>; //使用assign语句定义逻辑功能
//用always块描述逻辑功能
always @ (<敏感信号表达式>)
begin
//过程赋值
//if-else,case语句
//while,for循环语句
//function调用
end
//调用其他模块
<调用模块名module_name> <例化模块名> (<端口列表port_list>);
endmodule
```

我们定义模块，如同实现自己设计的电子元件，实现方法和 OOP 的类类似，学习过 C++ 的 OOP 的话，对这个理解就不会太困难。

更多语法细节问题，前往[Verilog Tutorial](http://www.asic-world.com/verilog/verilog_one_day1.html)查看。
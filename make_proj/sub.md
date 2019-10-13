# make命令
1. make  
2. make target
> 1、2默认会在当前目录下查找名为：makefile或Makefile
 2 make特定的目标

3. make ­f file
4. make ­f file target
> 同形式1、2，不过是指定名为的file的makefile文件

# makefile规则

> makefile由一系列的规则（rules）组成，而规则可以简单的认为是由 目标、依赖，命令组成，形式如下

![image.png](http://www.chendaye666.top:8888/group1/M00/00/00/rBIAAl2KJ_iATqo_AACl98zdWvs3808516)

> 只有目标文件不存在或依赖文件比目标文件新的情况下，才需要执行命令

# 简单的Makefile

## 项目目录结构
![image.png](http://www.chendaye666.top:8888/group1/M00/00/00/rBIAAl2KKLKAFKqZAAFJDPQSyvo6200851)

## makefile内容

```bash
#Makefile version 1

#第一个目标文件放在bin下面
all : ../bin/make_test
#依赖的文件
../bin/make_test : ./main.o \
                    ./sub1/head1.o \
					./sub1/head2.o \
					./sub2/head3.o \
					./sub2/head4.o
	# 命令用 tab开头
	g++ -o ../bin/make_test ./main.o \
                    ./sub1/head1.o \
					./sub1/head2.o \
					./sub2/head3.o \
					./sub2/head4.o

# 第二个目标文件 顺序是 反的
./main.o : ../src/main.cpp
	g++ -o ./main.o -c ../src/main.cpp -I ../inc/

# 一次类推
#Makefile version 1

#第一个目标文件放在bin下面
all : ../bin/make_test
#依赖的文件
../bin/make_test : ./main.o \
                    ./sub1/head1.o \
					./sub1/head2.o \
					./sub2/head3.o \
					./sub2/head4.o
	# 命令用 tab开头
	g++ -o ../bin/make_test ./main.o \
                    ./sub1/head1.o \
					./sub1/head2.o \
					./sub2/head3.o \
					./sub2/head4.o

# 第二个目标文件 顺序是 反的
./main.o : ../src/main.cpp
	g++ -o ./main.o -c ../src/main.cpp -I ../inc/

# 一次类推
./sub1/head1.o : ../src/sub1/head1.cpp
	g++ -o ./sub1/head1.o -c ../src/sub1/head1.cpp -I ../inc/

./sub1/head2.o : ../src/sub1/head2.cpp
	g++ -o ./sub1/head2.o -c ../src/sub1/head2.cpp -I ../inc/

./sub2/head3.o : ../src/sub2/head3.cpp
	g++ -o ./sub2/head3.o -c ../src/sub2/head3.cpp -I ../inc/

./sub2/head4.o : ../src/sub2/head4.cpp
	g++ -o ./sub2/head4.o -c ../src/sub2/head4.cpp -I ../inc/

# 删除文件
clean :
	rm -rf ../bin/make_test ./main.o ./sub2/*.o ./sub2/*.o
```

> make clean  指定 makefile 里面的一个target 执行； make ./sub2/head3.o

# 使用变量
> 使用变量让makefile更容易管理
## 概述

> Makefile变量的定义规则与bash变量定义类似（注意两者的区别）
variable = value或 variable := value

```bash
# makefile_test
var = old
var2 = $(var)
var = new

all :
	@echo $(var2)

# 执行makefile
make -f makefile_test 

# 结果输出  new  -> "="相当于 引用
```

```bash
# makefile_test
var = old
var2 := $(var)
var = new

all :
	@echo $(var2)

# 执行makefile
make -f makefile_test 

# 结果输出  old  -> ":="相当于 传值
```

> 变量值可以通过追加而改变，如:
OBJS += ../src/sub2/dummy3.o \
../src/sub2/dummy4.o
上面语句表示，变量OBJS(可能)在别处定义并已赋值，这里仅追加一些内容

## 使用变量

```bash
#Makefile version 2, 使用变量
RM = rm -rf

OBJS = ./main.o \
		./sub1/head1.o \
		./sub1/head2.o \
		./sub2/head3.o \
		./sub2/head4.o

#第一个目标文件放在bin下面
all : ../bin/make_test
#依赖的文件
../bin/make_test : $(OBJS)
	# 命令用 tab开头
	g++ -o ../bin/make_test $(OBJS)

# 第二个目标文件 顺序是 反的
./main.o : ../src/main.cpp
	g++ -o ./main.o -c ../src/main.cpp -I ../inc/

# 一次类推
./sub1/head1.o : ../src/sub1/head1.cpp
	g++ -o ./sub1/head1.o -c ../src/sub1/head1.cpp -I ../inc/

./sub1/head2.o : ../src/sub1/head2.cpp
	g++ -o ./sub1/head2.o -c ../src/sub1/head2.cpp -I ../inc/

./sub2/head3.o : ../src/sub2/head3.cpp
	g++ -o ./sub2/head3.o -c ../src/sub2/head3.cpp -I ../inc/

./sub2/head4.o : ../src/sub2/head4.cpp
	g++ -o ./sub2/head4.o -c ../src/sub2/head4.cpp -I ../inc/

# 删除文件
clean :
	$(RM) ../bin/make_test ./main.o ./sub2/*.o ./sub2/*.o
```



# 常用的自动变量

## 概述
|变量|说明|
|-|-|
|$@|指代规则中所有目标文件，如：main.o : main.cpp ($@指代main.o)|
|$%|当目标文件是静态库(.a文件)时，指代目标文件的成员。例如,如果一个目标是"foo.a(bar.o)",那么,"$%"就是"bar.o","$@"就是"foo.a"。如果目标不是静态库文件,那么,其值为空|
|$<|指代第一个依赖文件名|
|$?|指代所有比目标文件新的依赖文件|
|$^|指代所有依赖文件名，中间由空格分隔|
|$+|类似"$^",也是指代所有依赖文件。但改该变量不去除重复的依赖文件|

> 使用变量（包括自动变量）的安全方式是将变量名放入( )中：如：$<      $(<) 

## 改造makefile

```bash
#Makefile version 2, 使用变量
RM = rm -rf

OBJS = ./main.o \
		./sub1/head1.o \
		./sub1/head2.o \
		./sub2/head3.o \
		./sub2/head4.o

#第一个目标文件放在bin下面
all : ../bin/make_test
#依赖的文件
../bin/make_test : $(OBJS)
	# 命令用 tab开头
	g++ -o $(@) $(^)

# 第二个目标文件 顺序是 反的
./main.o : ../src/main.cpp
	g++ -o $(@) -c $(<) -I ../inc/

# 一次类推
./sub1/head1.o : ../src/sub1/head1.cpp
	g++ -o $(@) -c $(<) -I ../inc/

./sub1/head2.o : ../src/sub1/head2.cpp
	g++ -o $(@) -c $(<) -I ../inc/

./sub2/head3.o : ../src/sub2/head3.cpp
	g++ -o $(@) -c $(<) -I ../inc/

./sub2/head4.o : ../src/sub2/head4.cpp
	g++ -o $(@) -c $(<) -I ../inc/

# 删除文件
clean :
	$(RM) ../bin/make_test ./main.o ./sub2/*.o ./sub2/*.o
```  


# 使用%.o:%.c样式

> %的通配规则简单描述为：置换文件名中除前缀和后缀之外的主干部分

> %.o:%.c样式示例说明

```bash
%.o:%.cpp
	command ...
#上面一条规则等价于下面几条规则：
a.o : a.cpp
	command ...
b.o : b.cpp
	command ...

```

```bash
#Makefile version 2, 使用变量
RM = rm -rf

OBJS = ./main.o \
		./sub1/head1.o \
		./sub1/head2.o \
		./sub2/head3.o \
		./sub2/head4.o

#第一个目标文件放在bin下面
all : ../bin/make_test
#依赖的文件
../bin/make_test : $(OBJS)
	# 命令用 tab开头
	g++ -o $(@) $(^)

# 第二个目标文件 顺序是 反的
./%.o : ../src/%.cpp
	g++ -o $(@) -c $(<) -I ../inc/

# 一次类推
./sub1/%.o : ../src/sub1/%.cpp
	g++ -o $(@) -c $(<) -I ../inc/

./sub2/%.o : ../src/sub2/%.cpp
	g++ -o $(@) -c $(<) -I ../inc/

# 删除文件
clean :
	$(RM) ../bin/make_test ./main.o ./sub1/*.o ./sub2/*.o
```

# .PHONY与伪目标

## 定义：
如之前Makefile中的clean就是一个伪目标

```bash
clean:
	$(RM) $(OBJS) ../bin/*

```

> 这个目标并没有依赖文件，而rm命令也不会生成一个名为clean的文件。当make clean时，rm命令总是会被执行，因为clean这个文件不存在，按规则就得执行clean目标下的命令



## .PHONY 标签

> 作用是显式指定某个目标为伪目标，如.PHONY : clean ，表明不论是否有clean这个文件，make clean 中make都会将clean当作伪目标

```bash
#Makefile version 2, 使用变量
RM = rm -rf

OBJS = ./main.o \
		./sub1/head1.o \
		./sub1/head2.o \
		./sub2/head3.o \
		./sub2/head4.o

#第一个目标文件放在bin下面
all : ../bin/make_test
#依赖的文件
../bin/make_test : $(OBJS)
	# 命令用 tab开头
	g++ -o $(@) $(^)

# 第二个目标文件 顺序是 反的
./%.o : ../src/%.cpp
	g++ -o $(@) -c $(<) -I ../inc/

# 一次类推
./sub1/%.o : ../src/sub1/%.cpp
	g++ -o $(@) -c $(<) -I ../inc/

./sub2/%.o : ../src/sub2/%.cpp
	g++ -o $(@) -c $(<) -I ../inc/

# 指定伪目标, 防止有同名的目标根伪目标产生冲突
.PHONY : clean
# 删除文件
clean :
	$(RM) ../bin/make_test ./main.o ./sub1/*.o ./sub2/*.o
```

# Makefile模块化

## 区分模块

> 从这次的项目目录结构看，我们可以按源文件的目录结构将项目划分成3个部分：./src，./src/sub1，./src/sub2

> 根据上述划分，我们可以将Makefile分为4个文件

- ./build/Makefile：主makefile，负责完 成最后的工作，如链接，产生最终目标文件
- ./build/sub.mk：负责 生成./src下的目标文件(.o文件)
- ./build/sub1/sub.mk：负责 生成./src/sub1下的目标文件
- ./build/sub2/sub.mk：负责 生成./src/sub2下的目标文件

## 模块化

> 主Makefile文件
```bash
# 注意是 +=
OBJS += ./sub1/head1.o \
		./sub1/head2.o

# 一次类推
./sub1/%.o : ../src/sub1/%.cpp
	g++ -o $(@) -c $(<) -I ../inc/
```

> ./sub.mk

```bash
# 注意是 +=
OBJS += ./main.o

# 第二个目标文件 顺序是 反的
./%.o : ../src/%.cpp
	g++ -o $(@) -c $(<) -I ../inc/
```

> ./sub1/sub.mk

```bash
# 注意是 +=
OBJS += ./sub1/head1.o \
	./sub1/head2.o

# 一次类推
./sub1/%.o : ../src/sub1/%.cpp
	g++ -o $(@) -c $(<) -I ../inc/
```
> ./sub2/sub.mk

```bash
# 注意是 +=
OBJS += ./sub2/head3.o \
	./sub2/head4.o

# 一次类推
./sub1/%.o : ../src/sub2/%.cpp
	g++ -o $(@) -c $(<) -I ../inc/
```

# 修饰Makefile


> #1：在指令前加­，表示即使这条指令执行失败，也不影响make继续往下执行；

> #2：通过echo命令打印一些信息。在命令前添加@，表示不打印这条命令本身，而是打印命令的输出，如：echo 'test' 输出两行：echo 'test' 和 test@echo 'test' 只输出一行：test

# 总结

> Makefile的规则 远远 不止于我们这次课囊括的内容，更全面的学习 ，强烈建议大家花些时间和精力阅读The GNU Make Manual

[更多Makefile规则](http://www.gnu.org/software/make/manual/)

> 了解一下GNU项目中的autoconf、automake等autotools，非常强大的makefile配置以 及生成工具

[自动构建](http://www.gnu.org/software/autoconf/manual/)





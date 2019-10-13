#Makefile version 2, 使用变量
RM = rm -rf

include ./sub.mk
include ./sub1/sub.mk
include ./sub2/sub.mk

#第一个目标文件放在bin下面
all : ../bin/make_test
#依赖的文件
../bin/make_test : $(OBJS)
	# 命令用 tab开头
	g++ -o $(@) $(^)

# 指定伪目标, 防止有同名的目标根伪目标产生冲突
.PHONY : clean
# 删除文件
clean :
	$(RM) ../bin/make_test ./main.o ./sub1/*.o ./sub2/*.o
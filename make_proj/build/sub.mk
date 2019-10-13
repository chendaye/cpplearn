# 注意是 +=
OBJS += ./main.o

# 第二个目标文件 顺序是 反的
./%.o : ../src/%.cpp
	g++ -o $(@) -c $(<) -I ../inc/
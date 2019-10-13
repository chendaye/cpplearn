# 注意是 +=
OBJS += ./sub2/head3.o \
		./sub2/head4.o
		

./sub2/%.o : ../src/sub2/%.cpp
	g++ -o $(@) -c $(<) -I ../inc/
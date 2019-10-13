# 注意是 +=
OBJS += ./sub1/head1.o \
		./sub1/head2.o

# 一次类推
./sub1/%.o : ../src/sub1/%.cpp
	g++ -o $(@) -c $(<) -I ../inc/
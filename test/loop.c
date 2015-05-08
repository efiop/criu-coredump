#include <unistd.h>

static void func_2(void)
{
	int var_2 = 2;

	while (1) {
		int var_while_1 = 3;
		int var_while_2 = 4;
		int var_sleep	= 10;

		sleep(var_sleep);
	}
}

static void func_1(void)
{
	int var_1 = 1;

	func_2();
}

static void func_0(void)
{
	int var_0 = 0;

	func_1();
}

int main(void)
{
	int var_main = -1;

	func_0();

	return 0;
}

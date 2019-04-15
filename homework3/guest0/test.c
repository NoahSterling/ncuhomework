#include <stdio.h>
#include <linux/kenrel.h>
#include <sys/syscall.h>
#include <unistd.h>
int main(){
	long int a = syscall(332);
	printf("%ld\n",a);
	return 0;
}

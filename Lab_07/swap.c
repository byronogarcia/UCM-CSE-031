#include <stdio.h>

int proc(int a) {
	return a - 2;
}

void swap (int *px, int *py) {
	int *temp;

	*temp = *px;
	*px = *py;
	*py = *temp;
}

int main (){ 
	int a = 1, b = 2;
	proc(a);
	swap(&a, &b);
	}

#include <stdio.h>
int main()
{
	int num1 = 0;
	int i;

	printf("Enter the number of lines for the punishment: ");
	scanf("%d", &num1);
	
	if (num1 <= 0) {
		printf("You entered an incorrect value for the number of lines!\n");
	}
	else {
		for(i = 0; i < num1; i++) {
		printf("C programming language is the best! ");
		}
	}
	return 0;
}


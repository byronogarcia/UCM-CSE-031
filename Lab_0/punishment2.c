#include <stdio.h>
int main()
{
	int num1 = 0;
	int num2 = 0;
	int i;

	printf("Enter the number of lines for the punishment: ");
	scanf("%d", &num1);
	
	if (num1 <= 0) {
		printf("You entered an incorrect value for the number of lines!\n");
	}
	else {	
	
	
	printf("Enter the line for which we want to make a typo: ");
	scanf("%d", &num2);
	
	if (num2 <= 0 || num2 > num1) {
		printf("You entered an incorrect value for the number of lines!\n");
	}
	else {	
	

	for(i = 1; i <=  num1; i++) {
		if (num2 == i) {
		printf("C programming language is the bet! ");
		}
		else {
		printf("C programming language is the best! ");
		}
	}	
	}
	}
	return 0;
}



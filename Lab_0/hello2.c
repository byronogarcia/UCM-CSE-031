#include <stdio.h>
int main()
{
 	char str1[25];

	printf("Please enter your name: ");
	scanf("%[^\n]", str1);

	printf("Welcome to CSE031, %s", str1);
	printf("!\n");

	return 0;
}

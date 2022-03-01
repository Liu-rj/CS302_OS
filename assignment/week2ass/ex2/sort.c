#include <stdio.h>
#include <stdlib.h>

struct Student
{
	int number;
	int score;
};

int main()
{
   int n;
   scanf("%d", &n);
   struct Student students[n];
   struct Student temp;
   for (int i = 0; i < n; i++)
   {
	   scanf("%d %d", &students[i].number, &students[i].score);
   }
   for (int i = 0; i < n - 1; i++)
   {
	   for (int j = 0; j < n - 1 - i; j++)
	   {
		   if (students[j].score > students[j + 1].score)
		   {
			   temp = students[j];
			   students[j] = students[j + 1];
			   students[j + 1] = temp;
		   } else if (students[j].score == students[j + 1].score && students[j].number > students[j + 1].number) {
			   temp = students[j];
			   students[j] = students[j + 1];
			   students[j + 1] = temp;
		   }
	   }
   }
   printf("Output:\n");
   for (int i = 0; i < n; i++)
   {
	   printf("%d %d\n", students[i].number, students[i].score);
   }

   return 0;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NUM 9999

struct Node {
	int token;
	int index;
};

//each Identifier or String constants will store in stringTable[i]
//Also stringIndex[i] indicates the token name and index of stringTable[i]
char* stringTable[MAX_NUM];
struct Node* stringIndex[MAX_NUM];

//the number of elements in stringTable[]
int current_length = 0;

int insertTable(char* string, int token)
{
	int i = 0;
	for (i = 0; i < current_length; i++) {
		if ((strcasecmp(stringTable[i], string) == 0) && (stringIndex[i]->token == token))
			break;	//we find the new string matches one previous string
	}
	if (i == current_length) {
		if (current_length == 0) {
			stringTable[current_length] = (char* )malloc(sizeof(string));
			stringIndex[current_length] = (struct Node*)malloc(sizeof(struct Node));
			strcpy(stringTable[current_length], string);
			stringIndex[current_length]->token = token;
			stringIndex[current_length]->index = 0;
			current_length++;
			return 0;
		} else {
			stringTable[current_length] = (char* )malloc(sizeof(string));
			stringIndex[current_length] = (struct Node*)malloc(sizeof(struct Node));
			strcpy(stringTable[current_length], string);
			stringIndex[current_length]->token = token;
			stringIndex[current_length]->index = stringIndex[current_length - 1]->index + strlen(stringTable[current_length - 1]) + 1;
			current_length++;
			return stringIndex[current_length - 1]->index;
		}
	} else {
		return stringIndex[i]->index;
	}

}

void printTable(void)
{
	int i;
	for (i = 0; i < current_length; i++)
	{
		printf("%s ", stringTable[i]);
	}
	printf("\n");
}

void freeTable(void)
{
	int i;
	for (i = 0; i < current_length; i++)
	{
		free(stringTable[i]);
		free(stringIndex[i]);
	}
}

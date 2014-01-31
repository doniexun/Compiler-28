#include <stdio.h>
#include "token.h"

extern int yylex(void);

extern void printTable(void);
extern void freeTable(void);

extern int yyline;
extern int yycolumn;
extern int yylval;
extern char* yytext;

//All the token names
char* token[] = {
	"ANDnum", "ASSGNnum", "DECLARATIONSnum", "DOTnum",
	"ENDDECLARATIONSnum", "EQUALnum", "GTnum", "IDnum",
	"INTnum", "LBRACnum", "LPARENnum", "METHODnum",
	"NEnum", "ORnum", "PROGRAMnum", "RBRACnum",
	"RPARENnum", "SEMInum", "VALnum", "WHILEnum",
	"CLASSnum", "COMMAnum", "DIVIDEnum", "ELSEnum",
	"EQnum", "GEnum", "ICONSTnum", "IFnum",
	"LBRACEnum", "LEnum", "LTnum", "MINUSnum",
	"NOTnum", "PLUSnum", "RBRACEnum", "RETURNnum",
	"SCONSTnum", "TIMESnum", "VOIDnum", "EOFnum"
};

int main(void)
{
	printf("Line\tColumn\tToken\t\tIndex_in_String_table(or in your symbol table)\n");

	int temp;
	while((temp = yylex()) != 0) {
		switch(temp) {
			case IDnum:
				printf("%d\t%d\t%s\t\t%d\n", yyline, yycolumn, token[temp - 257], yylval);
				continue;
			case ICONSTnum:
				printf("%d\t%d\t%s\t%d\n", yyline, yycolumn, token[temp - 257], yylval);
				continue;
			case SCONSTnum:
				printf("%d\t%d\t%s\t%d\n", yyline, yycolumn, token[temp - 257], yylval);
				continue;
			default:
				printf("%d\t%d\t%s\n", yyline, yycolumn, token[temp - 257]);
				continue;
		}
	}

	printf(" \t \t%s\n","EOFnum");
	printf("\n");

	printTable();
	freeTable();
	return 0;
}
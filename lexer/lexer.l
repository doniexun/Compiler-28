%{
	#include <stdio.h>
	#include "token.h"

	int yylval;
	int yyline = 1;
	int yycolumn = 0;

	extern int insertTable(char* string, int token);
	void ReportError(char* errorMess, int yyline, int yycolumn);
%}

/* regular definition */
delim 					[ \t]
space					{delim}+
newline 				[\n]
letter 					[A-Za-z]
string					'[^'\n]*'
notEndString				'[^'\n]*
digit 					[0-9]
id 					{letter}({letter}|{digit})*
wrongid					{digit}+.*{letter}+.*
number 					{digit}+

%x					CheckComment
%option 				case-insensitive

%%

"/*"					BEGIN(CheckComment);
<CheckComment>\n			{yyline++; yycolumn = 0;}
<CheckComment>"*/"			{yycolumn += yyleng; BEGIN(INITIAL);}
<CheckComment>. 			{yycolumn += yyleng;}
<CheckComment><<EOF>>			{
						ReportError("This is a notEndComment", yyline, yycolumn);
						yyterminate();
					}

"\'"					{yycolumn += 1;}
"\\"					{yycolumn += 1;}
"\t"					{yycolumn += 1;}

{space}					{yycolumn += yyleng;}

{newline}				{yyline++; yycolumn = 0;}

declarations 				{yycolumn += yyleng; return(DECLARATIONSnum);}
enddeclarations 			{yycolumn += yyleng; return(ENDDECLARATIONSnum);}
method 					{yycolumn += yyleng; return(METHODnum);}
program 				{yycolumn += yyleng; return(PROGRAMnum);}
val 					{yycolumn += yyleng; return(VALnum);}
while 					{yycolumn += yyleng; return(WHILEnum);}
class 					{yycolumn += yyleng; return(CLASSnum);}
else 					{yycolumn += yyleng; return(ELSEnum);}
if 					{yycolumn += yyleng; return(IFnum);}
return 					{yycolumn += yyleng; return(RETURNnum);}
void 					{yycolumn += yyleng; return(VOIDnum);}
int 					{yycolumn += yyleng; return(INTnum);}

{id}					{
						yycolumn += yyleng;
						yylval = insertTable(yytext, IDnum);
						return(IDnum);
					}
{wrongid}				{
						yycolumn += yyleng;
						ReportError("This is a wrongID.", yyline, yycolumn);
					}
{number}				{
						yycolumn += yyleng;
						yylval = atoi(yytext);
						return(ICONSTnum);
					}
{string}				{
						yycolumn += yyleng;
						yylval = insertTable(yytext, SCONSTnum);
						return(SCONSTnum);
					}
{notEndString}				{
						yycolumn += yyleng;
						ReportError("This is a notEndString.", yyline, yycolumn);
					}
"&&"					{yycolumn += yyleng; return(ANDnum);}
":="					{yycolumn += yyleng; return(ASSGNnum);}
"."					{yycolumn += yyleng; return(DOTnum);}
"="					{yycolumn += yyleng; return(EQUALnum);}
">"					{yycolumn += yyleng; return(GTnum);}
"["					{yycolumn += yyleng; return(LBRACnum);}
"("					{yycolumn += yyleng; return(LPARENnum);}
"!="					{yycolumn += yyleng; return(NEnum);}
"||"					{yycolumn += yyleng; return(ORnum);}
"]"					{yycolumn += yyleng; return(RBRACnum);}
")"					{yycolumn += yyleng; return(RPARENnum);}
";"					{yycolumn += yyleng; return(SEMInum);}
","					{yycolumn += yyleng; return(COMMAnum);}
"/"					{yycolumn += yyleng; return(DIVIDEnum);}
"=="					{yycolumn += yyleng; return(EQnum);}
">="					{yycolumn += yyleng; return(GTnum);}
"{"					{yycolumn += yyleng; return(ANDnum);}
"<="					{yycolumn += yyleng; return(LEnum);}
"<"					{yycolumn += yyleng; return(LTnum);}
"-"					{yycolumn += yyleng; return(MINUSnum);}
"!"					{yycolumn += yyleng; return(NOTnum);}
"+"					{yycolumn += yyleng; return(PLUSnum);}
"}"					{yycolumn += yyleng; return(RBRACEnum);}
"*"					{yycolumn += yyleng; return(TIMESnum);}

.					{
						yycolumn += yyleng;
						ReportError("This is a Wrong Character.", yyline, yycolumn);
					}
%%

void ReportError(char* errorMess, int yyline, int yycolumn)
{
	printf("%s on line:%d, column:%d.\n", errorMess, yyline, yycolumn);
}

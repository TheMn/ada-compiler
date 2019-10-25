package cup.example;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java_cup.runtime.Symbol;
import java.lang.*;
import java.io.InputStreamReader;

%%

%class Lexer
%implements sym
%public
%unicode
%line
%column
%cup
%char
%{

	StringBuilder string_content = new StringBuilder();

    public Lexer(ComplexSymbolFactory sf, java.io.InputStream is){
		this(is);
        symbolFactory = sf;
    }
	public Lexer(ComplexSymbolFactory sf, java.io.Reader reader){
		this(reader);
        symbolFactory = sf;
    }
    
    private StringBuffer sb;
    private ComplexSymbolFactory symbolFactory;
    private int csline,cscolumn;

    public Symbol symbol(String name, int code){
		return symbolFactory.newSymbol(name, code,
						new Location(yyline+1,yycolumn+1, yychar), // -yylength()
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength())
				);
    }
    public Symbol symbol(String name, int code, String lexem){
	return symbolFactory.newSymbol(name, code, 
						new Location(yyline+1, yycolumn +1, yychar), 
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength()), lexem);
    }
    
    protected void emit_warning(String message){
    	System.out.println("scanner warning: " + message + " at : 2 "+ 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
    
    protected void emit_error(String message){
    	System.out.println("scanner error: " + message + " at : 2" + 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
%}

Newline    = \r | \n | \r\n
whitespace = [ \t\f] | {Newline}

comment = "--" [^\r\n]* 

digit = [0-9]
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Decimal Literals ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
numeral = {digit} ("_" {digit} | {digit})*
exponent = [Ee] "+" {numeral} | [Ee] {numeral} | [Ee] "-" {numeral}
decimal_literal = {integer_literal} | {float_literal}
integer_literal = {numeral} {exponent}?
float_literal = {numeral} "." {numeral} {exponent}?

extended_digit = {digit} | [A-F] | [a-f]
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Based Literals ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
based_numeral = {extended_digit} (("_")? {extended_digit})*
based_literal = {numeral} "#" {based_numeral} ("." {based_numeral})? "#" {exponent}?

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Identifiers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
letter = [a-zA-Z]
identifier = {letter} ("_"? ({letter} | {digit}))*

compare = "=" | "/=" | "<" | "<=" | ">" | ">="

string_character = [^\r\n\"\\]

%eofval{
    return symbolFactory.newSymbol("EOF",sym.EOF);
%eofval}

%state CODESEG
%state STRING

%%  

<YYINITIAL> {
  	
  \"				{yybegin(STRING);
					string_content.setLength(0); }
					
  /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Reserved words ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
  "abort"			{return symbolFactory.newSymbol("ABORT", ABORT);}
  "abs"				{return symbolFactory.newSymbol("ABS", ABS);}
  "abstract"		{return symbolFactory.newSymbol("ABSTRACT", ABSTRACT);}
  "accept"			{return symbolFactory.newSymbol("ACCEPT", ACCEPT);}
  "access"			{return symbolFactory.newSymbol("ACCESS", ACCESS);}
  "aliased"			{return symbolFactory.newSymbol("ALIASED", ALIASED);}
  "all"				{return symbolFactory.newSymbol("ALL", ALL);}
  "and"				{return symbolFactory.newSymbol("AND", AND);}
  "array"			{return symbolFactory.newSymbol("ARRAY", ARRAY);}
  "at"				{return symbolFactory.newSymbol("AT", AT);}
  "begin"			{return symbolFactory.newSymbol("BEGIN", BEGIN);}
  "body"			{return symbolFactory.newSymbol("BODY", BODY);}
  "case"			{return symbolFactory.newSymbol("CASE", CASE);}
  "constant"		{return symbolFactory.newSymbol("CONSTANT", CONSTANT);}
  "declare"			{return symbolFactory.newSymbol("DECLARE", DECLARE);}
  "delay"			{return symbolFactory.newSymbol("DELAY", DELAY);}
  "delta"			{return symbolFactory.newSymbol("DELTA", DELTA);}
  "digits"			{return symbolFactory.newSymbol("DIGITS", DIGITS);}
  "do"				{return symbolFactory.newSymbol("DO", DO);}
  "else"			{return symbolFactory.newSymbol("ELSE", ELSE);}
  "elsif"			{return symbolFactory.newSymbol("ELSIF", ELSIF);}
  "end"				{return symbolFactory.newSymbol("END", END);}
  "entry"			{return symbolFactory.newSymbol("ENTRY", ENTRY);}
  "exception"		{return symbolFactory.newSymbol("EXCEPTION", EXCEPTION);}
  "exit"			{return symbolFactory.newSymbol("EXIT", EXIT);}
  "for"				{return symbolFactory.newSymbol("FOR", FOR);}
  "function"		{return symbolFactory.newSymbol("FUNCTION", FUNCTION);}
  "generic"			{return symbolFactory.newSymbol("GENERIC", GENERIC);}
  "goto"			{return symbolFactory.newSymbol("GOTO", GOTO);}
  "if"				{return symbolFactory.newSymbol("IF", IF);}
  "in"				{return symbolFactory.newSymbol("IN", IN);}
  "interface"		{return symbolFactory.newSymbol("INTERFACE", INTERFACE);}
  "is"				{return symbolFactory.newSymbol("IS", IS, yyline);}
  "limited"			{return symbolFactory.newSymbol("LIMITED", LIMITED);}
  "loop"			{return symbolFactory.newSymbol("LOOP", LOOP);}
  "mod"				{return symbolFactory.newSymbol("MOD", MOD);}
  "new"				{return symbolFactory.newSymbol("NEW", NEW);}
  "null"			{return symbolFactory.newSymbol("NULL", NULL);}
  "not"				{return symbolFactory.newSymbol("NOT", NOT);}
  "of"				{return symbolFactory.newSymbol("OF", OF);}
  "or"				{return symbolFactory.newSymbol("OR", OR);}
  "others"			{return symbolFactory.newSymbol("OTHERS", OTHERS);}
  "out"				{return symbolFactory.newSymbol("OUT", OUT);}
  "overriding"		{return symbolFactory.newSymbol("OVERRIDING", OVERRIDING);}
  "package"			{return symbolFactory.newSymbol("PACKAGE", PACKAGE);}
  "pragma"			{return symbolFactory.newSymbol("PRAGMA", PRAGMA);}
  "private"			{return symbolFactory.newSymbol("PRIVATE", PRIVATE);}
  "procedure"		{return symbolFactory.newSymbol("PROCEDURE", PROCEDURE);}
  "protected"		{return symbolFactory.newSymbol("PROTECTED", PROTECTED);}
  "raise"			{return symbolFactory.newSymbol("RAISE", RAISE);}
  "range"			{return symbolFactory.newSymbol("RANGE", RANGE);}
  "record"			{return symbolFactory.newSymbol("RECORD", RECORD);}
  "rem"				{return symbolFactory.newSymbol("REM", REM);}
  "renames"			{return symbolFactory.newSymbol("RENAMES", RENAMES);}
  "requeue"			{return symbolFactory.newSymbol("REQUEUE", REQUEUE);}
  "return"			{return symbolFactory.newSymbol("RETURN", RETURN);}
  "reverse"			{return symbolFactory.newSymbol("REVERSE", REVERSE);}
  "select"			{return symbolFactory.newSymbol("SELECT", SELECT);}
  "separate"		{return symbolFactory.newSymbol("SEPARATE", SEPARATE);}
  "subtype"			{return symbolFactory.newSymbol("SUBTYPE", SUBTYPE);}
  "synchronized"	{return symbolFactory.newSymbol("SYNCHRONIZED", SYNCHRONIZED);}
  "tagged"			{return symbolFactory.newSymbol("TAGGED", TAGGED);}
  "task"			{return symbolFactory.newSymbol("TASK", TASK);}
  "terminate"		{return symbolFactory.newSymbol("TERMINATE", TERMINATE);}
  "then"			{return symbolFactory.newSymbol("THEN", THEN);}
  "type"			{return symbolFactory.newSymbol("TYPE", TYPE);}
  "until"			{return symbolFactory.newSymbol("UNTIL", UNTIL);}
  "use"				{return symbolFactory.newSymbol("USE", USE);}
  "when"			{return symbolFactory.newSymbol("WHEN", WHEN);}
  "while"			{return symbolFactory.newSymbol("WHILE", WHILE);}
  "with"			{return symbolFactory.newSymbol("WITH", WITH);}
  "xor"				{return symbolFactory.newSymbol("XOR", XOR);}
  
  "true"			{return symbolFactory.newSymbol("TRUE", TRUE);}
  "false"			{return symbolFactory.newSymbol("FALSE", FALSE);}
  "integer"			{return symbolFactory.newSymbol("INT", INT);}
  "float"			{return symbolFactory.newSymbol("FLOAT", FLOAT);}
  "boolean"			{return symbolFactory.newSymbol("BOOLEAN", BOOLEAN);}
  "character"		{return symbolFactory.newSymbol("CHAR", CHAR);}
  "string"			{return symbolFactory.newSymbol("STR_TYP", STR_TYP);}
  
  /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ I/O ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
  "put"				{return symbolFactory.newSymbol("PUT", PUT);}
  "get"				{return symbolFactory.newSymbol("GET", GET);}
  
  {whitespace} 		{ /* NOTHING */ }
  
  {comment}			{ /* NOTHING */ }
  
  /* 12  3.14159_26  1E6  123_456 */		
  {decimal_literal} {return symbolFactory.newSymbol("DECIMAL_LITERAL", DECIMAL_LITERAL, yytext());}
  
  /* 16#F.FF#E+2  2#1111_1111#  016#0ff# */			
  {based_literal}	{return symbolFactory.newSymbol("BASED_LITERAL", BASED_LITERAL, yytext());}
   					
  {identifier}		{return symbolFactory.newSymbol("IDENTIFIER", IDENTIFIER, yytext());}
  					// symbol(sym.IDENTIFIER, yytext())

  /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Separators, and Delimiters ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
  "=>"				{return symbolFactory.newSymbol("ARROW", ARROW);}
  ".."				{return symbolFactory.newSymbol("DOUBLE_DOT", DOUBLE_DOT);}
  "**"				{return symbolFactory.newSymbol("DOUBLE_STAR", DOUBLE_STAR);}
  ":="				{return symbolFactory.newSymbol("ASSIGNMENT", ASSIGNMENT);}
  "<<"				{return symbolFactory.newSymbol("LLABEL", LLABEL);}
  ">>"				{return symbolFactory.newSymbol("RLABEL", RLABEL);}
  {compare}			{return symbolFactory.newSymbol("COMPARE", COMPARE);}
  
  "&"				{return symbolFactory.newSymbol("LOGICAL_AND", LOGICAL_AND);}
  "\'"				{return symbolFactory.newSymbol("APOSTROPHE", APOSTROPHE);}
  "("				{return symbolFactory.newSymbol("OPARENTHESIS", OPARENTHESIS);}
  ")"				{return symbolFactory.newSymbol("CPARENTHESIS", CPARENTHESIS);}
  "*"				{return symbolFactory.newSymbol("TIMES", TIMES);}
  "+"				{return symbolFactory.newSymbol("PLUS", PLUS);}
  ","				{return symbolFactory.newSymbol("COMMA", COMMA);}
  "-"				{return symbolFactory.newSymbol("MINUS", MINUS);}
  "."				{return symbolFactory.newSymbol("DOT", DOT);}
  "/"				{return symbolFactory.newSymbol("SLASH", SLASH);}
  ":"				{return symbolFactory.newSymbol("COLON", COLON);}
  ";"				{return symbolFactory.newSymbol("SEMI", SEMI, yyline);}
  "|"				{return symbolFactory.newSymbol("LOGICAL_OR", LOGICAL_OR);}
  
}

<STRING> {

  /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ String literal ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
  \"					{yybegin(YYINITIAL);
  						return symbolFactory.newSymbol("STR", STR, string_content.toString());
  						// symbol(sym.STR, string_content.toString())
  						}
  
  {string_character}+	{string_content.append(yytext()); }
  
  "\\b"					{string_content.append('\b'); }
  "\\t"					{string_content.append('\t'); }
  "\\n"					{string_content.append('\n'); }
  "\\f"					{string_content.append('\f'); }
  "\\r"					{string_content.append('\r'); }
  "\\\""				{string_content.append('\"'); }
  "\\\\"				{string_content.append('\\'); }
  
  \\.					{throw new RuntimeException("Illegal escape sequence \"" + yytext() + "\""); }

}


// error fallback
.|\n          { emit_warning("Unrecognized character '" +yytext()+"' -- ignored"); }

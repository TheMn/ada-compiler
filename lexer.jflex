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
  "abort"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "abs"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "abstract"		{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "accept"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "access"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "aliased"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "all"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "and"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "array"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "at"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "begin"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "body"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "case"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "constant"		{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "declare"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "delay"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "delta"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "digits"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "do"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "else"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "elsif"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "end"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "entry"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "exception"		{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "exit"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "for"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "function"		{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "generic"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "goto"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "if"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "in"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "interface"		{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "is"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "limited"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "loop"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "mod"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "new"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "null"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "not"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "of"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "or"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "others"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "out"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "overriding"		{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "package"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "pragma"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "private"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "procedure"		{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "protected"		{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "raise"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "range"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "record"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "rem"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "renames"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "requeue"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "return"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "reverse"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "select"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "separate"		{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "subtype"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "synchronized"	{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "tagged"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "task"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "terminate"		{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "then"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "type"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "until"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "use"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "when"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "while"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "with"			{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  "xor"				{System.out.print("matched Keyword [" + yytext() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  
  {whitespace} 		{                              }
  
  {comment}			{System.out.println("-FOUND- comment: " + yytext());
   					System.out.println("\t~~ line: " + yyline);
   					System.out.println("\t~~ column: " + yycolumn); }
  
  /* 12  3.14159_26  1E6  123_456 */		
  {decimal_literal} {System.out.println("-FOUND- decimal literal " + yytext());
   					System.out.println("\t~~ line: " + yyline);
   					System.out.println("\t~~ column: " + yycolumn); }
  
  /* 16#F.FF#E+2  2#1111_1111#  016#0ff# */			
  {based_literal}	{System.out.println("-FOUND- based literal " + yytext());
   					System.out.println("\t~~ line: " + yyline);
   					System.out.println("\t~~ column: " + yycolumn); }
   					
  {identifier}		{System.out.println("-FOUND- identifier " + yytext());
   					System.out.println("\t~~ line: " + yyline);
   					System.out.println("\t~~ column: " + yycolumn); }

  /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Separators, and Delimiters ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
  "=>"				{System.out.println("-FOUND- arrow"); }
  ".."				{System.out.println("-FOUND- double dot"); }
  "**"				{System.out.println("-FOUND- double star"); }
  ":="				{System.out.println("-FOUND- assignment"); }
  "/="				{System.out.println("-FOUND- inequality"); }
  ">="				{System.out.println("-FOUND- greater than or equal"); }
  "<="				{System.out.println("-FOUND- less than or equal"); }
  "<<"				{System.out.println("-FOUND- left label bracket"); }
  ">>"				{System.out.println("-FOUND- right label bracket"); }	
  
  "&"				{System.out.println("-FOUND- and"); }	
  "\'"				{System.out.println("-FOUND- apostrophe"); }	
  "("				{System.out.println("-FOUND- open parenthesis"); }	
  ")"				{System.out.println("-FOUND- close parenthesis"); }	
  "*"				{System.out.println("-FOUND- star"); }	
  "+"				{System.out.println("-FOUND- plus"); }	
  ","				{System.out.println("-FOUND- comma"); }	
  "-"				{System.out.println("-FOUND- dash"); }	
  "."				{System.out.println("-FOUND- dot"); }	
  "/"				{System.out.println("-FOUND- slash"); }	
  ":"				{System.out.println("-FOUND- colon"); }	
  ";"				{System.out.println("-FOUND- semicolon"); }	
  "<"				{System.out.println("-FOUND- less than"); }	
  "="				{System.out.println("-FOUND- equality"); }	
  ">"				{System.out.println("-FOUND- greater than"); }	
  "|"				{System.out.println("-FOUND- or"); }	

}

<STRING> {

  /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ String literal ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
  \"					{yybegin(YYINITIAL);
  						System.out.println("matched String [" + string_content.toString() + "] at line [" + yyline + "], column [" + yycolumn + "]\n"); }
  
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

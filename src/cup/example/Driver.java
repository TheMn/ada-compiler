/**
 * The main driver class for the Ada subset compiler.
 * This class initializes the parser and starts the parsing process.
 */
package cup.example;

import java_cup.runtime.*;

class Driver {

	/**
	 * The main entry point of the compiler.
	 * It creates a new parser instance and calls its parse method.
	 *
	 * @param args Command line arguments (not used).
	 * @throws Exception if there is an error during parsing.
	 */
	public static void main(String[] args) throws Exception {
		Parser parser = new Parser();
		parser.parse();
	}
	
}
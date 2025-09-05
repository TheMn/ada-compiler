# Ada Subset Compiler

This project is a compiler for a subset of the Ada programming language, developed as a university project for Guilan University. It uses JFlex for lexical analysis and CUP for parsing.

## Project Structure

The repository is organized as follows:

- `lexer.jflex`: The JFlex file that defines the lexical scanner. It contains rules to recognize tokens like keywords, identifiers, literals, and operators.
- `parser.cup`: The CUP file that defines the grammar of the Ada subset and the actions to be taken when grammar rules are matched.
- `build.xml`: The Ant build file used to automate the process of generating the scanner and parser and compiling the project.
- `src/`: This directory contains the Java source code for the compiler.
    - `cup/example/Driver.java`: The main entry point of the compiler.
    - `cup/example/Lexer.java`: The generated lexer file (from `lexer.jflex`).
    - `cup/example/Parser.java`: The generated parser file (from `parser.cup`).
    - `cup/example/sym.java`: The generated symbol file (from `parser.cup`).
- `tools/`: This directory contains the necessary JAR files for JFlex and CUP.
- `bin/`: This directory is created during the build process and contains the compiled `.class` files.
- `input.txt`: A sample input file for the compiler.

## Build

To build the compiler, you need to have [Apache Ant](https://ant.apache.org/) installed. Navigate to the root directory of the project and run the following command:

```bash
ant compile
```

This command will:
1.  Generate the lexer (`Lexer.java`) and parser (`Parser.java`, `sym.java`) from the `.jflex` and `.cup` files.
2.  Compile all the Java source files into the `bin/cls` directory.

To clean the build artifacts, you can run:

```bash
ant clean
```

## Run

After building the project, you can run the compiler on the `input.txt` file (or any other file with the same name) by executing the following command from the root directory:

```bash
java -cp "bin/cls:tools/java-cup-11b-runtime.jar" cup.example.Driver
```

The compiler will parse the `input.txt` file and print the results of the semantic analysis to the console.

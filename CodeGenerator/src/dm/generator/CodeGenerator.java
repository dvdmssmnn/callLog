package dm.generator;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;

import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.OptionBuilder;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;

import dm.generator.antlr.SimpleHeaderLexer;
import dm.generator.antlr.SimpleHeaderParser;

public class CodeGenerator {

	public static void main(String[] args) throws IOException,
			InterruptedException {
		CommandLineParser commandLineParser = new DefaultParser();

		Options options = new Options();

		Option out = new Option("out", true, "Destination dir");
		options.addOption(OptionBuilder.withLongOpt("out").hasArg().create());
		options.addOption(OptionBuilder.withLongOpt("package").hasArg()
				.create());
		options.addOption(OptionBuilder.withLongOpt("in").hasArg().create());

		String inFilename = null;
		String outFilename = null;
		String packagename = null;

		try {
			CommandLine cmd = commandLineParser.parse(options, args);

			if (!cmd.hasOption("in") || !cmd.hasOption("package")
					|| !cmd.hasOption("in")) {
				System.err.println("Missing options");
				return;
			}

			inFilename = cmd.getOptionValue("in");
			outFilename = cmd.getOptionValue("out");
			packagename = cmd.getOptionValue("package");
		} catch (ParseException e) {
			e.printStackTrace();
		}

		ANTLRFileStream inFile = new ANTLRFileStream(inFilename);
		SimpleHeaderLexer lexer = new SimpleHeaderLexer(inFile);
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		SimpleHeaderParser parser = new SimpleHeaderParser(tokens);

		MySimpleHeaderListener listener = new MySimpleHeaderListener(
				packagename);
		parser.addParseListener(listener);

		parser.expression();

		FileWriter fileWriter = new FileWriter(new File(outFilename));
		fileWriter.write(listener.generateCode());

		fileWriter.flush();
		fileWriter.close();

		Process p = Runtime.getRuntime().exec(
				String.format("/usr/local/bin/astyle %s/%s",
						System.getProperty("user.dir"), outFilename));
		p.waitFor();
		BufferedReader b = new BufferedReader(new InputStreamReader(
				p.getInputStream()));
		String line = "";
		while ((line = b.readLine()) != null) {
			System.out.println(line);
		}
	}

}

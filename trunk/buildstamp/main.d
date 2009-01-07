module main;

import buildstamp;

import tango.io.FilePath;
import tango.io.File;
import tango.io.Stdout;
import Integer = tango.text.convert.Integer;
import Text = tango.text.Util;

const char[] ver = "0.1";

char[] buildstampFile = "buildstamp";

void main (char[][]args)
{
	if (args.length < 2)
	{
		return printHelp();
	}
	
	int addval = 0;
	uint buildstamp = 0;	
	int argoffset = 2;
	
	switch(args[1])
	{
		case "inc":
			addval++;
			break;
		case "dec":
			addval--;
			break;
		case "set":
			try
			{
				addval = 0;
				buildstamp = Integer.toInt!(char)(args[2]);
				argoffset = 3;
			}
			catch (Exception e)
			{
				return printHelp;
			}
			break;
		default:
			return printHelp;
	}
	
	foreach(arg;args[argoffset..$])
	{
		try
		{
			if (arg[0..3] == "-o:")
			{
				buildstampFile = arg[3..$];
			}
		}
		catch (Exception e)
		{
			// we don't want to handle index out of bounds :)
		}
	}

	auto fp = FilePath("").file(buildstampFile ~ ".d");
	bool existed = fp.exists;
	if (!existed)
	{
		fp.createFile;
	}

	auto file = new File(buildstampFile ~ ".d");
	
	if (!existed || !addval)
	{
		file.write(write(buildstamp));
	}
	else
	{
		buildstamp = read(cast(char[])file.read()) + addval;
		file.write(write(buildstamp));
	}
}

int read(char[] file)
{
	int ret = 0;
	foreach(line;Text.lines(file))
	{
		const char[] prefix = "public const uint buildstamp_uint = ";
		if (line.length > prefix.length && line[0..prefix.length] == prefix)
		{
			char[] build = line[prefix.length..$-1];
			return Integer.toInt!(char)(build);
		}
	}
	return ret;
}

char[] write(int buildNr = 0)
{
	char[] file = "/**\r\n"
				~ " * !!! DO NOT MODIFY THIS FILE !!!\r\n"
				~ " * This file has been created by buildstamp v"~ver~" build "~buildstamp_char~"\r\n"
				~ " * (c) 2009 Martin Poehlmann\r\n"
				~ " * http://www.skinconsortium.com\r\n"
				~ " */\r\n\r\n"
				~ "module "~buildstampFile~";\r\n\r\n"
				~ "public const uint buildstamp_uint = " ~ Integer.toString(buildNr) ~ ";\r\n"
				~ "public const char[] buildstamp_char = \"" ~ Integer.toString(buildNr) ~ "\";";

	return file;				
}

void printHelp()
{
		Stdout("buildstamp v"~ver~" build "~buildstamp_char).newline;
		Stdout("(c) 2009 Martin Poehlmann").newline;
		Stdout("http://www.skinconsortium.com").newline.newline;
		Stdout("usage: buildstamp <mode> [mode-parameters] [-o:filename]").newline.newline;
		Stdout("available modes:").newline;
		Stdout("  inc          - increments the buildstamp").newline;
		Stdout("  dec          - decrements the buildstamp").newline;
		Stdout("  set <value>  - sets the buildstamp to value").newline.newline;
		Stdout("available params:").newline;
		Stdout("  -o:filename  - uses filename.d as output file instead of buildstamp.d").newline; 
}
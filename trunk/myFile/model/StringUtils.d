/**
 * String utils
 * 
 * @author mpdeimos
 */
module model.StringUtils;

import Text = tango.text.Util;

/** in place editing of the given string. replaces & -> &amp; < -> &lt; > -> &gt; */
T[] xmlDecode(T) (T[] input)
{
	input = Text.substitute!(T)(input, "&", "&amp;");
	input = Text.substitute!(T)(input, "<", "&lt;");
	input = Text.substitute!(T)(input, ">", "&gt;");
	input = Text.substitute!(T)(input, "\"", "&quot;");
	
	return input;
}

/** in place editing of the given string. replaces & <- &amp; < <- &lt; > <- &gt; */
T[] xmlEncode(T) (T[] input)
{
	input = Text.substitute!(T)(input, "&gt;", ">");
	input = Text.substitute!(T)(input, "&lt;", "<");
	input = Text.substitute!(T)(input, "&amp;", "&");
	input = Text.substitute!(T)(input, "&quot;", "\"");
	
	return input;
}

/** in place editing of the given string. replaces & <- &amp; < <- &lt; > <- &gt; */
T[] nlToBr(T) (T[] input)
{
	input = Text.substitute!(T)(input, "\r", "<br/>\r");
	
	return input;
}
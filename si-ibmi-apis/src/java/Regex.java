package src.java;

import java.util.regex.Pattern;
import com.ibm.db2.app.*;

public class Regex extends UDF {

	public static char matches (String pattern, String text) {
		
		if (Pattern.matches(pattern, text)) {
			return '1';
		} else {
			return '0';
		}
	}
}

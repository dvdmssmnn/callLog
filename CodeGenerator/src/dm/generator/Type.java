package dm.generator;

public class Type {
	private String type;

	public Type(String type) {
		this.type = type;
	}

	public String getTypeEncoding() {
		if (type.equals("int")) {
			return "i";
		} else if (type.contains("*")) {
			return "^"
					+ type.replace("const", "").replace(" ", "")
							.replace("*", "");
		}
		return type;
	}

	public String getFormatSpecifier() {
		// TODO
		if (type.contains("*")) {
			return ("0x%X");
		}
		return "%d";
	}

	public String getTypeCast() {
		// TODO
		if (type.contains("*")) {
			return "register_t";
		}
		return "int";
	}

	@Override
	public String toString() {
		return type;
	}
}

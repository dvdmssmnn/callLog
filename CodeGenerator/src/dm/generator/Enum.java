package dm.generator;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Enum {
	private String name;
	private List<EnumValue> values = new ArrayList<EnumValue>();

	public static Map<String, Enum> enums = new HashMap<String, Enum>();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<EnumValue> getValues() {
		return values;
	}

	public void setValues(List<EnumValue> values) {
		this.values = values;
	}

	public void addValue(EnumValue value) {
		for (EnumValue v : values) {
			if (v.getValue().equals(value.getValue())) {
				return;
			}
		}
		values.add(value);
	}

	@Override
	public String toString() {
		StringWriter writer = new StringWriter();
		writer.append(name);
		writer.append("\n");
		for (EnumValue v : values) {
			writer.append(String.format("\t%s = %s\n", v.getName(),
					v.getValue()));
		}
		return writer.toString();
	}

	public String generateSwitch(String variableName, String descriptionName) {
		StringWriter writer = new StringWriter();

		writer.append(String.format("switch (%s) {\n", variableName));

		for (EnumValue value : values) {
			writer.append(String.format("case %s:\n", value.getValue()));
			writer.append(String.format("%s = \"%s\";\n", descriptionName,
					value.getName()));
			writer.append("break;\n");
		}

		writer.append("}");

		return writer.toString();
	}

	public void removeDuplicateValues() {
		for (int i = 0; i < values.size(); ++i) {
			for (int j = 0; j < values.size(); ++j) {
				if (i == j) {
					continue;
				}

				if (values.get(i).getValue().equals(values.get(j).getValue())) {
					values.remove(j);
					j--;
				}
			}
		}
	}

}

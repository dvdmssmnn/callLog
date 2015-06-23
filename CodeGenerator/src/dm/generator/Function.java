package dm.generator;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

public class Function {
	public static final String HOOK_FUNCTION_PREFIX = "____";
	public static final String ORIGINAL_PREFIX = "original_";

	private String name;
	private Type returnType;
	private String clazz;
	private List<Parameter> parameter = new ArrayList<Parameter>();

	public void addParameter(Parameter parameter) {
		this.parameter.add(parameter);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Type getReturnType() {
		return returnType;
	}

	public void setReturnType(Type returnType) {
		this.returnType = returnType;
	}

	public String getClazz() {
		return clazz;
	}

	public void setClazz(String clazz) {
		this.clazz = clazz;
	}

	public List<Parameter> getParameter() {
		return this.parameter;
	}

	public String generateHookCode() {
		StringWriter writer = new StringWriter();

		writer.append(getHookFunctionHeader());
		writer.append("\n");

		writer.append("{\n");

		writer.append("    thread_storage_t *thread_infos = get_thread_infos();"
				+ "    call_id_t callID;\n"
				+ "    pthread_mutex_lock(&counter_mutex);\n"
				+ "    ++counter;\n"
				+ "    callID = counter;\n"
				+ "    pthread_mutex_unlock(&counter_mutex);\n"
				+

				"    call_id_t caller_id = 0;\n"
				+ "    if (thread_infos->call_id_stack->size()) {\n"
				+ "        caller_id = thread_infos->call_id_stack->back();\n"
				+ "    }\n"
				+ "    thread_infos->call_id_stack->push_back(callID);\n");

		writer.append("    vector<argument_t> args;\n");

		for (Parameter p : this.parameter) {
			String varName = String.format("%s_arg", p.getName());
			writer.append(String.format("    argument_t %s;\n", varName));
			writer.append(String.format("    %s.type = \"%s\";\n", varName, p
					.getType().getTypeEncoding()));

			if (Enum.enums.get(p.getType().toString()) != null) {
				writer.append(Enum.enums.get(p.getType().toString())
						.generateSwitch(p.getName(), varName + ".description"));
			}
			writer.append(String.format("char %s_value[200];\n", p.getName()));
			writer.append(String.format("snprintf(%s, 200, \"%s\", (%s)%s);\n",
					String.format("%s_value", p.getName()), p.getType()
							.getFormatSpecifier(), p.getType().getTypeCast(), p
							.getName()));
			writer.append(String.format("%s.value = %s_value;\n", varName,
					p.getName()));

			writer.append(String.format("    args.push_back(%s);\n\n", varName));
		}

		writer.append("if (enabled_) {\n");
		writer.append("    dispatch_async(db_queue, ^{\n");
		writer.append(String
				.format("        insert_call(to_string(callID), to_string(caller_id), \"%s\", \"%s\", \"0x0\", args);\n",
						clazz, name));
		writer.append("    });\n");
		writer.append("}\n");

		boolean hasReturnValue = false;
		if (!returnType.toString().equals("void")) {
			writer.append(String.format("    %s return_value = ",
					returnType.toString()));
			hasReturnValue = true;
		}

		writer.append(String.format("    %s%s(", ORIGINAL_PREFIX, name));
		for (int i = 0; i < parameter.size(); ++i) {
			if (i != 0) {
				writer.append(", ");
			}
			writer.append(parameter.get(i).getName());
		}
		writer.append(");\n");

		if (hasReturnValue) {
			String returnDescriptionName = "return_value_arg";
			writer.append(String.format("argument_t %s;\n",
					returnDescriptionName));
			writer.append(String.format("%s.type = \"%s\";\n",
					returnDescriptionName, getReturnType().toString()));

			if (Enum.enums.get(returnType.toString()) != null) {
				writer.append(Enum.enums.get(returnType.toString())
						.generateSwitch("return_value",
								returnDescriptionName + ".description"));
			}
			writer.append(String
					.format("char %s_value[200];\n", "return_value"));
			writer.append(String.format("snprintf(%s, 200, \"%s\", (%s)%s);\n",
					String.format("%s_value", "return_value"), getReturnType()
							.getFormatSpecifier(), getReturnType()
							.getTypeCast(), "return_value"));
			writer.append(String.format("%s.value = %s_value;\n",
					"return_value_arg", "return_value"));

			writer.append("if (enabled_) {\n");
			writer.append("    dispatch_async(db_queue, ^{\n");
			writer.append(String.format(
					"        insert_return(to_string(callID), %s);\n",
					returnDescriptionName));
			writer.append("    });\n");
			writer.append("}\n");
		}

		writer.append("    thread_infos->call_id_stack->pop_back();\n");

		if (hasReturnValue) {
			writer.append("    return return_value;");
		}

		writer.append("}\n\n");

		return writer.toString();
	}

	public String getHookFunctionHeader() {
		StringWriter writer = new StringWriter();

		writer.append(String.format("%s %s%s(", returnType,
				HOOK_FUNCTION_PREFIX, name));

		for (int i = 0; i < parameter.size(); ++i) {
			if (i != 0) {
				writer.append(", ");
			}
			Parameter p = parameter.get(i);
			writer.append(String.format("%s %s", p.getType(), p.getName()));
		}

		writer.append(")");

		return writer.toString();
	}
}

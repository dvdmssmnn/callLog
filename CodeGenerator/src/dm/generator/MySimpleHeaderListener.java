package dm.generator;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

import dm.generator.antlr.SimpleHeaderBaseListener;
import dm.generator.antlr.SimpleHeaderParser.Enum_entryContext;
import dm.generator.antlr.SimpleHeaderParser.Enum_specifierContext;
import dm.generator.antlr.SimpleHeaderParser.Enum_valueContext;
import dm.generator.antlr.SimpleHeaderParser.Function_decContext;
import dm.generator.antlr.SimpleHeaderParser.IncludeContext;
import dm.generator.antlr.SimpleHeaderParser.ParamContext;
import dm.generator.antlr.SimpleHeaderParser.TypedefContext;

public class MySimpleHeaderListener extends SimpleHeaderBaseListener {

	private Function currentFunction = null;
	private List<Function> functions = new ArrayList<Function>();
	private String clazz;
	private Enum currentEnum = null;

	private List<String> includes = new ArrayList<String>();

	public MySimpleHeaderListener(String clazz) {
		this.clazz = clazz;
	}

	@Override
	public void enterEnum_specifier(Enum_specifierContext ctx) {
		currentEnum = new Enum();
	}

	@Override
	public void exitEnum_specifier(Enum_specifierContext ctx) {
		if (!ctx.children.get(1).getText().equals("{")) {
			currentEnum.setName(ctx.children.get(1).getText());
		}
		if (currentEnum.getName() != null) {
			Enum.enums.put(currentEnum.getName(), currentEnum);
			currentEnum.removeDuplicateValues();
		}
	}

	@Override
	public void enterFunction_dec(Function_decContext ctx) {
		currentFunction = new Function();
		currentFunction.setClazz(clazz);
	}

	@Override
	public void exitFunction_dec(Function_decContext ctx) {
		currentFunction.setReturnType(new Type(ctx.children.get(0).getText()));
		currentFunction.setName(ctx.children.get(1).getText());

		this.functions.add(currentFunction);

		currentFunction = null;
	}

	@Override
	public void exitParam(ParamContext ctx) {
		Parameter p = new Parameter();

		String typeString = "";
		for (int i = 0; i < ctx.children.get(0).getChildCount(); ++i) {
			if (i != 0) {
				typeString += " ";
			}
			typeString += ctx.children.get(0).getChild(i).getText();
		}
		p.setType(new Type(typeString));
		p.setName(ctx.children.get(1).getText());
		currentFunction.addParameter(p);
	}

	@Override
	public void exitInclude(IncludeContext ctx) {
		includes.add(String.format("%s %s%s%s", ctx.children.get(0).getText(),
				ctx.children.get(1).getText(), ctx.children.get(2).getText(),
				ctx.children.get(3).getText()));

	}

	@Override
	public void enterEnum_entry(Enum_entryContext ctx) {
		currentEnum.addValue(new EnumValue());
	}

	@Override
	public void exitEnum_entry(Enum_entryContext ctx) {
		EnumValue a = null;
		if (currentEnum.getValues().size() > 1) {
			a = currentEnum.getValues().get(currentEnum.getValues().size() - 2);
		}
		EnumValue b = currentEnum.getValues().get(
				currentEnum.getValues().size() - 1);
		b.setName(ctx.start.getText());

		if (b.getValue() == null) {
			if (a == null) {
				b.setValue("0");
			} else {
				b.setValue(String.format("%d",
						Integer.valueOf(a.getValue()) + 1));
				;
			}
		}
	}

	@Override
	public void exitEnum_value(Enum_valueContext ctx) {
		String stringVal = ctx.stop.getText();
		if (stringVal.startsWith("0x")) {
			stringVal = stringVal.replace("0x", "");
			stringVal = String.valueOf(Integer.parseInt(stringVal, 16));
		}
		currentEnum.getValues().get(currentEnum.getValues().size() - 1)
				.setValue(stringVal);
	}

	@Override
	public void exitTypedef(TypedefContext ctx) {
		if (currentEnum != null) {
			currentEnum.setName(ctx.children.get(ctx.children.size() - 2)
					.getText());
			Enum.enums.put(currentEnum.getName(), currentEnum);
			currentEnum.removeDuplicateValues();
		}
	}

	public String generateCode() {
		StringWriter writer = new StringWriter();

		writer.append(String.format("#import \"HookHelper.h\"\n\n"));
		writer.append("#import \"SQLiteStorage.h\"\n");
		writer.append("#import \"ThreadStorage.h\"\n");
		writer.append("#import <vector>\n");
		writer.append("#import <string>\n");
		writer.append("#import <pthread.h>\n");
		writer.append("#import <pthread.h>\n");
		writer.append("#import \"Config.h\"\n");
		writer.append("#import <CydiaSubstrate/CydiaSubstrate.h>\n");

		for (String include : includes) {
			writer.append(String.format("%s\n", include));
		}

		writer.append("\n");
		writer.append("using namespace std;\n");

		for (Function f : functions) {
			writer.append(String.format("%s;\n\n", f.getHookFunctionHeader()));
		}

		writer.append(generateConstructor());

		for (Function f : functions) {
			writer.append(String.format("%s\n", f.generateHookCode()));
		}

		return writer.toString();
	}

	public String generateConstructor() {
		StringWriter writer = new StringWriter();

		for (Function f : functions) {
			writer.append(String.format("%s (*%s%s)(", f.getReturnType(),
					Function.ORIGINAL_PREFIX, f.getName()));

			List<Parameter> parameter = f.getParameter();
			for (int i = 0; i < parameter.size(); ++i) {
				if (i != 0) {
					writer.append(", ");
				}
				writer.append(parameter.get(i).getType().toString());
			}

			writer.append(");\n");
		}

		writer.append("__attribute__((constructor))\n"
				+ "static void initialize() {\n");

		for (Function f : functions) {
			writer.append(String
					.format("MSHookFunction((void*)&%s, (void*)&%s%s, (void**)&%s%s);\n",
							f.getName(), Function.HOOK_FUNCTION_PREFIX,
							f.getName(), Function.ORIGINAL_PREFIX, f.getName()));
		}

		writer.append("}\n\n");

		return writer.toString();
	}
}

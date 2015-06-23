// Generated from SimpleHeader.g4 by ANTLR 4.5

package dm.generator.antlr;

import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link SimpleHeaderParser}.
 */
public interface SimpleHeaderListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link SimpleHeaderParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterExpression(SimpleHeaderParser.ExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimpleHeaderParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitExpression(SimpleHeaderParser.ExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link SimpleHeaderParser#type}.
	 * @param ctx the parse tree
	 */
	void enterType(SimpleHeaderParser.TypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimpleHeaderParser#type}.
	 * @param ctx the parse tree
	 */
	void exitType(SimpleHeaderParser.TypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link SimpleHeaderParser#enum_specifier}.
	 * @param ctx the parse tree
	 */
	void enterEnum_specifier(SimpleHeaderParser.Enum_specifierContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimpleHeaderParser#enum_specifier}.
	 * @param ctx the parse tree
	 */
	void exitEnum_specifier(SimpleHeaderParser.Enum_specifierContext ctx);
	/**
	 * Enter a parse tree produced by {@link SimpleHeaderParser#enum_entry}.
	 * @param ctx the parse tree
	 */
	void enterEnum_entry(SimpleHeaderParser.Enum_entryContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimpleHeaderParser#enum_entry}.
	 * @param ctx the parse tree
	 */
	void exitEnum_entry(SimpleHeaderParser.Enum_entryContext ctx);
	/**
	 * Enter a parse tree produced by {@link SimpleHeaderParser#enum_value}.
	 * @param ctx the parse tree
	 */
	void enterEnum_value(SimpleHeaderParser.Enum_valueContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimpleHeaderParser#enum_value}.
	 * @param ctx the parse tree
	 */
	void exitEnum_value(SimpleHeaderParser.Enum_valueContext ctx);
	/**
	 * Enter a parse tree produced by {@link SimpleHeaderParser#include}.
	 * @param ctx the parse tree
	 */
	void enterInclude(SimpleHeaderParser.IncludeContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimpleHeaderParser#include}.
	 * @param ctx the parse tree
	 */
	void exitInclude(SimpleHeaderParser.IncludeContext ctx);
	/**
	 * Enter a parse tree produced by {@link SimpleHeaderParser#typedef}.
	 * @param ctx the parse tree
	 */
	void enterTypedef(SimpleHeaderParser.TypedefContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimpleHeaderParser#typedef}.
	 * @param ctx the parse tree
	 */
	void exitTypedef(SimpleHeaderParser.TypedefContext ctx);
	/**
	 * Enter a parse tree produced by {@link SimpleHeaderParser#function_dec}.
	 * @param ctx the parse tree
	 */
	void enterFunction_dec(SimpleHeaderParser.Function_decContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimpleHeaderParser#function_dec}.
	 * @param ctx the parse tree
	 */
	void exitFunction_dec(SimpleHeaderParser.Function_decContext ctx);
	/**
	 * Enter a parse tree produced by {@link SimpleHeaderParser#param_list}.
	 * @param ctx the parse tree
	 */
	void enterParam_list(SimpleHeaderParser.Param_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimpleHeaderParser#param_list}.
	 * @param ctx the parse tree
	 */
	void exitParam_list(SimpleHeaderParser.Param_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link SimpleHeaderParser#param}.
	 * @param ctx the parse tree
	 */
	void enterParam(SimpleHeaderParser.ParamContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimpleHeaderParser#param}.
	 * @param ctx the parse tree
	 */
	void exitParam(SimpleHeaderParser.ParamContext ctx);
}
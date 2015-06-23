// Generated from SimpleHeader.g4 by ANTLR 4.5

package dm.generator.antlr;

import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class SimpleHeaderParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.5", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, LBRACE=9, 
		RBRACE=10, LPAREN=11, RPAREN=12, LBRACKET=13, RBRACKET=14, SEMICOLON=15, 
		COMMA=16, STAR=17, CONST=18, IDENTIFIER=19, NUMBER=20, WS=21;
	public static final int
		RULE_expression = 0, RULE_type = 1, RULE_enum_specifier = 2, RULE_enum_entry = 3, 
		RULE_enum_value = 4, RULE_include = 5, RULE_typedef = 6, RULE_function_dec = 7, 
		RULE_param_list = 8, RULE_param = 9;
	public static final String[] ruleNames = {
		"expression", "type", "enum_specifier", "enum_entry", "enum_value", "include", 
		"typedef", "function_dec", "param_list", "param"
	};

	private static final String[] _LITERAL_NAMES = {
		null, "'enum'", "'='", "'#include'", "'#import'", "'<'", "'\"'", "'>'", 
		"'typedef'", "'{'", "'}'", "'('", "')'", "'['", "']'", "';'", "','", "'*'", 
		"'const'"
	};
	private static final String[] _SYMBOLIC_NAMES = {
		null, null, null, null, null, null, null, null, null, "LBRACE", "RBRACE", 
		"LPAREN", "RPAREN", "LBRACKET", "RBRACKET", "SEMICOLON", "COMMA", "STAR", 
		"CONST", "IDENTIFIER", "NUMBER", "WS"
	};
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "SimpleHeader.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public SimpleHeaderParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}
	public static class ExpressionContext extends ParserRuleContext {
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public IncludeContext include() {
			return getRuleContext(IncludeContext.class,0);
		}
		public Enum_specifierContext enum_specifier() {
			return getRuleContext(Enum_specifierContext.class,0);
		}
		public TypedefContext typedef() {
			return getRuleContext(TypedefContext.class,0);
		}
		public Function_decContext function_dec() {
			return getRuleContext(Function_decContext.class,0);
		}
		public TerminalNode EOF() { return getToken(SimpleHeaderParser.EOF, 0); }
		public ExpressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).enterExpression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).exitExpression(this);
		}
	}

	public final ExpressionContext expression() throws RecognitionException {
		ExpressionContext _localctx = new ExpressionContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_expression);
		try {
			setState(29);
			switch (_input.LA(1)) {
			case T__0:
			case T__2:
			case T__3:
			case T__7:
			case IDENTIFIER:
				enterOuterAlt(_localctx, 1);
				{
				setState(24);
				switch (_input.LA(1)) {
				case T__2:
				case T__3:
					{
					setState(20);
					include();
					}
					break;
				case T__0:
					{
					setState(21);
					enum_specifier();
					}
					break;
				case T__7:
					{
					setState(22);
					typedef();
					}
					break;
				case IDENTIFIER:
					{
					setState(23);
					function_dec();
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				setState(26);
				expression();
				}
				break;
			case EOF:
				enterOuterAlt(_localctx, 2);
				{
				setState(28);
				match(EOF);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TypeContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(SimpleHeaderParser.IDENTIFIER, 0); }
		public TerminalNode STAR() { return getToken(SimpleHeaderParser.STAR, 0); }
		public TerminalNode CONST() { return getToken(SimpleHeaderParser.CONST, 0); }
		public TypeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).enterType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).exitType(this);
		}
	}

	public final TypeContext type() throws RecognitionException {
		TypeContext _localctx = new TypeContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_type);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(39);
			switch ( getInterpreter().adaptivePredict(_input,4,_ctx) ) {
			case 1:
				{
				setState(32);
				_la = _input.LA(1);
				if (_la==CONST) {
					{
					setState(31);
					match(CONST);
					}
				}

				setState(34);
				match(IDENTIFIER);
				}
				break;
			case 2:
				{
				setState(35);
				match(IDENTIFIER);
				setState(37);
				_la = _input.LA(1);
				if (_la==CONST) {
					{
					setState(36);
					match(CONST);
					}
				}

				}
				break;
			}
			setState(42);
			_la = _input.LA(1);
			if (_la==STAR) {
				{
				setState(41);
				match(STAR);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Enum_specifierContext extends ParserRuleContext {
		public TerminalNode LBRACE() { return getToken(SimpleHeaderParser.LBRACE, 0); }
		public TerminalNode RBRACE() { return getToken(SimpleHeaderParser.RBRACE, 0); }
		public TerminalNode SEMICOLON() { return getToken(SimpleHeaderParser.SEMICOLON, 0); }
		public TerminalNode IDENTIFIER() { return getToken(SimpleHeaderParser.IDENTIFIER, 0); }
		public List<Enum_entryContext> enum_entry() {
			return getRuleContexts(Enum_entryContext.class);
		}
		public Enum_entryContext enum_entry(int i) {
			return getRuleContext(Enum_entryContext.class,i);
		}
		public Enum_specifierContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_enum_specifier; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).enterEnum_specifier(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).exitEnum_specifier(this);
		}
	}

	public final Enum_specifierContext enum_specifier() throws RecognitionException {
		Enum_specifierContext _localctx = new Enum_specifierContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_enum_specifier);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(44);
			match(T__0);
			setState(46);
			_la = _input.LA(1);
			if (_la==IDENTIFIER) {
				{
				setState(45);
				match(IDENTIFIER);
				}
			}

			setState(48);
			match(LBRACE);
			setState(50); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(49);
				enum_entry();
				}
				}
				setState(52); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( _la==IDENTIFIER );
			setState(54);
			match(RBRACE);
			setState(55);
			match(SEMICOLON);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Enum_entryContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(SimpleHeaderParser.IDENTIFIER, 0); }
		public Enum_valueContext enum_value() {
			return getRuleContext(Enum_valueContext.class,0);
		}
		public TerminalNode COMMA() { return getToken(SimpleHeaderParser.COMMA, 0); }
		public Enum_entryContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_enum_entry; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).enterEnum_entry(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).exitEnum_entry(this);
		}
	}

	public final Enum_entryContext enum_entry() throws RecognitionException {
		Enum_entryContext _localctx = new Enum_entryContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_enum_entry);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(57);
			match(IDENTIFIER);
			setState(59);
			_la = _input.LA(1);
			if (_la==T__1) {
				{
				setState(58);
				enum_value();
				}
			}

			setState(62);
			_la = _input.LA(1);
			if (_la==COMMA) {
				{
				setState(61);
				match(COMMA);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Enum_valueContext extends ParserRuleContext {
		public TerminalNode NUMBER() { return getToken(SimpleHeaderParser.NUMBER, 0); }
		public Enum_valueContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_enum_value; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).enterEnum_value(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).exitEnum_value(this);
		}
	}

	public final Enum_valueContext enum_value() throws RecognitionException {
		Enum_valueContext _localctx = new Enum_valueContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_enum_value);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(64);
			match(T__1);
			setState(65);
			match(NUMBER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class IncludeContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(SimpleHeaderParser.IDENTIFIER, 0); }
		public IncludeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_include; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).enterInclude(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).exitInclude(this);
		}
	}

	public final IncludeContext include() throws RecognitionException {
		IncludeContext _localctx = new IncludeContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_include);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(67);
			_la = _input.LA(1);
			if ( !(_la==T__2 || _la==T__3) ) {
			_errHandler.recoverInline(this);
			} else {
				consume();
			}
			setState(68);
			_la = _input.LA(1);
			if ( !(_la==T__4 || _la==T__5) ) {
			_errHandler.recoverInline(this);
			} else {
				consume();
			}
			setState(69);
			match(IDENTIFIER);
			setState(70);
			_la = _input.LA(1);
			if ( !(_la==T__5 || _la==T__6) ) {
			_errHandler.recoverInline(this);
			} else {
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TypedefContext extends ParserRuleContext {
		public List<TerminalNode> IDENTIFIER() { return getTokens(SimpleHeaderParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(SimpleHeaderParser.IDENTIFIER, i);
		}
		public TerminalNode SEMICOLON() { return getToken(SimpleHeaderParser.SEMICOLON, 0); }
		public TypedefContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_typedef; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).enterTypedef(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).exitTypedef(this);
		}
	}

	public final TypedefContext typedef() throws RecognitionException {
		TypedefContext _localctx = new TypedefContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_typedef);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(72);
			match(T__7);
			setState(73);
			match(IDENTIFIER);
			setState(74);
			match(IDENTIFIER);
			setState(75);
			match(SEMICOLON);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Function_decContext extends ParserRuleContext {
		public List<TerminalNode> IDENTIFIER() { return getTokens(SimpleHeaderParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(SimpleHeaderParser.IDENTIFIER, i);
		}
		public TerminalNode LPAREN() { return getToken(SimpleHeaderParser.LPAREN, 0); }
		public Param_listContext param_list() {
			return getRuleContext(Param_listContext.class,0);
		}
		public TerminalNode RPAREN() { return getToken(SimpleHeaderParser.RPAREN, 0); }
		public TerminalNode SEMICOLON() { return getToken(SimpleHeaderParser.SEMICOLON, 0); }
		public Function_decContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_function_dec; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).enterFunction_dec(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).exitFunction_dec(this);
		}
	}

	public final Function_decContext function_dec() throws RecognitionException {
		Function_decContext _localctx = new Function_decContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_function_dec);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(77);
			match(IDENTIFIER);
			setState(78);
			match(IDENTIFIER);
			setState(79);
			match(LPAREN);
			setState(80);
			param_list();
			setState(81);
			match(RPAREN);
			setState(82);
			match(SEMICOLON);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Param_listContext extends ParserRuleContext {
		public List<ParamContext> param() {
			return getRuleContexts(ParamContext.class);
		}
		public ParamContext param(int i) {
			return getRuleContext(ParamContext.class,i);
		}
		public List<TerminalNode> COMMA() { return getTokens(SimpleHeaderParser.COMMA); }
		public TerminalNode COMMA(int i) {
			return getToken(SimpleHeaderParser.COMMA, i);
		}
		public Param_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_param_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).enterParam_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).exitParam_list(this);
		}
	}

	public final Param_listContext param_list() throws RecognitionException {
		Param_listContext _localctx = new Param_listContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_param_list);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(92);
			_la = _input.LA(1);
			if (_la==CONST || _la==IDENTIFIER) {
				{
				setState(84);
				param();
				setState(89);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==COMMA) {
					{
					{
					setState(85);
					match(COMMA);
					setState(86);
					param();
					}
					}
					setState(91);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ParamContext extends ParserRuleContext {
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode IDENTIFIER() { return getToken(SimpleHeaderParser.IDENTIFIER, 0); }
		public ParamContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_param; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).enterParam(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleHeaderListener ) ((SimpleHeaderListener)listener).exitParam(this);
		}
	}

	public final ParamContext param() throws RecognitionException {
		ParamContext _localctx = new ParamContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_param);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(94);
			type();
			setState(95);
			match(IDENTIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static final String _serializedATN =
		"\3\u0430\ud6d1\u8206\uad2d\u4417\uaef1\u8d80\uaadd\3\27d\4\2\t\2\4\3\t"+
		"\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\3"+
		"\2\3\2\3\2\3\2\5\2\33\n\2\3\2\3\2\3\2\5\2 \n\2\3\3\5\3#\n\3\3\3\3\3\3"+
		"\3\5\3(\n\3\5\3*\n\3\3\3\5\3-\n\3\3\4\3\4\5\4\61\n\4\3\4\3\4\6\4\65\n"+
		"\4\r\4\16\4\66\3\4\3\4\3\4\3\5\3\5\5\5>\n\5\3\5\5\5A\n\5\3\6\3\6\3\6\3"+
		"\7\3\7\3\7\3\7\3\7\3\b\3\b\3\b\3\b\3\b\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\n"+
		"\3\n\3\n\7\nZ\n\n\f\n\16\n]\13\n\5\n_\n\n\3\13\3\13\3\13\3\13\2\2\f\2"+
		"\4\6\b\n\f\16\20\22\24\2\5\3\2\5\6\3\2\7\b\3\2\b\tg\2\37\3\2\2\2\4)\3"+
		"\2\2\2\6.\3\2\2\2\b;\3\2\2\2\nB\3\2\2\2\fE\3\2\2\2\16J\3\2\2\2\20O\3\2"+
		"\2\2\22^\3\2\2\2\24`\3\2\2\2\26\33\5\f\7\2\27\33\5\6\4\2\30\33\5\16\b"+
		"\2\31\33\5\20\t\2\32\26\3\2\2\2\32\27\3\2\2\2\32\30\3\2\2\2\32\31\3\2"+
		"\2\2\33\34\3\2\2\2\34\35\5\2\2\2\35 \3\2\2\2\36 \7\2\2\3\37\32\3\2\2\2"+
		"\37\36\3\2\2\2 \3\3\2\2\2!#\7\24\2\2\"!\3\2\2\2\"#\3\2\2\2#$\3\2\2\2$"+
		"*\7\25\2\2%\'\7\25\2\2&(\7\24\2\2\'&\3\2\2\2\'(\3\2\2\2(*\3\2\2\2)\"\3"+
		"\2\2\2)%\3\2\2\2*,\3\2\2\2+-\7\23\2\2,+\3\2\2\2,-\3\2\2\2-\5\3\2\2\2."+
		"\60\7\3\2\2/\61\7\25\2\2\60/\3\2\2\2\60\61\3\2\2\2\61\62\3\2\2\2\62\64"+
		"\7\13\2\2\63\65\5\b\5\2\64\63\3\2\2\2\65\66\3\2\2\2\66\64\3\2\2\2\66\67"+
		"\3\2\2\2\678\3\2\2\289\7\f\2\29:\7\21\2\2:\7\3\2\2\2;=\7\25\2\2<>\5\n"+
		"\6\2=<\3\2\2\2=>\3\2\2\2>@\3\2\2\2?A\7\22\2\2@?\3\2\2\2@A\3\2\2\2A\t\3"+
		"\2\2\2BC\7\4\2\2CD\7\26\2\2D\13\3\2\2\2EF\t\2\2\2FG\t\3\2\2GH\7\25\2\2"+
		"HI\t\4\2\2I\r\3\2\2\2JK\7\n\2\2KL\7\25\2\2LM\7\25\2\2MN\7\21\2\2N\17\3"+
		"\2\2\2OP\7\25\2\2PQ\7\25\2\2QR\7\r\2\2RS\5\22\n\2ST\7\16\2\2TU\7\21\2"+
		"\2U\21\3\2\2\2V[\5\24\13\2WX\7\22\2\2XZ\5\24\13\2YW\3\2\2\2Z]\3\2\2\2"+
		"[Y\3\2\2\2[\\\3\2\2\2\\_\3\2\2\2][\3\2\2\2^V\3\2\2\2^_\3\2\2\2_\23\3\2"+
		"\2\2`a\5\4\3\2ab\7\25\2\2b\25\3\2\2\2\16\32\37\"\'),\60\66=@[^";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}
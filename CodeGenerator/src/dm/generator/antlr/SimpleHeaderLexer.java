// Generated from SimpleHeader.g4 by ANTLR 4.5

package dm.generator.antlr;

import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class SimpleHeaderLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.5", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, LBRACE=9, 
		RBRACE=10, LPAREN=11, RPAREN=12, LBRACKET=13, RBRACKET=14, SEMICOLON=15, 
		COMMA=16, STAR=17, CONST=18, IDENTIFIER=19, NUMBER=20, WS=21;
	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	public static final String[] ruleNames = {
		"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "T__6", "T__7", "LBRACE", 
		"RBRACE", "LPAREN", "RPAREN", "LBRACKET", "RBRACKET", "SEMICOLON", "COMMA", 
		"STAR", "CONST", "IDENTIFIER", "NUMBER", "WS"
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


	public SimpleHeaderLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "SimpleHeader.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public String[] getModeNames() { return modeNames; }

	@Override
	public ATN getATN() { return _ATN; }

	public static final String _serializedATN =
		"\3\u0430\ud6d1\u8206\uad2d\u4417\uaef1\u8d80\uaadd\2\27\u008b\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\3\2\3\2\3\2\3\2\3\2\3\3"+
		"\3\3\3\4\3\4\3\4\3\4\3\4\3\4\3\4\3\4\3\4\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3"+
		"\5\3\6\3\6\3\7\3\7\3\b\3\b\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\n\3\n\3\13"+
		"\3\13\3\f\3\f\3\r\3\r\3\16\3\16\3\17\3\17\3\20\3\20\3\21\3\21\3\22\3\22"+
		"\3\23\3\23\3\23\3\23\3\23\3\23\3\24\3\24\7\24n\n\24\f\24\16\24q\13\24"+
		"\3\25\5\25t\n\25\3\25\6\25w\n\25\r\25\16\25x\3\25\3\25\3\25\3\25\6\25"+
		"\177\n\25\r\25\16\25\u0080\5\25\u0083\n\25\3\26\6\26\u0086\n\26\r\26\16"+
		"\26\u0087\3\26\3\26\2\2\27\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25"+
		"\f\27\r\31\16\33\17\35\20\37\21!\22#\23%\24\'\25)\26+\27\3\2\5\4\2C\\"+
		"c|\6\2\60;C\\aac|\5\2\13\f\17\17\"\"\u0090\2\3\3\2\2\2\2\5\3\2\2\2\2\7"+
		"\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2"+
		"\2\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2"+
		"\35\3\2\2\2\2\37\3\2\2\2\2!\3\2\2\2\2#\3\2\2\2\2%\3\2\2\2\2\'\3\2\2\2"+
		"\2)\3\2\2\2\2+\3\2\2\2\3-\3\2\2\2\5\62\3\2\2\2\7\64\3\2\2\2\t=\3\2\2\2"+
		"\13E\3\2\2\2\rG\3\2\2\2\17I\3\2\2\2\21K\3\2\2\2\23S\3\2\2\2\25U\3\2\2"+
		"\2\27W\3\2\2\2\31Y\3\2\2\2\33[\3\2\2\2\35]\3\2\2\2\37_\3\2\2\2!a\3\2\2"+
		"\2#c\3\2\2\2%e\3\2\2\2\'k\3\2\2\2)\u0082\3\2\2\2+\u0085\3\2\2\2-.\7g\2"+
		"\2./\7p\2\2/\60\7w\2\2\60\61\7o\2\2\61\4\3\2\2\2\62\63\7?\2\2\63\6\3\2"+
		"\2\2\64\65\7%\2\2\65\66\7k\2\2\66\67\7p\2\2\678\7e\2\289\7n\2\29:\7w\2"+
		"\2:;\7f\2\2;<\7g\2\2<\b\3\2\2\2=>\7%\2\2>?\7k\2\2?@\7o\2\2@A\7r\2\2AB"+
		"\7q\2\2BC\7t\2\2CD\7v\2\2D\n\3\2\2\2EF\7>\2\2F\f\3\2\2\2GH\7$\2\2H\16"+
		"\3\2\2\2IJ\7@\2\2J\20\3\2\2\2KL\7v\2\2LM\7{\2\2MN\7r\2\2NO\7g\2\2OP\7"+
		"f\2\2PQ\7g\2\2QR\7h\2\2R\22\3\2\2\2ST\7}\2\2T\24\3\2\2\2UV\7\177\2\2V"+
		"\26\3\2\2\2WX\7*\2\2X\30\3\2\2\2YZ\7+\2\2Z\32\3\2\2\2[\\\7]\2\2\\\34\3"+
		"\2\2\2]^\7_\2\2^\36\3\2\2\2_`\7=\2\2` \3\2\2\2ab\7.\2\2b\"\3\2\2\2cd\7"+
		",\2\2d$\3\2\2\2ef\7e\2\2fg\7q\2\2gh\7p\2\2hi\7u\2\2ij\7v\2\2j&\3\2\2\2"+
		"ko\t\2\2\2ln\t\3\2\2ml\3\2\2\2nq\3\2\2\2om\3\2\2\2op\3\2\2\2p(\3\2\2\2"+
		"qo\3\2\2\2rt\7/\2\2sr\3\2\2\2st\3\2\2\2tv\3\2\2\2uw\4\62;\2vu\3\2\2\2"+
		"wx\3\2\2\2xv\3\2\2\2xy\3\2\2\2y\u0083\3\2\2\2z{\7\62\2\2{|\7z\2\2|~\3"+
		"\2\2\2}\177\4\62;\2~}\3\2\2\2\177\u0080\3\2\2\2\u0080~\3\2\2\2\u0080\u0081"+
		"\3\2\2\2\u0081\u0083\3\2\2\2\u0082s\3\2\2\2\u0082z\3\2\2\2\u0083*\3\2"+
		"\2\2\u0084\u0086\t\4\2\2\u0085\u0084\3\2\2\2\u0086\u0087\3\2\2\2\u0087"+
		"\u0085\3\2\2\2\u0087\u0088\3\2\2\2\u0088\u0089\3\2\2\2\u0089\u008a\b\26"+
		"\2\2\u008a,\3\2\2\2\t\2osx\u0080\u0082\u0087\3\b\2\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}
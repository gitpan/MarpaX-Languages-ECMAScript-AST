use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.006001
use Test::Spelling 0.12;
use Pod::Wordlist;


add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( bin lib  ) );
__DATA__
mckeeman
multipass
typedef
enums
grammarName
lexemeCallback
logInfo
earley
bnf
lhs
rhs
recognizer
recognizer's
marpa
marpa's
scanless
lexeme
ast
trigerred
conditionMode
subscriptionMode
callbackArgs
wantedArgs
Jean
Durand
jeandamiendurand
lib
MarpaX
Languages
ECMAScript
AST
Grammar
ECMAScript_262_5
Uri
Lexical
NumericLiteral
Actions
CharacterClasses
Util
Pattern
Program
Impl
Logger
Base
StringLiteral
RegularExpressionLiteral

#!perl
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::Differences;
use Data::Float;

BEGIN {
    use_ok( 'MarpaX::Languages::ECMAScript::AST' ) || print "Bail out!\n";
}

my $ecmaAst = MarpaX::Languages::ECMAScript::AST->new();
my $pattern = $ecmaAst->pattern;

my %DATA = (
    # reg                         str multiline ignoreCase   value
    #                                                        [lastPos, [ @matches ] ]
    'a|ab'                     => [ 'abc',        0,         0,  [ 1, [] ] ],
    '((a)|(ab))((c)|(bc))'     => [ 'abc',        0,         0,  [ 3, ['a','a',undef,'bc',undef,'bc'] ] ],
    'a[a-z]{2,4}'              => [ 'abcdefghi',  0,         0,  [ 5, [] ] ],
    '(a[a-z]{2,4})'            => [ 'abcdefghi',  0,         0,  [ 5, ['abcde'] ] ],
    'a[a-z]{2,4}?'             => [ 'abcdefghi',  0,         0,  [ 3, [] ] ],
    '(a[a-z]{2,4}?)'           => [ 'abcdefghi',  0,         0,  [ 3, ['abc'] ] ],
    '(aa|aabaac|ba|b|c)*'      => [ 'aabaac',     0,         0,  [ 4, ['ba'] ] ],
    '(z)((a+)?(b+)?(c))*'      => [ 'zaacbbbcac', 0,         0,  [10, ['z', 'ac', 'a', undef, 'c'] ] ],
    '(a*)*'                    => [ 'b',          0,         0,  [ 0, [undef] ] ],
    '(a*)b\1+'                 => [ 'baaaac',     0,         0,  [ 1, [''] ] ],
    '(?=(a+))'                 => [ 'baaabac',    0,         0,    0 ],
    '(?=(a+))'                 => [ 'aaabac',     0,         0,  [ 0, ['aaa'] ] ],
    '(?=(a+))a*b\1'            => [ 'abac',       0,         0,  [ 3, ['a'] ] ],
    '(.*?)a(?!(a+)b\2c)\2(.*)' => [ 'baaabaac',   0,         0,  [ 8, ['ba', undef, 'abaac'] ] ],
    );
my $ntest = 0;
foreach (keys %DATA) {
    my $regexp = $_;
    my $parse = $pattern->{grammar}->parse($regexp, $pattern->{impl});
    my ($input, $multiline, $ignoreCase, $result) = @{$DATA{$_}};
    my $code = eval { $pattern->{grammar}->value($pattern->{impl}) };
    if ($@) {
	print STDERR $@;
	$code = sub {undef};
    }
    my $value = &$code($input, 0);
    eq_or_diff($value, $result, "/$regexp/.exec(\"$input\")");
}

done_testing(1 + scalar(keys %DATA));

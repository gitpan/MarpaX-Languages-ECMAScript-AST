use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Program::Actions;

# ABSTRACT: ECMAScript 262, Edition 5, lexical expressions grammar actions

our $VERSION = '0.002'; # TRIAL VERSION

use constant AST => 'MarpaX::Languages::ECMAScript::AST';



sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}


sub DecimalLiteral {
    my $self = shift;
    return bless(shift, AST . '::DecimalLiteral');
}


sub HexIntegerLiteral {
    my $self = shift;
    return bless(shift, AST . '::HexIntegerLiteral');
}


sub OctalIntegerLiteral {
    my $self = shift;
    return bless(shift, AST . '::OctalIntegerLiteral');
}


sub concat {
    my $self = shift;

    return join ('', grep {defined($_)} @_);
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Program::Actions - ECMAScript 262, Edition 5, lexical expressions grammar actions

=head1 VERSION

version 0.002

=head1 DESCRIPTION

This modules give the actions associated to ECMAScript_262_5 lexical expressions grammar.

=head2 new($class)

Instantiate a new object.

=head2 DecimalLiteral($self, $lexeme)

Bless lexeme to a DecimalLiteral.

=head2 HexIntegerLiteral($self, $lexeme)

Bless lexeme to a HexIntegerLiteral.

=head2 OctalIntegerLiteral($self, $lexeme)

Bless lexeme to a OctalIntegerLiteral.

=head2 concat($self)

Concatenate arguments. Use for tests.

=head1 AUTHOR

Jean-Damien Durand <jeandamiendurand@free.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Jean-Damien Durand.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

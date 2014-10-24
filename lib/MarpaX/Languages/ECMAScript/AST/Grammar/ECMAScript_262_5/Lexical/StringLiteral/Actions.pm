use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringLiteral::Actions;

# ABSTRACT: ECMAScript 262, Edition 5, lexical string grammar actions

our $VERSION = '0.001'; # TRIAL VERSION



sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringLiteral::Actions - ECMAScript 262, Edition 5, lexical string grammar actions

=head1 VERSION

version 0.001

=head1 DESCRIPTION

This modules give the actions associated to ECMAScript_262_5 lexical string grammar.

=head2 new($class)

Instantiate a new object.

=head1 AUTHOR

Jean-Damien Durand <jeandamiendurand@free.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Jean-Damien Durand.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

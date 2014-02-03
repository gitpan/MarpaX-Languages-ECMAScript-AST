use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Program::Singleton;
use base 'Class::Singleton';

# ABSTRACT: ECMAScript-262, Edition 5, singleton for lexical program grammar

our $VERSION = '0.006'; # TRIAL VERSION


sub _new_instance {
    my ($class, $G) = @_;
    my $self  = bless {_G => $G }, $class;
    return $self;
}


sub G {
    my ($self) = @_;
    return $self->{_G};
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Program::Singleton - ECMAScript-262, Edition 5, singleton for lexical program grammar

=head1 VERSION

version 0.006

=head1 DESCRIPTION

This modules is a singleton used for caching the compiled Marpa grammar of a Program LHS, as per ECMAScript 262, Edition 5.

=head1 SUBROUTINES/METHODS

=head2 G()

Return cached grammar.

=head1 AUTHOR

Jean-Damien Durand <jeandamiendurand@free.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Jean-Damien Durand.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

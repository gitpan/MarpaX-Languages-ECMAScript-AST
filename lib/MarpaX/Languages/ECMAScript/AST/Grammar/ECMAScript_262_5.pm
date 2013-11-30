use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5;
use MarpaX::Languages::ECMAScript::AST::Impl;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Program;
our $TEMPLATE = eval 'use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Template; 1;' || 0;

# ABSTRACT: ECMAScript-262, Edition 5, grammar

our $VERSION = '0.005'; # VERSION


sub new {
  my ($class, %transpileOptions) = @_;

  my $self  = {};

  bless($self, $class);

  $self->_init(%transpileOptions);

  return $self;
}

sub _init {
    my ($self, %transpileOptions) = @_;

    my $program = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Program->new();
    $self->{_program} = {
	grammar => $program,
	impl => MarpaX::Languages::ECMAScript::AST::Impl->new($program->grammar_option(), $program->recce_option())
    };
    $self->{_template} = $TEMPLATE ? MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Template->new(%transpileOptions) : undef;

}


sub program {
    my ($self) = @_;

    return $self->{_program};
}


sub template {
    my ($self) = @_;

    return $self->{_template};
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5 - ECMAScript-262, Edition 5, grammar

=head1 VERSION

version 0.005

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5;

    my $ecma = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5->new();

    my $program = $ecma->program();

=head1 DESCRIPTION

This modules returns all grammars needed for the ECMAScript 262, Edition 5 grammars written in Marpa BNF, as of L<http://www.ecma-international.org/publications/standards/Ecma-262.htm>.

=head1 SUBROUTINES/METHODS

=head2 new($class, %transpileOptions)

Instance a new object.

=head2 program()

Returns the program grammar as a hash reference that is

=over

=item grammar

A MarpaX::Languages::ECMAScript::AST::Grammar::Base object

=item impl

A MarpaX::Languages::ECMAScript::AST::Impl object

=back

=head2 template()

Returns the template associated to this grammar. This is a MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Template object.

=head1 AUTHOR

Jean-Damien Durand <jeandamiendurand@free.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Jean-Damien Durand.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

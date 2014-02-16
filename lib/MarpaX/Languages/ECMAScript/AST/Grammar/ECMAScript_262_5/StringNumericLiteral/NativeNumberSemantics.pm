use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::NativeNumberSemantics;
use Data::Float qw/have_signed_zero have_infinite have_nan/;
use Math::BigFloat;
use Scalar::Util qw/blessed/;
use Scalar::Util::Numeric qw/isinf isnan/;

our $POS_ZERO = have_signed_zero() ? Data::Float::pos_zero()     : Math::BigFloat->bzero();
our $NEG_ZERO = have_signed_zero() ? Data::Float::neg_zero()     : Math::BigFloat->bzero();   # No -0 with Math::BigFloat.
our $POS_INF  = have_infinite()    ? Data::Float::pos_infinity() : Math::BigFloat->binf();
our $NEG_INF  = have_infinite()    ? Data::Float::neg_infinity() : Math::BigFloat->binf('-');
our $NAN      = have_nan()         ? Data::Float::nan()          : Math::BigFloat->bnan();

# ABSTRACT: ECMAScript 262, Edition 5, lexical string numeric grammar default semantics package, using native perl representations

our $VERSION = '0.013'; # TRIAL VERSION



sub new {
    return bless({_number => 0, length => 0}, $_[0]);
}


sub host_mul {
    $_[0]->{_number} *= $_[1]->{_number};
    return $_[0];
}


sub host_round {
    return $_[0];
}


sub host_pos_zero {
    $_[0]->{_number} = $POS_ZERO;
    return $_[0];
}


sub host_pos_inf {
    $_[0]->{_number} = $POS_INF;
    return $_[0];
}


sub host_pow {
    $_[0]->{_number} = 10 ** $_[1]->{_number};
    return $_[0];
}


sub host_int {
    $_[0]->{_number} = int("$_[1]");
    $_[0]->{_length} = length("$_[1]");
    return $_[0];
}


sub host_hex {
    $_[0]->{_number} = hex("$_[1]");
    return $_[0];
}


sub host_neg {
    $_[0]->{_number} *= -1;
    return $_[0];
}


sub host_add {
    $_[0]->{_number} += $_[1]->{_number};
    return $_[0];
}


sub host_sub {
    $_[0]->{_number} -= $_[1]->{_number};
    return $_[0];
}


sub host_inc_length {
    ++$_[0]->{_length};
    return $_[0];
}


sub host_new_from_length {
    return $_[0]->host_class->new->host_int("$_[0]->{_length}");
}


sub host_class {
  return blessed($_[0]);
}


sub host_value {
  return $_[0]->{_number};
}


sub pos_zero {
    my ($class) = @_;
    return $POS_ZERO;
}


sub neg_zero {
    my ($class) = @_;
    return $NEG_ZERO;
}


sub pos_infinity {
    my ($class) = @_;
    return $POS_INF;
}


sub neg_infinity {
    my ($class) = @_;
    return $NEG_INF;
}


sub nan {
    my ($class) = @_;
    return $NAN;
}


sub is_zero {
    my ($class, $value) = @_;
    my $blessed = blessed($value) || '';
    if (! $blessed) {
	#
	# float_is_zero never fails
	#
	return Data::Float::float_is_zero($value);
    } elsif ($value->can('is_zero')) {
	return $value->is_zero();
    } else {
	return undef;
    }
}


sub is_infinite {
    my ($class, $value) = @_;
    my $blessed = blessed($value) || '';
    if (! $blessed) {
	#
	# isinf() never fails
	#
	return isinf($value);
    } elsif ($value->can('is_inf')) {
	return $value->is_inf();
    } else {
	return undef;
    }
}


sub is_nan {
    my ($class, $value) = @_;
    my $blessed = blessed($value) || '';
    if (! $blessed) {
	#
	# isnan() never fails
	#
	return isnan($value);
    } elsif ($value->can('is_nan')) {
	return $value->is_nan();
    } else {
	return undef;
    }
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::NativeNumberSemantics - ECMAScript 262, Edition 5, lexical string numeric grammar default semantics package, using native perl representations

=head1 VERSION

version 0.013

=head1 DESCRIPTION

This modules provide a default semantics package for the actions associated to ECMAScript_262_5 lexical string numeric grammar, using native number representation, with the possible exceptions of positive zero and positive infinity: If one of them is not available natively, then the Math::BigFloat representation is used.

For this reason, this module exports two class methods to test if a number is zero or not, that use the native library or Math::BigFloat.

For convenience, even if this is not formally in the string numeric grammar, the neg_zero(), neg_infinity(), nan(), is_zero(), is_infinite() and is_nan() methods are also exported.

=head2 new($class)

Instantiate a new object that has two members: number initialized to host's positive zero, and length initalized to host's positive zero.

=head2 host_mul($self, $objmul)

Host implementation of $self multiplied by $objmul. Returns $self.

=head2 host_round($self)

Host implementation of rounded $self. Returns $self.

=head2 host_pos_zero($self)

Host implementation of $self setted to positive zero, defaulting to Data::Float::pos_zero if your host have signed zeroes, 0 otherwise. Returns $self.

=head2 host_pos_inf($self)

Host implementation of $self setted to positive infinity, defaulting to Data::Float::pos_infinity if your host have infinity, otherwise a trial between (~0)**(~0) and {my $n = 2; $n *= $n while $n < $n*$n; $n}. Return $self.

=head2 host_pow($self, $powobj)

Host implementation of $self setted to 10 ** $powobj. Returns $self.

=head2 host_int($self, $string)

Host implementation of $self setted to positive integer represented in $string, length initialized to the number of characters in $string. Returns $self.

=head2 host_hex($self, $string)

Host implementation of $self setted to positive hexadecimal integer represented in $string. Returns $self.

=head2 host_neg($self)

Host implementation of $self sign change. Returns $self.

=head2 host_add($self, $addobj)

Host implementation of $addobj added to $self. Returns $self.

=head2 host_sub($self, $subobj)

Host implementation of $subobj substracted from $self. Returns $self.

=head2 host_inc_length($self)

Increase by one the host representation of the number of characters used to evaluate the host value. Returns $self.

=head2 host_new_from_length($self)

Returns the a new object derived from the number of characters used to evaluate the host value of $self. Returns the new object instance.

=head2 host_class($self)

Returns the host class that, when called as class->new, is creating a new object.

=head2 host_value($self)

Returns the host implementation of value hosted in $self.

=head2 pos_zero($class)

Class method that returns the host implementation of (positive if any) zero, or its Math::BigFloat implementation otherwise.

=head2 neg_zero($class)

Class method that returns the host implementation of (negative if any) zero, or its Math::BigFloat implementation otherwise.

=head2 pos_infinity($class)

Class method that returns the host implementation of (positive if any) infinity, or its Math::BigFloat implementation otherwise.

=head2 neg_infinity($class)

Class method that returns the host implementation of (negative if any) infinity, or its Math::BigFloat implementation otherwise.

=head2 nan($class)

Class method that returns the host implementation of NaN, or its Math::BigFloat implementation otherwise.

=head2 is_zero($class, $value)

Class method that returns true or false if $value is zero. In case $value would be a blessed object, $value->is_zero() is returned if $value can do this method, otherwise undef is returned.

=head2 is_infinite($class, $value)

Class method that returns true or false if $value is infinite. In case $value would be a blessed object, $value->is_inf() is returned if $value can do this method, otherwise undef is returned.

=head2 is_nan($class, $value)

Class method that returns true or false if $value is NaN. In case $value would be a blessed object, $value->is_nan() is returned if $value can do this method, otherwise undef is returned.

=head1 AUTHOR

Jean-Damien Durand <jeandamiendurand@free.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Jean-Damien Durand.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

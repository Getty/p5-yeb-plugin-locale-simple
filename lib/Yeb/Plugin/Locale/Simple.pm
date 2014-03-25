package Yeb::Plugin::Locale::Simple;
# ABSTRACT: Yeb Plugin for Locale::Simple connection

use Moo;
use Locale::Simple;

has app => ( is => 'ro', required => 1 );

has locales => (
	is => 'ro',
	predicate => 1,
);

sub BUILD {
  my ( $self ) = @_;
  for my $func (@Locale::Simple::EXPORT) {
    $self->app->register_function($func,sub { &{\&{$func}}(@_) });
  };
  l_dir($self->locales) if $self->has_locales;
}

1;
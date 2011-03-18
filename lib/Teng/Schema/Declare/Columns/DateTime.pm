package Teng::Schema::Declare::Columns::DateTime;

use strict;
use warnings;
use Carp;

our $VERSION = '0.0.1';

use Teng::Schema::Declare;

use Exporter::Lite;
our @EXPORT = qw(datetime_columns);

sub datetime_columns {
    my (@columns) = @_;

    my $columns_regexp = join('|', @columns);
    my $regexp = qr{^(?:$columns_regexp)$};
    my ($pkg) = caller;
    my $inflate = \&{$pkg . '::inflate'};
    my $deflate = \&{$pkg . '::deflate'};
    $inflate->($regexp => \&inflate_datetime);
    $deflate->($regexp => \&deflate_datetime);
}

sub inflate_datetime {
    my ($col_value) = @_;
    return DateTime::Format::MySQL->parse_datetime($col_value);
}

sub deflate_datetime {
    my ($col_value) = @_;
    return DateTime::Format::MySQL->format_datetime($col_value);
}

1;

__END__

=head1 NAME

Teng::Schema::Declare::Columns::DateTime - [One line description of module's purpose here]


=head1 VERSION

This document describes Teng::Schema::Declare::Columns::DateTime version 0.0.1


=head1 SYNOPSIS

    use Teng::Schema::Declare::Columns::DateTime;

=for author to fill in:
    Brief code example(s) here showing commonest usage(s).
    This section will be as far as many users bother reading
    so make it as educational and exeplary as possible.


=head1 DESCRIPTION

=for author to fill in:
    Write a full description of the module and its features here.
    Use subsections (=head2, =head3) as appropriate.

=head1 REPOSITORY

https://github.com/

=head1 AUTHOR

  C<< <shibayu36 {at} gmail.com> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2011, Yuki Shibazaki C<< <shibayu36 {at} gmail.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

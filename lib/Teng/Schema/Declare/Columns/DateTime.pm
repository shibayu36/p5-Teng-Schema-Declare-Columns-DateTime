package Teng::Schema::Declare::Columns::DateTime;

use strict;
use warnings;
use Carp;

our $VERSION = '0.0.1';

use Teng::Schema::Declare;
use DateTime::Format::MySQL;

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

Teng::Schema::Declare::Columns::DateTime - DSL extention of Teng::Schema::Declare for declaring datetime columns

=head1 SYNOPSIS

    package MyDB::Schema;
    use strict;
    use warnings;
    use Teng::Schema::Declare;
    use Teng::Schema::Declare::Columns::DateTime;

    table {
        name    "sample";
        pk      "id";
        columns qw( name created_at updated_at );
        datetime_columns qw(created_at updated_at);
    };

    1;

=head1 DESCRIPTION

Teng::Schema::Declare::Columns::DateTime provides the method which declare a column used as DateTime object.

If you write below:

    table {
        name "sample";
        columns qw(created_at updated_at);
        datetime_columns qw(created_at updated_at);
    }

this is same as

    table {
        name "sample";
        columns qw(created_at updated_at);
        inflate qr{^(?:created_at|updated_at)$} => sub {
            my ($col_value) = @_;
            return DateTime::Format::MySQL->parse_datetime($col_value);
        }
        deflate qr{^(?:created_at|updated_at)$} => sub {
            my ($col_value) = @_;
            return DateTime::Format::MySQL->format_datetime($col_value);
        }
    }

=head1 REPOSITORY

https://github.com/shiba-yu36/p5-Teng-Schema-Declare-Columns-DateTime

=head1 AUTHOR

  C<< <shibayu36 {at} gmail.com> >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2011, Yuki Shibazaki C<< <shibayu36 {at} gmail.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

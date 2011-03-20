package test::Base;
use strict;
use warnings;

use base qw(Test::Class);

use Teng::Schema::Declare;
use Teng::Schema::Declare::Columns::DateTime;
Teng::Schema::Declare::Columns::DateTime->format_class('DateTime::Format::Atom');

use DateTime;
use DateTime::Format::Atom;

use Test::More;

my $klass = "Teng::TestFor::DeclareCustomDatetimeSchema";
my $schema = schema {
    table {
        name 'foo';
        columns qw(created_at updated_at);
        datetime_columns qw(created_at updated_at);
    };
} $klass;

sub _inflate_datetime : Test(7) {
    ok my $table = $schema->get_table("foo");

    my $datetime     = DateTime->now;
    my $format_atom = DateTime::Format::Atom->format_datetime($datetime);
    my ($inflate, $deflate);

    # created_at
    $deflate  = $table->call_deflate('created_at', $datetime);
    is $deflate, $format_atom;
    $inflate = $table->call_inflate('created_at', $format_atom);
    isa_ok $inflate, 'DateTime';
    is $inflate->epoch, $datetime->epoch;

    # updated_at
    $deflate  = $table->call_deflate('updated_at', $datetime);
    is $deflate, $format_atom;
    $inflate = $table->call_inflate('updated_at', $format_atom);
    isa_ok $inflate, 'DateTime';
    is $inflate->epoch, $datetime->epoch;
}

__PACKAGE__->runtests;

1;

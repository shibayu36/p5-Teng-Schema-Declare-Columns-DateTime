package test::Base;
use strict;
use warnings;

use base qw(Test::Class);

use Teng::Schema::Declare;
use Teng::Schema::Declare::Columns::DateTime;

use DateTime;
use DateTime::Format::MySQL;

use Test::More;

my $klass = "Teng::TestFor::DeclareDatetimeSchema";
my $schema = schema {
    table {
        name 'foo';
        columns qw(name created_at updated_at created);
        datetime_columns qw(created_at updated_at);
    };
} $klass;

sub _inflate_datetime_ok : Test(7) {
    ok my $table = $schema->get_table("foo");

    my $datetime     = DateTime->now;
    my $format_mysql = DateTime::Format::MySQL->format_datetime($datetime);
    my ($inflate, $deflate);

    # created_at
    $deflate  = $table->call_deflate('created_at', $datetime);
    is $deflate, $format_mysql;
    $inflate = $table->call_inflate('created_at', $format_mysql);
    isa_ok $inflate, 'DateTime';
    is $inflate->epoch, $datetime->epoch;

    # updated_at
    $deflate  = $table->call_deflate('updated_at', $datetime);
    is $deflate, $format_mysql;
    $inflate = $table->call_inflate('updated_at', $format_mysql);
    isa_ok $inflate, 'DateTime';
    is $inflate->epoch, $datetime->epoch;
}

sub _inflate_datetime_ng : Test(7) {
    ok my $table = $schema->get_table("foo");

    my $datetime     = DateTime->now;
    my $format_mysql = DateTime::Format::MySQL->format_datetime($datetime);
    my ($inflate, $deflate);

    # name
    $deflate  = $table->call_deflate('name', $datetime);
    isa_ok $deflate, 'DateTime';
    is $deflate->epoch, $datetime->epoch;
    $inflate = $table->call_inflate('name', $format_mysql);
    is $inflate, $format_mysql;

    # created
    $deflate  = $table->call_deflate('created', $datetime);
    isa_ok $deflate, 'DateTime';
    is $deflate->epoch, $datetime->epoch;
    $inflate = $table->call_inflate('created', $format_mysql);
    is $inflate, $format_mysql;
}

__PACKAGE__->runtests;

1;

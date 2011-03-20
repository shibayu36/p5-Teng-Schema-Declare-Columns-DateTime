use strict;
use warnings;
use inc::Module::Install;
use Module::Install::AuthorTests;

name     'Teng-Schema-Declare-Columns-DateTime';
author   'Yuki Shibazaki <shibayu36 {at} gmail.com>';
all_from 'lib/Teng/Schema/Declare/Columns/DateTime.pm';

requires 'Teng::Schema::Declare';
requires 'Exporter::Lite';
requires 'DateTime::Format::MySQL';
requires 'Class::Data::Inheritable';

test_requires 'DateTime';
test_requires 'DateTime::Format::MySQL';
test_requires 'Test::More';
test_requires 'Test::Class';
test_requires 'DateTime::Format::Atom';

recursive_author_tests('xt');

auto_install;
WriteAll;

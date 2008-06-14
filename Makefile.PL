use inc::Module::Install;

all_from 'lib/Class/DBI/Plugin/DigestColumns.pm';

requires 'Test::More'         => 0.32;
requires 'Class::DBI::Plugin' => 0.03;
requires 'Class::DBI'         => '3.0.11';
requires 'Digest::SHA1'       => 2.10;


tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';
test_requires 'Test::More';
author_tests 'xt';
use_test_base;
auto_include;
WriteAll;


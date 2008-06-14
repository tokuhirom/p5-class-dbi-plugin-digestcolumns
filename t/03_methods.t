use strict;
use warnings;
use Test::More;

BEGIN {
    eval "use Class::DBI::Test::SQLite; use DBD::SQLite;";
    plan $@ ? (skip_all => 'needs Class::DBI::Test::SQLite, DBD::SQLite for testing') : (tests => 2);
}

package Mock;
use base qw/Class::DBI::Test::SQLite/;
use Class::DBI::Plugin::DigestColumns;
__PACKAGE__->set_table('test');
__PACKAGE__->columns(All => qw/id name password/);
__PACKAGE__->digest_columns('password');
sub create_sql {
    return q{
        id       INTEGER PRIMARY KEY,
        name     VARCHAR(40),
        password VARCHAR(255)
    }
}

package main;
my $row = Mock->insert({
    id       => 1,
    name     => 'tanaka',
    password => 'Passw0rd',
});
is $row->password, 'ebfc7910077770c8340f63cd2dca2ac1f120444f', 'password digest';

Mock->digest_key('IYAN');
$row->password('Passw0rd');
$row->update;

is $row->password, '2cce1fca2ff63a473c5ba9ce9acabbe75641ff8c', 'password digest with password_key';

package Class::DBI::Plugin::DigestColumns;
use strict;
use warnings;
our $VERSION = '0.04';
use 5.008001;
use base qw/Class::DBI::Plugin/;
use Scalar::Util qw/blessed/;
use Digest::SHA1 ();
use Carp;

sub init {
    my $class = shift;
    $class->mk_classdata('digest_key' => '');
}

sub digest : Plugged {
    my ($class, $key) = @_;
    Digest::SHA1::sha1_hex($key . $class->digest_key)
}

sub digest_columns : Plugged {
    my ($class, $column) = @_;
    croak "digest_columns is class method" if blessed $class;

    $class->add_trigger(
        "before_set_$column" => sub {
            my ($self, $val, $column_values) = @_;

            $column_values->{$column} = $class->digest($val);
        }
    );
}

1;
__END__

=head1 NAME

Class::DBI::Plugin::DigestColumns - easy to digest the digest

=head1 SYNOPSIS

    package Your::Data;
    use base qw(Class::DBI);
    use Class::DBI::Plugin::DigestColumns;
    __PACKAGE__->digest_columns('digest');
    __PACKAGE__->digest_key('IYAN');

=head1 DESCRIPTION

Class::DBI::Plugin::DigestColumn is easy to digest the plugin for CDBI.

=head1 METHODS

=head2 init

Initialization phase. This is private method.

=head2 digest

Get the digest.

=head2 digest_columns

    __PACKAGE__->digest_columns('digest');

This method adds the trigger, the column digest in update and create.

=head2 digest_key

This method is generated by mk_classdata.
If you set the digest_key, digest value is generated by keyword + digest_key.

=head1 AUTHOR

MATSUNO Tokuhiro E<lt>tokuhiro at mobilefactory.jpE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Class::DBI>, L<Class::DBI::Plugin>, L<Digest::SHA1>

=cut

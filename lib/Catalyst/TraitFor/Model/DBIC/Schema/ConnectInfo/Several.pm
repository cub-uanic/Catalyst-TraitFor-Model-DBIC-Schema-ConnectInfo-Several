package Catalyst::TraitFor::Model::DBIC::Schema::ConnectInfo::Several;

use namespace::autoclean;
use Moose::Role;
use Catalyst::Model::DBIC::Schema::Types qw/ ConnectInfo /;
use MooseX::Types -declare => [qw/ SeveralConnectInfo /];
use MooseX::Types::Moose qw/ HashRef /;

our $VERSION = '0.01';

=head1 NAME

Catalyst::TraitFor::Model::DBIC::Schema::ConnectInfo::Several - support
for several C<connect_info> entries.

=head1 SYNOPSIS

    package MyApp::Model::DB;

    use Moose;
    use namespace::autoclean;
    extends 'Catalyst::Model::DBIC::Schema';

    __PACKAGE__->config(
        {
            traits            => ['ConnectInfo::Several'],
            schema_class      => 'MyApp::Schema',
            connect_info      => {
                active_connection => 'mysql_devel',
                mysql_devel       => [ 'dbi:mysql:db_devel', 'user1', 'pass1' ],
                mysql_production  => [ 'dbi:mysql:db_prod',  'user2', 'pass2' ],
            },
        }
    );

    #
    # or in application config
    #
    <Model::DB>
        <connect_info>
            active_connection   mysql_devel
            <mysql_devel>
                dns             dbi:mysql:db_devel
                user            user1
                password        pass1
            </mysql_devel>
            <mysql_prod>
                dns             dbi:mysql:db_prod
                user            user2
                password        pass2
            </mysql_prod>
        </connect_info>
    </Model::DB>

=head1 DESCRIPTION

Enable C<connect_info> to be hash with several named connections defined inside,
and choose active one with C<active_connection>. Also, set C<AutoCommit> option
for you to C<1>, if you don't set it yet.

This extension will do something only if you set C<active_connection>, otherwise
it just do nothing, like it was not used at all.

=cut

subtype SeveralConnectInfo, as ConnectInfo, where { exists $_->{dsn} || exists $_->{dbh_maker} };

coerce SeveralConnectInfo, from HashRef, via {
    my $connect_info = $_;

    if ( exists $_->{active_connection} ) {
        $connect_info = $_->{ $_->{active_connection} };
        $connect_info = {%$connect_info};                  # make copy
        $connect_info->{AutoCommit} = 1 unless exists( $connect_info->{AutoCommit} );
    }

    return $connect_info;
};

has '+connect_info' => ( isa => SeveralConnectInfo, coerce => 1 );

=head1 TODO

Write tests.

=head1 REPOSITORY

Project is hosted at GitHub:

    git://github.com/cub-uanic/c-t-m-dbic-schema-connectinfo-several.git

=head1 SEE ALSO

L<Catalyst::Model::DBIC::Schema>, L<DBIx::Class>, L<Catalyst>

=head1 AUTHOR

Oleg Kostyuk, C<< <cub at cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2009 Oleg Kostyuk.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1;    # End of Catalyst::TraitFor::Model::DBIC::Schema::ConnectInfo::Several


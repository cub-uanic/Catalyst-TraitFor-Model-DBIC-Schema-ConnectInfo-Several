package Catalyst::TraitFor::Model::DBIC::Schema::ConnectInfo::Several;

use namespace::autoclean;
use Moose::Role;

our $VERSION = '0.05';

=head1 NAME

Catalyst::TraitFor::Model::DBIC::Schema::ConnectInfo::Several - support
for several C<connect_info> entries.

=head1 VERSION

    Version is 0.05

=head1 SYNOPSIS

    package MyApp::Model::DB;

    use Moose;
    use namespace::autoclean;
    extends 'Catalyst::Model::DBIC::Schema';

    __PACKAGE__->config(
        {
            traits            => ['ConnectInfo::Several'],
            schema_class      => 'MyApp::Schema',
            active_connection => 'mysql_devel',
            connections       => {
                mysql_devel       => [ 'dbi:mysql:db_devel', 'user1', 'pass1' ],
                mysql_production  => [ 'dbi:mysql:db_prod',  'user2', 'pass2' ],
            },
        }
    );

    #
    # or in application config
    #
    <Model::DB>
        traits                  ConnectInfo::Several
        active_connection       mysql_devel
        <connections>
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
        </connections>
    </Model::DB>

=head1 DESCRIPTION

You can define several connections in C<connections> hash, and select
which one should be used currently via C<active_connection>. You shouldn't
define C<connect_info> - it will be set for you, depending on what you set
in C<active_connection> and C<connections>.

This trait will do something only if you set C<active_connection>, otherwise
it just do nothing, like it was not used at all.

=cut

around 'BUILDARGS' => sub {
    my $orig  = shift;
    my $class = shift;

    my $new = $class->$orig(@_);

    if ( exists( $new->{active_connection} ) && exists( $new->{connections}->{ $new->{active_connection} } ) ) {
        $new->{connect_info} = $new->{connections}->{ $new->{active_connection} };
        delete $new->{active_connection};
        delete $new->{connections};
    }

    return $new;
};

=head1 TODO

Write tests.

=head1 SEE ALSO

L<Catalyst::Model::DBIC::Schema>, L<DBIx::Class>, L<Catalyst>

=head1 SUPPORT

=over 4

=item * Report bugs or feature requests

L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Catalyst-TraitFor-Model-DBIC-Schema-ConnectInfo-Several>

L<http://www.assembla.com/spaces/Catalyst-TraitFor-Model-DBIC-Schema-ConnectInfo-Several/tickets>

=item * Git repository

git clone git://git.assembla.com/Catalyst-TraitFor-Model-DBIC-Schema-ConnectInfo-Several.git

=back

=head1 AUTHOR

Oleg Kostyuk, C<< <cub#cpan.org> >>

=head1 ACKNOWLEDGEMENTS

Matt S. Trout C<< <mst#shadowcatsystems.co.uk> >>

=head1 COPYRIGHT & LICENSE

Copyright 2009 Oleg Kostyuk.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1;    # End of Catalyst::TraitFor::Model::DBIC::Schema::ConnectInfo::Several


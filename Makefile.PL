use strict;
use warnings;
use inc::Module::Install;
use Module::Install::AuthorTests;
use Module::Install::AuthorRequires;

license 'perl';

name 'Catalyst-TraitFor-Model-DBIC-Schema-ConnectInfo-Several';
all_from 'lib/Catalyst/TraitFor/Model/DBIC/Schema/ConnectInfo/Several.pm';
author q{Oleg Kostyuk <cub@cpan.org>};

requires 'Catalyst' => '5.80';
requires 'Catalyst::Model::DBIC::Schema' => '0.31';
requires 'Moose';
requires 'MooseX::Types';
requires 'MooseX::Types::Moose';
requires 'namespace::autoclean';

test_requires 'Test::More';

author_requires 'Test::EOL' => '0.3';
author_requires 'Test::NoTabs';
author_requires 'Test::Pod' => '1.14';
author_requires 'Test::Pod::Coverage' => '1.08';

resources repository => 'http://github.com/cub-uanic/c-t-m-dbic-schema-connectinfo-several/';

tests 't/*.t';
author_tests 't/author';

if ($Module::Install::AUTHOR) {
    system("pod2text lib/Catalyst/TraitFor/Model/DBIC/Schema/ConnectInfo/Several.pm > README") and die $!;
}

WriteAll;


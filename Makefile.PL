use inc::Module::Install;

name     'Catalyst-TraitFor-Model-DBIC-Schema-ConnectInfo-Several';
all_from 'lib/Catalyst/TraitFor/Model/DBIC/Schema/ConnectInfo/Several.pm';
author   q{Oleg Kostyuk <cub@cpan.org>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;


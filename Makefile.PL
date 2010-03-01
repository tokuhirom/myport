use inc::Module::Install;
name 'App-MyPort';
all_from 'lib/App/MyPort.pm';

requires 'App::Cmd';
requires 'IO::Prompt';
requires 'File::HomeDir';
requires 'LWP::UserAgent';
requires 'Path::Class';
requires 'Archive::Extract';
requires 'autodie';
requires 'parent';

tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';
test_requires 'Test::More';
test_requires 'YAML';
author_tests 'xt';
use_test_base;
auto_include;
WriteAll;

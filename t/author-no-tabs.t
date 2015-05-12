
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.09

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/DBIx/Class/InflateColumn/TimeMoment.pm',
    't/00-compile.t',
    't/000-report-versions.t',
    't/10-basic.t',
    't/lib/Test/Schema.pm',
    't/lib/Test/Schema/Result/Example.pm'
);

notabs_ok($_) foreach @files;
done_testing;

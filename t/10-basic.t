use strict;
use warnings;
use lib 't/lib';
use Test::More;
use Test::Schema;
use Time::Moment;

my $schema = Test::Schema->connect( 'dbi:SQLite:dbname=:memory:', '', '' );
$schema->deploy;
my $rs = $schema->resultset('Example');

{
    my $result = $rs->create(
        {   id => 1,
            dt => Time::Moment->new(
                year   => '2014',
                month  => '12',
                day    => '19',
                hour   => '10',
                minute => 0,
                second => 0,
                offset => 120,
            )
        }
    );

    isa_ok $result, 'Test::Schema::Result::Example';
    isa_ok $result->dt, 'Time::Moment';
    is $result->dt->to_string, '2014-12-19T10:00:00+02:00', '... correct date';
    is $result->dt->at_utc->to_string, '2014-12-19T08:00:00Z', '... correct date UTC';
    undef $result;

    my $retrieved = $rs->find(1);
    isa_ok $retrieved, 'Test::Schema::Result::Example';
    isa_ok $retrieved->dt, 'Time::Moment';
    is $retrieved->dt->to_string, '2014-12-19T10:00:00+02:00', '... correct date';
    is $retrieved->dt->at_utc->to_string, '2014-12-19T08:00:00Z', '... correct date UTC';
}

{
    my $result = $rs->create(
        {   id => 2,
            dt => Time::Moment->new(
                year   => '2014',
                month  => '12',
                day    => '20',
                hour   => '15',
                minute => 0,
                second => 0,
                offset => 120,
            )
        }
    );

    isa_ok $result, 'Test::Schema::Result::Example';
    isa_ok $result->dt, 'Time::Moment';
    undef $result;

    my $retrieved = $rs->find(2);
    isa_ok $retrieved, 'Test::Schema::Result::Example';
    isa_ok $retrieved->dt, 'Time::Moment';
    is $retrieved->dt->to_string, '2014-12-20T15:00:00+02:00', '... correct date';
}

done_testing;

[![Build Status](https://travis-ci.org/nigelm/dbix-class-inflatecolumn-timemoment.svg?branch=master)](https://travis-ci.org/nigelm/dbix-class-inflatecolumn-timemoment)
[![Kwalitee status](http://cpants.cpanauthors.org/dist/DBIx-Class-InflateColumn-TimeMoment.png)](http://cpants.charsbar.org/dist/overview/DBIx-Class-InflateColumn-TimeMoment)
[![GitHub issues](https://img.shields.io/github/issues/nigelm/dbix-class-inflatecolumn-timemoment.svg)](https://github.com/nigelm/dbix-class-inflatecolumn-timemoment/issues)
[![GitHub tag](https://img.shields.io/github/tag/nigelm/dbix-class-inflatecolumn-timemoment.svg)]()
[![Cpan license](https://img.shields.io/cpan/l/DBIx-Class-InflateColumn-TimeMoment.svg)](https://metacpan.org/release/DBIx-Class-InflateColumn-TimeMoment)
[![Cpan version](https://img.shields.io/cpan/v/DBIx-Class-InflateColumn-TimeMoment.svg)](https://metacpan.org/release/DBIx-Class-InflateColumn-TimeMoment)

# NAME

DBIx::Class::InflateColumn::TimeMoment - Auto-create TimeMoment objects from date and datetime columns.

# VERSION

version 0.001

# SYNOPSIS

Load this component and then declare one or more columns to be of the datetime,
timestamp or date datatype.

    package Event;
    use base 'DBIx::Class::Core';

    __PACKAGE__->load_components(qw/InflateColumn::TimeMoment/);
    __PACKAGE__->add_columns(
      starts_when => { data_type => 'datetime' }
      create_date => { data_type => 'date' }
    );

Then you can treat the specified column as a [TimeMoment](https://metacpan.org/pod/TimeMoment) object.

If you want to inflate no matter what data\_type your column is, use
inflate\_datetime or inflate\_date:

    __PACKAGE__->add_columns(
      starts_when => { data_type => 'varchar', inflate_datetime => 1 }
    );

    __PACKAGE__->add_columns(
      starts_when => { data_type => 'varchar', inflate_date => 1 }
    );

It's also possible to explicitly skip inflation:

    __PACKAGE__->add_columns(
      starts_when => { data_type => 'datetime', inflate_datetime => 0 }
    );

# DESCRIPTION

This module works with Time::Moment IS8601 date formats to inflate/deflate.  A
later version may handle databases in a more forgiving way, but really why not
make them do something sensible.

For more help with using components, see
["USING" in DBIx::Class::Manual::Component](https://metacpan.org/pod/DBIx::Class::Manual::Component#USING).

## register\_column

Chains with the ["register\_column" in DBIx::Class::Row](https://metacpan.org/pod/DBIx::Class::Row#register_column) method, and sets up
datetime columns appropriately.  This would not normally be directly called by
end users.

In the case of an invalid date, [Time::Moment](https://metacpan.org/pod/Time::Moment) will throw an exception.  To
bypass these exceptions and just have the inflation return undef, use the
`datetime_undef_if_invalid` option in the column info:

    "broken_date",
    {
        data_type => "datetime",
        default_value => '0000-00-00',
        is_nullable => 1,
        datetime_undef_if_invalid => 1
    }

NOTE: Don't rely on `InflateColumn::TimeMoment` to parse date strings for you.
The column is set directly for any non-references and
`InflateColumn::TimeMoment` is completely bypassed.  Instead, use an input
parser to create a TimeMoment object.

# HISTORY

As is obvious from a quick inspection of the code, this module is very heavily
based on and draws code from [DBIx::Class::InflateColumn::DateTime](https://metacpan.org/pod/DBIx::Class::InflateColumn::DateTime), however
it is significantly simplified due to the less well developed timezone handling
and formatter ecosystem.

# SEE ALSO

- More information about the add\_columns method, and column metadata,
      can be found in the documentation for [DBIx::Class::ResultSource](https://metacpan.org/pod/DBIx::Class::ResultSource).

# FURTHER QUESTIONS?

Check the list of [additional DBIC resources](https://metacpan.org/pod/DBIx::Class#GETTING-HELP-SUPPORT).

# AUTHOR

Nigel Metheringham <nigelm@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015-2017 by Nigel Metheringham.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

#
# This file is part of Dist-Zilla-PluginBundle-Author-Celogeek
#
# This software is copyright (c) 2011 by celogeek <me@celogeek.com>.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
package Dist::Zilla::PluginBundle::Author::Celogeek;

# ABSTRACT: Dist::Zilla like Celogeek

use strict;
use warnings;
use Carp;
use Data::Dumper;

our $VERSION = '0.1'; # VERSION

use Moose;
use Class::MOP;
with 'Dist::Zilla::Role::PluginBundle::Easy', 'Dist::Zilla::Role::PluginBundle::PluginRemover';

sub configure {
    my $self = shift;

    $self->add_bundle('Filter', {bundle => '@Basic', remove => ['MakeMaker']});
    $self->add_bundle('Git');
    $self->add_plugins(
        'ModuleBuild',
        'ReportVersions',
        'OurPkgVersion',
        'NextRelease',
        [ 'Prepender' => { copyright => 1 } ],
        'AutoPrereqs',
        'Prereqs',
        'MinimumPerl',
        'Test::Compile',
        'CheckChangeLog',
        'Test::UnusedVars',
        'PruneFiles',
        'ReadmeMarkdownFromPod',
        [ 'MetaResourcesFromGit' => { 'bugtracker.web' => 'https://github.com/%a/%r/issues'} ],
        'MetaConfig',
        ['PodWeaver' => { 'config_plugin' => '@Celogeek' } ],
    );

}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::PluginBundle::Author::Celogeek - Dist::Zilla like Celogeek

=head1 VERSION

version 0.1

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/celogeek/dist-zilla-pluginbundle-author-celogeek/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

celogeek <me@celogeek.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by celogeek <me@celogeek.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


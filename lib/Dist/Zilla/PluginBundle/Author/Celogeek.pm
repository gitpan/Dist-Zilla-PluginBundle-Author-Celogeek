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

our $VERSION = '0.3'; # VERSION

use Moose;
use Class::MOP;
with 'Dist::Zilla::Role::PluginBundle::Easy', 'Dist::Zilla::Role::PluginBundle::PluginRemover';

sub configure {
    my $self = shift;

    $self->add_plugins(['Git::NextVersion' => { first_version => '0.01' }]);
    $self->add_plugins('NextRelease');
    $self->add_bundle('Git' => {'allow_dirty' => [qw/Changes dist.ini README.mkdn/], 'add_files_in' => [qw/Changes dist.ini README.mkdn/]});
    $self->add_bundle('Filter', {bundle => '@Basic', remove => ['MakeMaker']});
    $self->add_plugins(
        'ModuleBuild',
        'ReportVersions',
        'OurPkgVersion',
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
        ['Run::BeforeRelease' => { run => 'cp %d%pREADME.mkdn .'}]
    );

}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::PluginBundle::Author::Celogeek - Dist::Zilla like Celogeek

=head1 VERSION

version 0.3

=head1 OVERVIEW

This is the bundle of Celogeek, and is equivalent to create this dist.ini :

  [Git::NextVersion]
  first_version = 0.01
  [NextRelease]
  [@Git]
  allow_dirty = Changes
  allow_dirty = dist.ini
  allow_dirty = README.mkdn
  add_files_in = Changes
  add_files_in = dist.ini
  add_files_in = README.mkdn
  [@Filter]
  -bundle = @Basic
  -remove = MakeMaker
  [ModuleBuild]
  [ReportVersions]
  [OurPkgVersion]
  [Prepender]
  copyright = 1
  [AutoPrereqs]
  [Prereqs]
  [MinimumPerl]
  [Test::Compile]
  [CheckChangeLog]
  [Test::UnusedVars]
  [PruneFiles]
  [ReadmeMarkdownFromPod]
  [MetaResourcesFromGit]
  bugtracker.web = https://github.com/%a/%r/issues
  [MetaConfig]
  [PodWeaver]
  config_plugin = @Celogeek
  [Run::BeforeRelease]
  run = cp %d%pREADME.mkdn .

Here a simple dist.ini :

  name = MyTest
  license = Perl_5
  copyright_holder = celogeek <me@celogeek.com>
  copyright_year = 2011
  
  [@Author::Celogeek]

And it support remove, so you can use it for your apps deploy :

  name = MyTest
  license = Perl_5
  copyright_holder = celogeek <me@celogeek.com>
  copyright_year = 2011
  
  [@Author::Celogeek]
  -remove = UploadToCPAN
  [Run::Release]
  run = scripts/deploy.sh %s

Here my Changes file :

  {{$NEXT}}
    My changes log

When you will release, by invoking 'dzil release', it will automatically:

=over 2

=item * increment the version number (you dont add it in your program)

=item * collect change found in your Changes after the NEXT

=item * collect the markdown for github

=item * commit Changes, dist.ini and README.mkdn with a simple message (version and changes)

=item * add a tag

=item * push origin

=back

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


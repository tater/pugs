package PugsConfig;
use strict;
use warnings;
use Config();
use File::Spec;
our %Config = %Config::Config;

sub get_config {
    my $config = {
        perl_revision   => '6',
        perl_version    => '0',
        perl_subversion => '0',

        osname    => $Config{osname},
        pager     => $Config{pager},
        prefix    => $Config{prefix},
        archname  => $Config{archname},
        exe_ext   => $Config{exe_ext},
        path_sep  => $Config{path_sep},

        scriptdir => $Config{scriptdir},
        bin       => $Config{bin},
        sitebin   => $Config{sitebin},

        installscript  => $Config{installscript},
        installbin     => $Config{installbin},
        installsitebin => $Config{installsitebin},
    };

    add_path(archlib         => $config); 
    add_path(privlib         => $config); 
    add_path(sitearch        => $config); 
    add_path(sitelib         => $config); 

    add_path(installarchlib  => $config); 
    add_path(installprivlib  => $config); 
    add_path(installsitearch => $config); 
    add_path(installsitelib  => $config); 

    $config->{pugspath} =
      File::Spec->catfile($config->{bin}, "pugs$config->{exe_ext}");

    ($config->{file_sep}) =
      ($Config{sitelib} =~ /([\/\\])/)
        or die "Can't determine file_sep";

    return $config;
}

sub add_path {
    my ($name, $config) = @_;
    my $path = $Config{$name} || '';
    $path =~ s/([\/\\])[^\/\\]*(perl)[^\/\\]*([\/\\]?)/$1${2}6$3/i
      or $path =~ s/([\/\\])(lib)(?=[\/\\]|$)/$1$2${1}perl6/i
      or die <<".";
Can't generate the correct Perl6 equivalent for:

    $path

field name: $name
osname: $config->{osname}

Please notify the maintainer of this code. (Brian Ingerson for now)
.
# XXX Not sure about the above heuristic. So die if incorrect.
    $path =~ s/\/\d+\.\d+\.\d+//g;
    $config->{$name} = $path;
}

sub write_config_module {
    my $config = get_config();
    my $template = do { local $/; <DATA> };

    my $all_fields = join ",\n    ", map {
        "config_$_";
    } sort keys %$config;
    $template =~ s/#all_fields#/$all_fields/;

    my $all_definitions = join ",\n\t", map {
        my $name = $_;
        my $value = $config->{$name};
        $value =~ s{\\}{\\\\}g;
        qq{("$name", "$value")};
    } sort keys %$config;
    $template =~ s/#all_definitions#/$all_definitions/;

    print $template;
}

sub __test__ {
    $Config{privlib} = 'C:\usr\lib';
    $Config{archlib} = 'C:\usr\lib';
    $Config{sitearch} = 'C:\usr\site\lib';
    $Config{sitelib} = 'C:\usr\site\lib';
    require Data::Dumper;
    print Data::Dumper::Dumper(get_config());
}
#__test__;

1;

__DATA__
{-# OPTIONS -fglasgow-exts #-}

{-
    Pugs System Configuration.

    Alive without breath;
    as cold as death;
    never thirsting, ever drinking;
    clad in mail, never clinking.
-}

{-
    *** NOTE ***
    DO NOT EDIT THIS FILE.
    This module is generated by util/generate_config.
-}


module Config (
    config,
    getConfig
) where

import Internals.Map

config = listToFM
	[#all_definitions#
	]

getConfig :: String -> String
getConfig = lookupWithDefaultFM config ""
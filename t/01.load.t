use 5.006;
use strict;
use warnings;
use Test::More;
use File::Spec;
use IPC::Open3;
use IO::Handle;

my @module_files = ('Alien/Edlib.pm');

# no fake home requesteda
my $inc_switch = -d 'blib' ? '-Mblib' : '-Ilib';

open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";

my @warnings;
for my $lib (@module_files)
{
    # see L<perlfaq8/How can I capture STDERR from an external command?>
    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, $inc_switch, '-e', "require q[$lib]");
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($?, 0, "$lib loaded ok");

    if (@_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}

is(scalar(@warnings), 0, 'no warnings found') if $ENV{AUTHOR_TESTING};

done_testing;

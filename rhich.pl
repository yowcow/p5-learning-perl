#
# Challenging "rhich"
# http://www.learning-perl.com/2012/02/learning-perl-challenge-rhich/
#
use strict;
use warnings;
use feature 'say';

use Config;
use File::Spec;

die "Usage: $0 [-a] <PCRE EXPR>"
    if @ARGV == 0
    or @ARGV > 2
    or (@ARGV == 2 and $ARGV[0] ne '-a');

my $find_all  = @ARGV == 2 ? do { shift @ARGV eq '-a' ? 1 : 0 } : 0;
my $separator = $Config{path_sep};
my $regex     = shift @ARGV;

for my $path (split $separator, $ENV{PATH}) {
    opendir(my $dh, $path);

    map {
        say File::Spec->catdir($path, $_);
        exit 0 if not $find_all;
    } grep { m|$regex| } readdir $dh;

    closedir $dh;
}

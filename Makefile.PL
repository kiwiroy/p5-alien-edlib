use strict;
use warnings;
use ExtUtils::MakeMaker;
use Alien::Build::MM;
use Alien::Base::Wrapper;
use Config;

my $abmm = Alien::Build::MM->new;

WriteMakefile($abmm->mm_args(
  ABSTRACT_FROM => 'lib/Alien/Edlib.pm',
  DISTNAME      => 'Alien-Edlib',
  NAME          => 'Alien::Edlib',
  VERSION_FROM  => 'lib/Alien/Edlib.pm',
  MIN_PERL_VERSION => '5.008009',
  META_MERGE => {
    resources => {
      bugtracker => 'https://github.com/kiwiroy/p5-alien-edlib/issues',
      homepage   => 'https://github.com/kiwiroy/p5-alien-edlib',
      repository => 'https://github.com/kiwiroy/p5-alien-edlib.git',
    },
  },
  CONFIGURE_REQUIRES => {
    'Alien::Build'      => '1.41',
    'Alien::cmake3'     => '0.04',
    'HTTP::Tiny'        => '0.044',
  },
  TEST_REQUIRES => {
    'Test::Alien::CPP' => '0',
    'ExtUtils::CppGuess' => '0.19',
  },
  Alien::Base::Wrapper->mm_args,
));

sub MY::postamble {
  $abmm->mm_postamble;
}

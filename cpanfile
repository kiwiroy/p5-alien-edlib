# -*- mode: perl; -*-
requires 'Alien::Build';
requires 'Alien::cmake3';
requires 'HTTP::Tiny' => '0.044';

test_requires 'Test::Alien::CPP';
test_requires 'ExtUtils::CppGuess' => '0.19';

on develop => sub {
  requires 'App::af';
};

requires 'Alien::Build';
requires 'Alien::cmake3';

test_requires 'Test::Alien::CPP';

on develop => sub {
  requires 'App::af';
};

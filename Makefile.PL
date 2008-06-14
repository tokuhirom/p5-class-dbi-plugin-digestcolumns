use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'         => 'Class::DBI::Plugin::DigestColumns',
    'VERSION_FROM' => 'lib/Class/DBI/Plugin/DigestColumns.pm', # finds $VERSION
    'PREREQ_PM'    => {
        Test::More         => 0.32,
        Class::DBI::Plugin => 0.03,
        Class::DBI         => '3.0.11',
        Digest::SHA1       => 2.10,
    },
);

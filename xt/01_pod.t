use strict;
use warnings;
use Test::More;

eval "use Test::Pod 1.18";
plan skip_all => 'Test::Pod 1.18 required' if $@;

all_pod_files_ok();

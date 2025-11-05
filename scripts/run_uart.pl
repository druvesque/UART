#!/usr/bin/perl

use strict;
use warnings;
use File::Find;

my $base_dir = "/c/Users/dhruv/druvesque/git_src/uart/src";

my @directories = (
    "$base_dir"
);

my @verilog_files;


foreach my $dir (@directories) {
    print "\n Scanning directory: $dir\n";

    find(
        sub {
            if (/\.v$/ && -f $_) {
                push @verilog_files, $File::Find::name;
            }
        },
        $dir
    );
}

print "\n Starting compilation sequence...\n";

foreach my $file (@verilog_files) {
    print "  -> Compiling: $file\n";
    my $status = system("vlog \"$file\"");
    if ($status != 0) {
        die "Compilation failed for: $file\n";
    }
}

print "Compilation completed successfully for all Verilog files!\n";

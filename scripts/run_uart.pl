#TODO: 1. CLEANER SCRIPT 
#      2. ALL MODULES COMPILED AT ONCE AND IT SHOWS WHAT THE TOP LEVEL
#      MODULE IS 
#      3. COMPILATION IN ORDER WITH RESPECT TO THE FILE DEPENDENCIES
#      4. FIGURE OUT A SHORTER WAY TO DO IT
#      5. COMPILES THE ENTIRE TESTSUITE WITH A TEST VARIABLE TAKEN ON COMMAND LINE TO RUN A PARTICULAR TEST ON IT 
#
#      EXPECTED END PRODUCT: 1 run_uart.pl SCRIPT THAT COMPILES EVERYTHING AND RUNS THE CODE TO
#
#      BASICALLY, 1 SCRIPT TO RUN THE ENTIRE PROJECT (AND THE REST NITTY-GRITTIES HANDLED THROUGH THE RUN COMMAND ITSELF)
#
#      1 PROJECT --> 1 COMMAND 


#!/usr/bin/perl

use strict;
use warnings;
use File::Find;

my $base_dir = "/c/Users/dhruv/druvesque/git_src/uart/";

my @directories = (
    "$base_dir/src/uart_transmitter/"
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

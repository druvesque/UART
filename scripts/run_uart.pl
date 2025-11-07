#!/usr/bin/env perl
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

use strict;
use warnings;
use File::Find;

my $test = "basic_tx_test";
my $gui_mode = 0;
my @vsim_flags;

my $base_dir = "/c/Users/dhruv/druvesque/git_src/uart/";
my $test_dir = "/c/Users/dhruv/druvesque/git_src/uart/testsuite";

my $vlog_cmd = "vlog $base_dir/src/*.v $test_dir/verilog_tests/*.v";

foreach my $arg (@ARGV) {

    if ($arg =~ /^\+V_TEST=(.+)$/) {
        $test = $1;
    }

    elsif ($arg eq '-gui') {
        $gui_mode = 1;
    }

    elsif ($arg =~ /^-/) {
        push @vsim_flags, $arg;
    }

    else {
        warn "Warning: unknown argument '$arg' ignored\n";
    }

}

if (!$gui_mode) {
    push @vsim_flags, '-c';
}

else {
    @vsim_flags = grep { $_ ne '-c' } @vsim_flags;
}

my $vsim_cmd = "vsim work.$test " . join(' ', @vsim_flags) . qq( -do "run -all"); 

print "\nCompiling\n";
system($vlog_cmd);

print "\nRunning\n";
system($vsim_cmd);

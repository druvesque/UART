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
my $test_dir = "/c/Users/dhruv/druvesque/git_src/uart/testsuite";

system("vlog $base_dir/src/*.v $test_dir/verilog_tests/*.v");





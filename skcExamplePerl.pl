#!/usr/bin/perl


=head1 NAME

skcExamplePerl.pl


=head1 DESCRIPTION

*****************************************************************************
see inculded README file
*****************************************************************************
2013-09-24  13-07-41
@author: stephen.k.conklin@gmail.com

=cut back to perl
#====================================================

use strict;

use PkgMgr;

my $pkgmg = PkgMgr->new();

#read the commands
while (1) {

  print 'pkgMgr > ';

  my $line = <>;		#read stdin for a command

  if ($line eq "\n") {		#verify a command was entered
    print "enter a command or END to exit \n";
    next;
  }


  print $line;
  chop $line;

  my @cmd_line = split(/ /, $line);

  my $cmd = $cmd_line[0];

  if ($cmd eq 'DEPEND' ) {
    shift(@cmd_line);
    my $depends = $cmd_line[1];
    $pkgmg->dependHandler(@cmd_line);
  } elsif ($cmd eq 'INSTALL') {
    $pkgmg->installHandler($cmd_line[1]);
  } elsif ($cmd eq 'REMOVE') {
    $pkgmg->removeHandler($cmd_line[1]);
  } elsif ($cmd eq 'LIST') {
    $pkgmg->listHandler($cmd_line[1]);
  } elsif ($cmd eq 'END') {
    last;
  }

}


exit 0;

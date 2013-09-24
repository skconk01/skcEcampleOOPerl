=head1 NAME

PkgMgr.pm


=head1 DESCRIPTION

*****************************************************************************

this class will keep track of the the installed packes and the implemet the
required commands


*****************************************************************************

=head1 CVS Information

-----------------------------------------------------------------
$Author: sconklin $
$Date: 2005/11/15 18:07:40 $
$Id: get_koch_index.pm,v 1.1.1.1 2005/11/15 18:07:40 sconklin Exp $
$Revision: 1.1.1.1 $
-----------------------------------------------------------------

=head1 Public Class Methods

=cut back to perl

#*****************************************************************************
#*****************************************************************************

use strict;

use Package;


package PkgMgr;



#_____________________________________________________________________________

=head2 new

  declartion:   new
       input:
      return:   a blessed reference to this object
    function:   constructor for this class.

=cut back to perl

#_____________________________________________________________________________
sub new {
  #
  # create a perl object allow inheritance
  #
  my $proto = shift;
  my $class = ref($proto) || $proto;
  my $this = {};
  bless ($this, $class);

  return $this;
}

#_____________________________________________________________________________

=head2 DESTROY

  declartion:   DESTROY
       input:   none
      return:   none
    function:   destructor for this class

=cut back to perl

#_____________________________________________________________________________

sub DESTROY {
  my $this = shift;

  return;
}


=head2 get_koch_pointer

  declartion:  dependHandler
       input:  $line  line contanins comand and action
      return:  
    function:  

=cut back to perl

#_____________________________________________________________________________

sub dependHandler{
  my $this = shift;
  my $line = shift;

  return ;
}#end dependHandler



1;    # end of PkgMgr.pm

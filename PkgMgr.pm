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


  $this->{pkgList} = ();  #hash to contain the packages.

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


=head2 dependHandlere

  declartion:  dependHandler
       input:  $pkg_data  line containing the package and the dependences
      return:  
    function:  if the package is not in the list create a package object
               and add it to the list, then add any dependencies. if the
               package is in the list add the dependences.

$this->{pkgList} = ();  #hash to contain the packages.

=cut back to perl

#_____________________________________________________________________________

sub dependHandler{
    my $this = shift;
    my @pkg_data = @_;

    my $pakcage_name = shift(@pkg_data);  #this will leave just the dependencies

    if (exists $this->{pkgList}->{$pakcage_name}){

    }else{
	my $stop;
	my $pkg_ref  = Package->new($pakcage_name);
	$this->{pkgLIst}->{$pakcage_name} = $pkg_ref;

	#$pkg->get_test();

	my $stop2;
    }

    
    #@keys = keys 
    return ;
} #end dependHandler



1;    # end of PkgMgr.pm

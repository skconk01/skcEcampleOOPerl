=head1 NAME

Package.pm


=head1 DESCRIPTION

*****************************************************************************

this is a container for meta data associated with each package

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
package Package;

use constant false => 0;
use constant true  => 1;


#_____________________________________________________________________________

=head2 new

  declartion:   new
       input:  name   then name of pacage
      return:   a blessed reference to this object
    function:   constructor for this class.

    this class will contain all the meta data for each package

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

  $this->{name} = shift;
  $this->{installedWith} = [];
  $this->{depends} = [];
  $this->{installed} = 'no';
  $this->{using} = [];
  $this->{needed} = [];


  return $this;
}


#_____________________________________________________________________________

=head2 get_name

  declartion:   get_name
       input:
      return:  $name   name of the data container
    function:

=cut back to perl

#_____________________________________________________________________________

sub get_name {

  my $this = shift;
  my $name = $this->{name};

  return $name;
}

#_____________________________________________________________________________


#_____________________________________________________________________________

=head2 get_dependencies

  declartion:   get_dependencies
       input:
      return:  $dep_ref  reference to the dependency array
    function:

=cut back to perl

#_____________________________________________________________________________

sub get_dependencies {

  my $this = shift;
  my $dep_ref = $this->{depends};

  return $dep_ref;
}

#_____________________________________________________________________________


#_____________________________________________________________________________

=head2 add_dependencies

  declartion:   add_dependencies
       input:  @dep
      return:
    function:  add the values in @dep to 
               $this->{depends}  array
$this->{depends}

=cut back to perl

#_____________________________________________________________________________

sub add_dependencies {

  my $this = shift;
  my @dep = @_;

  $this->{depends} = \@dep;  #add dep array to the reference $this->{depends}

  my $stop;
  return 0;
}

#_____________________________________________________________________________

=head2 print_dependencies

  declartion:   print_dependencies
       input:
      return:
    function:  print the dependencies for this package

$this->{depends}

=cut back to perl

#_____________________________________________________________________________

sub print_dependencies {

  my $this = shift;

  my $dep_ref = $this->{depends};

  foreach my $dep ( @$dep_ref) {
    print "---> $dep\n";

  }

  return 0;
}

#_____________________________________________________________________________


#_____________________________________________________________________________

=head2 set_install

  declartion:   set_install
       input:
      return:
    function:  set the intall flag to yes


$this->{installed} = 'yes';

=cut back to perl

#_____________________________________________________________________________

sub set_install {

  my $this = shift;

  $this->{installed} = 'yes';

  return 0;
}
#_____________________________________________________________________________


#_____________________________________________________________________________

=head2 ck_if_installed

  declartion:   ck_if_installed
       input:
      return:   rc   false not installed true if installed
    function:  check to see if the $this->{installed} is yes


$this->{installed} = 'yes';

=cut back to perl

#_____________________________________________________________________________

sub ck_if_installed {

  my $this = shift;
  my $rc = 'NULL';


  if ($this->{installed} eq 'yes') {
    $rc = true;
  }else {
    $rc = false;
  }



  return $rc;
}
#_____________________________________________________________________________

#_____________________________________________________________________________

1;    # end of Pacage.pm

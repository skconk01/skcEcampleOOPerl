=head1 NAME

Package.pm


=head1 DESCRIPTION

*****************************************************************************

this is a container for meta data associated with each package

*****************************************************************************

@author Stephen Conklin
2013-10-08  14-02-25

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
  my $name = $this->{name};

  $this->{installed} = 'yes';
  print "successfully installed package -->  $name\n";

  return 0;
}
#_____________________________________________________________________________

#_____________________________________________________________________________

=head2 set_remove

  declartion:   set_remove
       input:
      return:
    function:  set the intall flag to no


$this->{installed} = 'no';

=cut back to perl

#_____________________________________________________________________________

sub set_remove {

  my $this = shift;
  my $name = $this->{name};

  $this->{installed} = 'no';
  print "successfully removed package --> $name\n";

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

=head2 add_to_using_list

  declartion:   add_to_using_list
       input:   package_name   name of package to add to using list
      return:
    function:   add package_name to list of packages using this package

$this->{using} = [];
print @{ $this->{using}}

=cut back to perl

#_____________________________________________________________________________

sub add_to_using_list {

  my $this = shift;
  my $package_name = shift;

  push (@{ $this->{using} },$package_name);

  return 0;
}
#_____________________________________________________________________________


#_____________________________________________________________________________

=head2 get_using_list

  declartion:   get_using_list
       input:   
      return:   $using_list_ref 
    function:   return the using list for this object

$this->{using} = [];
print @{ $this->{using}}

=cut back to perl

#_____________________________________________________________________________

sub get_using_list{

  my $this = shift;
  my $using_list_ref = $this->{using};

  return $using_list_ref;
}
#_____________________________________________________________________________


#_____________________________________________________________________________

=head2 remove_from_using_list

  declartion:   remove_from_using_list
       input:   $item   item to be removed
      return:   
    function:   remove $item from the using list because the package 
                is no longer being used by this package.

$this->{using} = [];
print @{ $this->{using}}
my @a = grep  {$_ ne $dep} @{ $using_list_ref };

=cut back to perl

#_____________________________________________________________________________

sub remove_from_using_list{

  my $this = shift;
  my $item = shift;

  #remove $item from the using array list
  @{ $this->{using}}  = grep  {$_ ne $item} @{ $this->{using}};

  return 0;
}
#_____________________________________________________________________________

#_____________________________________________________________________________

1;    # end of Pacage.pm

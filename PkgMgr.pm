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

use constant false => 0;
use constant true  => 1;


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
#_____________________________________________________________________________


#_____________________________________________________________________________

=head2 dependHandlere

  declartion:  dependHandler
       input:  $pkg_data  line containing the package and the dependences
      return:  
    function:  if the package is not in the list create a package object
               and add it to the list, then add any dependencies. if the
               package is in the list add the dependences.

$this->{pkgList} = ();  #hash to contain the packages.
exists $hash{$key}

print keys % { $this->{pkgList} }

=cut back to perl

#_____________________________________________________________________________

sub dependHandler{
    my $this = shift;
    my @pkg_data = @_;
    my $pkg;   #this will become the package object
    my $pakcage_name = shift(@pkg_data);  #this will leave just the dependencies

    if (exists $this->{pkgList}{$pakcage_name}) {
      my $stop;
    }else {
      $pkg = Package->new($pakcage_name);
      $this->{pkgList}{$pakcage_name} = $pkg;
      $pkg->add_dependencies(@pkg_data);
    }

    return ;
} #end dependHandler

#_____________________________________________________________________________

=head2 listHandler

  declartion:   listHandler
       input:   listType  installed -> installed packages
                          depends -> list of packages and dependencies
                          all   -> list all packages in  list
      return:   none
    function:   base on the input print a list of instaled packages for 
                installed input and a list of packages and dependencies 
                for depends input.


=cut back to perl

#_____________________________________________________________________________

sub listHandler {
  my $this = shift;
  my $listType = shift;
  # print keys % { $this->{pkgList} }


   if (!$this->packagesInstalled() ) {
    print "no packages are installed \n";
    return 1;
  }


  if ($listType eq 'all') {

    foreach my $pakcage_name (keys  % { $this->{pkgList} } ) {
      my $pkg = $this->{pkgList}{$pakcage_name};
      my $name = $pkg->get_name();
      print "$name\n";
    }
  }elsif ($listType eq 'installed' ) {
    foreach my $pakcage_name (keys  % { $this->{pkgList} }  ) {
      my $pkg = $this->{pkgList}{$pakcage_name}; #get the reference to the
      if ($pkg->ck_if_installed()) {
	my $name = $pkg->get_name();
	 print "$name\n";
      }
    }

  }elsif ($listType eq 'depends') {
    foreach my $pakcage_name (keys  % { $this->{pkgList} } ) {
      my $pkg = $this->{pkgList}{$pakcage_name}; #get the reference to the
      #objecte with package data
      my $name = $pkg->get_name();
      print "$name\n";
      $pkg->print_dependencies();
    }


  }else {
    print " all installed depends \n";
  }

  return;
}
#_____________________________________________________________________________

#_____________________________________________________________________________

=head2 installHandler

  declartion:   installHandler
       input:   pkg   the package to be installed
      return:   none
    function:   this method will handle install the package 
                in pkg and any dependencies

=cut back to perl

#_____________________________________________________________________________

sub installHandler {
  my $this = shift;
  my $pkg  = shift;

  #check to see if the package is installed
  if ($this->isPkgInstalled($pkg)) {
    print "The package --> $pkg <--  is already installed\n";
    return 1;  #package installed
  }

  $this->resolveDependency($pkg);

  $this->installPkg($pkg);

  return 0;
}
#_____________________________________________________________________________

#_____________________________________________________________________________

=head2 removeHandler

  declartion:   removeHandler
       input:   pkg   the package to be removes
      return:   none
    function:  

=cut back to perl

#_____________________________________________________________________________

sub removeHandler {
  my $this = shift;
  my $pkg  = shift;

  #check to see if the package is installed
  if ($this->isPkgInstalled($pkg)) {
    print "The package --> $pkg <--  is already installed\n";
    return 1;  #package installed
  }

  $this->resolveDependency($pkg);

  $this->installPkg($pkg);

  return 0;
}
#_____________________________________________________________________________

#_____________________________________________________________________________

=head2 resolveDependency

  declartion:   resolveDependency
       input:   pkg  the package to check depends
      return:   none
    function:   take care of any dependency needed by the package in packageName

=cut back to perl

#_____________________________________________________________________________

sub resolveDependency {
  my $this = shift;
  my $pakcage_name = shift;


  if ($this->dependCheck($pakcage_name)) {

    my $pkg = $this->{pkgList}{$pakcage_name};
    my $dep_ref = $pkg->get_dependencies();
    my @dep_array = @$dep_ref;
    foreach my $dep_name (@dep_array) {
      print $dep_name;
      #my $pkg = $this->{pkgList}{$dep_name};
      if (!$this->isPkgInstalled($dep_name)) { #go here if not installed
	$this->resolveDependency($dep_name);
	print "need to install dependency $dep_name\n";
	if (! $this->isPkgInstalled($dep_name)) {
	  print "installing dependent package $dep_name\n";
	  $this->installPkg($dep_name);
	}

	my $stop;
      }
    }

    my $stop = 'has dependneces';
  }else {
    my $stop = 'no dependneces';
  }

  return 0; 
}
#_____________________________________________________________________________



#_____________________________________________________________________________

=head2 dependCheck

  declartion:   dependCheck
       input:   pkg  the package to be checked
      return:   rc return code: rc = False-- no dependency
    function:   check to see if this package has any dependencies

=cut back to perl

#_____________________________________________________________________________

sub dependCheck {
  my $this = shift;
  my $pkg = shift;
  my $rc = 'NULL';
  # use constant false => 0;
  # use constant true  => 1;
  # print keys % { $this->{pkgList} }
  #is the package in the package list

  if (exists $this->{pkgList}{$pkg}) {
    $rc = true;
  } else {
    $rc = false;
  }


  return $rc;
}
#_____________________________________________________________________________


#_____________________________________________________________________________

=head2 installPkg

  declartion:   installPkg
       input:   $pakcage_name  package to be installed
      return:   
    function:   install the package in the var pkg.
                check to see if the package is in the
                  $this->{pkgList}
                if not creat a package object and add it
                if in the list set install to yes

# print keys % { $this->{pkgList} }

=cut back to perl

#_____________________________________________________________________________

sub installPkg {
  my $this = shift;
  my $pakcage_name = shift;

  if ( exists $this->{pkgList}{$pakcage_name}) {
    my $stop;
    my $pkg = $this->{pkgList}{$pakcage_name};
    $pkg->set_install();
  }else {
    my $pkg = Package->new($pakcage_name);
    $this->{pkgList}{$pakcage_name} = $pkg;
    $pkg->set_install();
    my $name = $pkg->get_name();
    print "successfully installed package -->  $name\n";
  }

  return 0;
}
#_____________________________________________________________________________


#_____________________________________________________________________________

=head2 packagesInstalled

  declartion:   packagesInstalled
       input:  
      return:  
    function:  check to see if any packages are installed

=cut back to perl

#_____________________________________________________________________________

sub packagesInstalled {
  my $this = shift;
  my $rc = 'NULL';
  # use constant false
  # use constant true 
  # print keys % { $this->{pkgList} }
  #is the package in the package list

  my $size = keys % { $this->{pkgList} };

   if ($size > 0) {
     $rc = true;
   } else {
     $rc = false;
   }


  return $rc;
}
#_____________________________________________________________________________



#_____________________________________________________________________________

=head2 isPkgInstalled

  declartion:   isPkgInstalled
       input:  $package_name   name of package looking for
      return:  $rc   true if installed
                     false if not installed
    function:  check to see if the pack is installed.
              first check to see if the package is in the list
              $this->{pkgList}
              if it is check to see if it is installed

=cut back to perl

#_____________________________________________________________________________

sub isPkgInstalled {
  my $this = shift;
  my $pakcage_name = shift;
  my $rc = false;

  if (exists $this->{pkgList}{$pakcage_name}) {
    my $pkg = $this->{pkgList}{$pakcage_name};
    if ($pkg->ck_if_installed) {
      $rc = true;
    }
  }


  return $rc;
}
#_____________________________________________________________________________


#_____________________________________________________________________________
1;    # end of PkgMgr.pm

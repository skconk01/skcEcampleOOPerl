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

  $this->name = shift;
  $this->installedWith = [];
  $this->depends = [];
  $this->installed = 'no';
  $this->using = [];
  $this->needed = [];

  return $this;
}


1;    # end of Pacage.pm

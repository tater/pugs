class Object {

=begin

=head1 NAME

Object - This is the base object for the standard Perl 6 libraries

=head1 DESCRIPTION

See http://www.perlfoundation.org/perl6/index.cgi?smop_oo_api

=head1 Methods

This are the methods implemented by Object

=over

=item method new(*@protoobjects, *%initialize --> Object )

This method creates a new object with the default represenation and
initializes it with the given named parameters and protoobjects.

=end

  method new($prototype: *@protoobjects, *%initialize) {
      return $prototype.bless($prototype.CREATE(),
                              |@protoobjects,
                              |%initialize);
  };


=begin

=item  method bless($candidate, *@protoobjects, *%initialize --> Object )

This method sets the invocant as the prototype of the given object and
call the initialization code from least-derived to most-derived. In
Object, it is simply delegated to the metaclass.

=end

  method bless($prototype: $candidate, *@protoobjects, *%initialize) {
      return $prototype.^bless($canidate,
                               |@protoobjects,
                               |%initialize);
  }


=begin

=item method clone( --> Object )

Creates a clone of the current object.

=end

  method clone($object: ) {
      return $object.^clone();
  }

=begin

=item  method defined($object: )

Is this object defined?

=end

  method defined($object: ) {
      return $object.^defined();
  }

=begin

=item method isa($object: $prototype )

Is $prototype part of this object hierarchy?

=end

  method isa($object: $prototype --> bool ) {
      return $object.^isa($prototype);
  }

=begin

=item  method does($object: $prototype )

Does this object implement $prototype?

=end

  method does($object: $prototype --> bool ) {
      return $object.^does($prototype);
  }


=begin

=item method can($object: $name, $capture? )

Asks the metaclass if this object can do this method.

=end

  method can($name, $capture? --> List of Method ) {
      return $object.^can($name, $capture);
  }

=begin

=item method CREATE($object: :$repr )

This method will create a new object instance using the given
representation or the default one.

=end

  method CREATE($prototype: :$repr = 'p6opaque') {
      return $prototype.^CREATE(:repr($repr))
  }

=begin

=item method BUILDALL(*@protoobjects, *%initialize)

This will traverse the hierarchy calling BUILD in each class.

=end


  method BUILDALL($self: *@protoobjects, *%initialize) {
      return $self.^BUILDALL(|@protoobjects, |%initialize);
  }

=begin

=item method DESTROYALL()

This will traverse the hierarchy calling DESTROY in each class.

=end

  method DESTROYALL($object:) {
      $object.^DESTROYALL();
  }

=begin

=item submethod BUILD(*%initialize)

The default build initializes all public attributes defined in the
named arguments.

=end

  method BUILD($object: *%initialize) {
      for $+CLASS.^atttributes(:local) -> $att {
          my $key = $att.name;
          $object.::($+CLASS)!"$key" = %initialize{$key};
      }
  }

=begin

=back

=end

}

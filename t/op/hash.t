#!/usr/bin/pugs

use v6;
require Test;

=kwid

Hash tests

=cut

plan 40;

# basic lvalue assignment

my %hash1; 
%hash1{"one"} = 5; 
is(%hash1{"one"}, 5, 'lvalue hash assignment works (w/ double quoted keys)');

%hash1{'one'} = 4; 
is(%hash1{'one'}, 4, 'lvalue hash re-assignment works (w/ single quoted keys)');

my %hash1; 
%hash1<three> = 3; 
todo_is(%hash1<tree>, 3, 'lvalue hash assignment works (w/ unquoted style <key>)');

# basic hash creation w/ comma seperated key/values

my %hash2 = ("one", 1);
is(%hash2{"one"}, 1, 'comma seperated key/value hash creation works');
is(%hash2<one>, 1, 'unquoted <key> fetching works');

my %hash3 = ("one", 1, "two", 2);
is(%hash3{"one"}, 1, 'comma seperated key/value hash creation works with more than one pair');
is(%hash3{"two"}, 2, 'comma seperated key/value hash creation works with more than one pair');

# basic hash creation w/ => seperated key/values (pairs?)

my %hash4;
# eval '%hash4 = ("key" => "value")';
todo_is(%hash4{"key"}, 'value', '(key => value) seperated key/value has creation works');

# hash slicing

my %hash5 = ("one", 1, "two", 2, "three", 3);

my @slice1 = %hash5{"one", "three"};
is(+@slice1, 2, 'got the right amount of values from the %hash{} slice');
is(@slice1[0], 1, '%hash{} slice successfull');
is(@slice1[1], 3, '%hash{} slice successfull');

my @slice2;
eval '@slice2 = %hash5<three one>';
is(+@slice2, 2, 'got the right amount of values from the %hash<> slice');
is(@slice2[0], 3, '%hash<> slice was successful');
is(@slice2[1], 1, '%hash<> slice was successful');

# slice assignment

eval '%hash5{"one", "three"} = (5, 10)';
todo_is(%hash5<one>, 5, 'value was changed successfully with slice assignment');
todo_is(%hash5<three>, 10, 'value was changed successfully with slice assignment');

eval '%hash5<one three> = (3, 1)';
todo_is(%hash5<one>, 3, 'value was changed successfully with slice assignment');
todo_is(%hash5<three>, 1, 'value was changed successfully with slice assignment');

eval '%hash<one three> = [3, 1]';
todo_is(%hash5<one>[0], 3, 'value assigned successfully with arrayref in list context');
todo_is(%hash5<one>[1], 1, 'value assigned successfully with arrayref in list context');
todo_ok(!defined(%hash5<three>), '"three" assumed value undef from slice assignment');

# keys 

my %hash6 = ("one", 1, "two", 2, "three", 3);

my @keys1 = keys %hash6;
is(+@keys1, 3, 'got the right number of keys');
is(@keys1[0], 'one', 'got the right key');
is(@keys1[1], 'three', 'got the right key');
is(@keys1[2], 'two', 'got the right key');

my @keys2 = %hash6.keys;
is(+@keys2, 3, 'got the right number of keys');
is(@keys2[0], 'one', 'got the right key');
is(@keys2[1], 'three', 'got the right key');
is(@keys2[2], 'two', 'got the right key');

# values

my %hash7 = ("one", 1, "two", 2, "three", 3);

my @values1 = values %hash7;
is(+@values1, 3, 'got the right number of values');
is(@values1[0], 1, 'got the right values');
is(@values1[1], 3, 'got the right values');
is(@values1[2], 2, 'got the right values');

my @values1 = %hash7.values;
is(+@values1, 3, 'got the right number of values');
is(@values1[0], 1, 'got the right values');
is(@values1[1], 3, 'got the right values');
is(@values1[2], 2, 'got the right values');

# misc stuff ...

my %hash8;
eval '%hash8 = (:one, :key<value>, :three(3))';
todo_is %hash8{'one'}, 1, 'colonpair :one';
todo_is %hash8{'key'}, 'value', 'colonpair :key<value>';
todo_is %hash8{'three'}, 3, 'colonpair :three(3)';


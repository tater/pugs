use Test;
use Regexp::Parser;
use strict;

my @tests = <DATA>;
plan tests => @tests+0;

for my $line (@tests) {
  chomp($line);
  print "        \# $line\n";
  my($pat,$str,$ok,$thing,$value,@rest)=split(/\t/,$line);

  # $pat can be either "re", or "'re'i".
  my $re = $pat;
  my $modifiers = "";
  if ($re =~ /^\'/) {
    $re =~ s/^\'//;
    $re =~ s/\'([^\']*)$//;
    $modifiers = $1;
  }
  # Currently ignoring the modifiers;

  my $parser = Regexp::Parser->new($re);
  my $root;
  $root = eval{ $parser->root } if not $parser->errmsg;

  my $parse_failed = !defined $root;
  my $failure_expected = $ok =~ /c/;

  if($parse_failed) {
    my $err = $@;
    $err =~ s/^/          \# /mg;
    if($failure_expected) {
      print "ok\n";
    }
    else {
      print "not ok    # Unexpected parse failure.\n$err";
    }
  }
  else {
    if($failure_expected) {
      print "not ok    # Parse should have failed.\n";
    }
    else {
      print "ok\n";
    }
  }

  # Additional testing, beyond mere parsing, could go here.
}


# The __DATA__ section is the perl5 distribution's t/op/re_tests .
# http://svn.perl.org/perl5/mirrors/perl/t/op/re_tests
# As of 2006-Feb-12:
#  27325 bytes; md5sum: 1c0d54e3aa3417185f997a9c9eb8118e  re_tests

# Here is the documentation comment from the driver,
# http://svn.perl.org/perl5/mirrors/perl/t/op/regexp.t

# The tests are in a separate file 't/op/re_tests'.
# Each line in that file is a separate test.
# There are five columns, separated by tabs.
#
# Column 1 contains the pattern, optionally enclosed in C<''>.
# Modifiers can be put after the closing C<'>.
#
# Column 2 contains the string to be matched.
#
# Column 3 contains the expected result:
# 	y	expect a match
# 	n	expect no match
# 	c	expect an error
#	B	test exposes a known bug in Perl, should be skipped
#	b	test exposes a known bug in Perl, should be skipped if noamp
#
# Columns 4 and 5 are used only if column 3 contains C<y> or C<c>.
#
# Column 4 contains a string, usually C<$&>.
#
# Column 5 contains the expected result of double-quote
# interpolating that string after the match, or start of error message.
#
# Column 6, if present, contains a reason why the test is skipped.
# This is printed with "skipped", for harness to pick up.
#
# \n in the tests are interpolated, as are variables of the form ${\w+}.
#
# If you want to add a regular expression test that can't be expressed
# in this format, don't add it here: put it in op/pat.t instead.


__DATA__
abc	abc	y	$&	abc
abc	abc	y	$-[0]	0
abc	abc	y	$+[0]	3
abc	xbc	n	-	-
abc	axc	n	-	-
abc	abx	n	-	-
abc	xabcy	y	$&	abc
abc	xabcy	y	$-[0]	1
abc	xabcy	y	$+[0]	4
abc	ababc	y	$&	abc
abc	ababc	y	$-[0]	2
abc	ababc	y	$+[0]	5
ab*c	abc	y	$&	abc
ab*c	abc	y	$-[0]	0
ab*c	abc	y	$+[0]	3
ab*bc	abc	y	$&	abc
ab*bc	abc	y	$-[0]	0
ab*bc	abc	y	$+[0]	3
ab*bc	abbc	y	$&	abbc
ab*bc	abbc	y	$-[0]	0
ab*bc	abbc	y	$+[0]	4
ab*bc	abbbbc	y	$&	abbbbc
ab*bc	abbbbc	y	$-[0]	0
ab*bc	abbbbc	y	$+[0]	6
.{1}	abbbbc	y	$&	a
.{1}	abbbbc	y	$-[0]	0
.{1}	abbbbc	y	$+[0]	1
.{3,4}	abbbbc	y	$&	abbb
.{3,4}	abbbbc	y	$-[0]	0
.{3,4}	abbbbc	y	$+[0]	4
ab{0,}bc	abbbbc	y	$&	abbbbc
ab{0,}bc	abbbbc	y	$-[0]	0
ab{0,}bc	abbbbc	y	$+[0]	6
ab+bc	abbc	y	$&	abbc
ab+bc	abbc	y	$-[0]	0
ab+bc	abbc	y	$+[0]	4
ab+bc	abc	n	-	-
ab+bc	abq	n	-	-
ab{1,}bc	abq	n	-	-
ab+bc	abbbbc	y	$&	abbbbc
ab+bc	abbbbc	y	$-[0]	0
ab+bc	abbbbc	y	$+[0]	6
ab{1,}bc	abbbbc	y	$&	abbbbc
ab{1,}bc	abbbbc	y	$-[0]	0
ab{1,}bc	abbbbc	y	$+[0]	6
ab{1,3}bc	abbbbc	y	$&	abbbbc
ab{1,3}bc	abbbbc	y	$-[0]	0
ab{1,3}bc	abbbbc	y	$+[0]	6
ab{3,4}bc	abbbbc	y	$&	abbbbc
ab{3,4}bc	abbbbc	y	$-[0]	0
ab{3,4}bc	abbbbc	y	$+[0]	6
ab{4,5}bc	abbbbc	n	-	-
ab?bc	abbc	y	$&	abbc
ab?bc	abc	y	$&	abc
ab{0,1}bc	abc	y	$&	abc
ab?bc	abbbbc	n	-	-
ab?c	abc	y	$&	abc
ab{0,1}c	abc	y	$&	abc
^abc$	abc	y	$&	abc
^abc$	abcc	n	-	-
^abc	abcc	y	$&	abc
^abc$	aabc	n	-	-
abc$	aabc	y	$&	abc
abc$	aabcd	n	-	-
^	abc	y	$&	
$	abc	y	$&	
a.c	abc	y	$&	abc
a.c	axc	y	$&	axc
a.*c	axyzc	y	$&	axyzc
a.*c	axyzd	n	-	-
a[bc]d	abc	n	-	-
a[bc]d	abd	y	$&	abd
a[b-d]e	abd	n	-	-
a[b-d]e	ace	y	$&	ace
a[b-d]	aac	y	$&	ac
a[-b]	a-	y	$&	a-
a[b-]	a-	y	$&	a-
a[b-a]	-	c	-	Invalid [] range "b-a"
a[]b	-	c	-	Unmatched [
a[	-	c	-	Unmatched [
a]	a]	y	$&	a]
a[]]b	a]b	y	$&	a]b
a[^bc]d	aed	y	$&	aed
a[^bc]d	abd	n	-	-
a[^-b]c	adc	y	$&	adc
a[^-b]c	a-c	n	-	-
a[^]b]c	a]c	n	-	-
a[^]b]c	adc	y	$&	adc
\ba\b	a-	y	-	-
\ba\b	-a	y	-	-
\ba\b	-a-	y	-	-
\by\b	xy	n	-	-
\by\b	yz	n	-	-
\by\b	xyz	n	-	-
\Ba\B	a-	n	-	-
\Ba\B	-a	n	-	-
\Ba\B	-a-	n	-	-
\By\b	xy	y	-	-
\By\b	xy	y	$-[0]	1
\By\b	xy	y	$+[0]	2
\By\b	xy	y	-	-
\by\B	yz	y	-	-
\By\B	xyz	y	-	-
\w	a	y	-	-
\w	-	n	-	-
\W	a	n	-	-
\W	-	y	-	-
a\sb	a b	y	-	-
a\sb	a-b	n	-	-
a\Sb	a b	n	-	-
a\Sb	a-b	y	-	-
\d	1	y	-	-
\d	-	n	-	-
\D	1	n	-	-
\D	-	y	-	-
[\w]	a	y	-	-
[\w]	-	n	-	-
[\W]	a	n	-	-
[\W]	-	y	-	-
a[\s]b	a b	y	-	-
a[\s]b	a-b	n	-	-
a[\S]b	a b	n	-	-
a[\S]b	a-b	y	-	-
[\d]	1	y	-	-
[\d]	-	n	-	-
[\D]	1	n	-	-
[\D]	-	y	-	-
ab|cd	abc	y	$&	ab
ab|cd	abcd	y	$&	ab
()ef	def	y	$&-$1	ef-
()ef	def	y	$-[0]	1
()ef	def	y	$+[0]	3
()ef	def	y	$-[1]	1
()ef	def	y	$+[1]	1
*a	-	c	-	Quantifier follows nothing
(*)b	-	c	-	Quantifier follows nothing
$b	b	n	-	-
a\	-	c	-	Search pattern not terminated
a\(b	a(b	y	$&-$1	a(b-
a\(*b	ab	y	$&	ab
a\(*b	a((b	y	$&	a((b
a\\b	a\b	y	$&	a\b
abc)	-	c	-	Unmatched )
(abc	-	c	-	Unmatched (
((a))	abc	y	$&-$1-$2	a-a-a
((a))	abc	y	$-[0]-$-[1]-$-[2]	0-0-0
((a))	abc	y	$+[0]-$+[1]-$+[2]	1-1-1
((a))	abc	b	@-	0 0 0
((a))	abc	b	@+	1 1 1
(a)b(c)	abc	y	$&-$1-$2	abc-a-c
(a)b(c)	abc	y	$-[0]-$-[1]-$-[2]	0-0-2
(a)b(c)	abc	y	$+[0]-$+[1]-$+[2]	3-1-3
a+b+c	aabbabc	y	$&	abc
a{1,}b{1,}c	aabbabc	y	$&	abc
a**	-	c	-	Nested quantifiers
a.+?c	abcabc	y	$&	abc
(a+|b)*	ab	y	$&-$1	ab-b
(a+|b)*	ab	y	$-[0]	0
(a+|b)*	ab	y	$+[0]	2
(a+|b)*	ab	y	$-[1]	1
(a+|b)*	ab	y	$+[1]	2
(a+|b){0,}	ab	y	$&-$1	ab-b
(a+|b)+	ab	y	$&-$1	ab-b
(a+|b){1,}	ab	y	$&-$1	ab-b
(a+|b)?	ab	y	$&-$1	a-a
(a+|b){0,1}	ab	y	$&-$1	a-a
)(	-	c	-	Unmatched )
[^ab]*	cde	y	$&	cde
abc		n	-	-
a*		y	$&	
([abc])*d	abbbcd	y	$&-$1	abbbcd-c
([abc])*bcd	abcd	y	$&-$1	abcd-a
a|b|c|d|e	e	y	$&	e
(a|b|c|d|e)f	ef	y	$&-$1	ef-e
(a|b|c|d|e)f	ef	y	$-[0]	0
(a|b|c|d|e)f	ef	y	$+[0]	2
(a|b|c|d|e)f	ef	y	$-[1]	0
(a|b|c|d|e)f	ef	y	$+[1]	1
abcd*efg	abcdefg	y	$&	abcdefg
ab*	xabyabbbz	y	$&	ab
ab*	xayabbbz	y	$&	a
(ab|cd)e	abcde	y	$&-$1	cde-cd
[abhgefdc]ij	hij	y	$&	hij
^(ab|cd)e	abcde	n	x$1y	xy
(abc|)ef	abcdef	y	$&-$1	ef-
(a|b)c*d	abcd	y	$&-$1	bcd-b
(ab|ab*)bc	abc	y	$&-$1	abc-a
a([bc]*)c*	abc	y	$&-$1	abc-bc
a([bc]*)(c*d)	abcd	y	$&-$1-$2	abcd-bc-d
a([bc]*)(c*d)	abcd	y	$-[0]	0
a([bc]*)(c*d)	abcd	y	$+[0]	4
a([bc]*)(c*d)	abcd	y	$-[1]	1
a([bc]*)(c*d)	abcd	y	$+[1]	3
a([bc]*)(c*d)	abcd	y	$-[2]	3
a([bc]*)(c*d)	abcd	y	$+[2]	4
a([bc]+)(c*d)	abcd	y	$&-$1-$2	abcd-bc-d
a([bc]*)(c+d)	abcd	y	$&-$1-$2	abcd-b-cd
a([bc]*)(c+d)	abcd	y	$-[0]	0
a([bc]*)(c+d)	abcd	y	$+[0]	4
a([bc]*)(c+d)	abcd	y	$-[1]	1
a([bc]*)(c+d)	abcd	y	$+[1]	2
a([bc]*)(c+d)	abcd	y	$-[2]	2
a([bc]*)(c+d)	abcd	y	$+[2]	4
a[bcd]*dcdcde	adcdcde	y	$&	adcdcde
a[bcd]+dcdcde	adcdcde	n	-	-
(ab|a)b*c	abc	y	$&-$1	abc-ab
(ab|a)b*c	abc	y	$-[0]	0
(ab|a)b*c	abc	y	$+[0]	3
(ab|a)b*c	abc	y	$-[1]	0
(ab|a)b*c	abc	y	$+[1]	2
((a)(b)c)(d)	abcd	y	$1-$2-$3-$4	abc-a-b-d
((a)(b)c)(d)	abcd	y	$-[0]	0
((a)(b)c)(d)	abcd	y	$+[0]	4
((a)(b)c)(d)	abcd	y	$-[1]	0
((a)(b)c)(d)	abcd	y	$+[1]	3
((a)(b)c)(d)	abcd	y	$-[2]	0
((a)(b)c)(d)	abcd	y	$+[2]	1
((a)(b)c)(d)	abcd	y	$-[3]	1
((a)(b)c)(d)	abcd	y	$+[3]	2
((a)(b)c)(d)	abcd	y	$-[4]	3
((a)(b)c)(d)	abcd	y	$+[4]	4
[a-zA-Z_][a-zA-Z0-9_]*	alpha	y	$&	alpha
^a(bc+|b[eh])g|.h$	abh	y	$&-$1	bh-
(bc+d$|ef*g.|h?i(j|k))	effgz	y	$&-$1-$2	effgz-effgz-
(bc+d$|ef*g.|h?i(j|k))	ij	y	$&-$1-$2	ij-ij-j
(bc+d$|ef*g.|h?i(j|k))	effg	n	-	-
(bc+d$|ef*g.|h?i(j|k))	bcdd	n	-	-
(bc+d$|ef*g.|h?i(j|k))	reffgz	y	$&-$1-$2	effgz-effgz-
((((((((((a))))))))))	a	y	$10	a
((((((((((a))))))))))	a	y	$-[0]	0
((((((((((a))))))))))	a	y	$+[0]	1
((((((((((a))))))))))	a	y	$-[10]	0
((((((((((a))))))))))	a	y	$+[10]	1
((((((((((a))))))))))\10	aa	y	$&	aa
((((((((((a))))))))))${bang}	aa	n	-	-
((((((((((a))))))))))${bang}	a!	y	$&	a!
(((((((((a)))))))))	a	y	$&	a
multiple words of text	uh-uh	n	-	-
multiple words	multiple words, yeah	y	$&	multiple words
(.*)c(.*)	abcde	y	$&-$1-$2	abcde-ab-de
\((.*), (.*)\)	(a, b)	y	($2, $1)	(b, a)
[k]	ab	n	-	-
abcd	abcd	y	$&-\$&-\\$&	abcd-$&-\abcd
a(bc)d	abcd	y	$1-\$1-\\$1	bc-$1-\bc
a[-]?c	ac	y	$&	ac
(abc)\1	abcabc	y	$1	abc
([a-c]*)\1	abcabc	y	$1	abc
\1	-	c	-	Reference to nonexistent group
\2	-	c	-	Reference to nonexistent group
(a)|\1	a	y	-	-
(a)|\1	x	n	-	-
(a)|\2	-	c	-	Reference to nonexistent group
(([a-c])b*?\2)*	ababbbcbc	y	$&-$1-$2	ababb-bb-b
(([a-c])b*?\2){3}	ababbbcbc	y	$&-$1-$2	ababbbcbc-cbc-c
((\3|b)\2(a)x)+	aaxabxbaxbbx	n	-	-
((\3|b)\2(a)x)+	aaaxabaxbaaxbbax	y	$&-$1-$2-$3	bbax-bbax-b-a
((\3|b)\2(a)){2,}	bbaababbabaaaaabbaaaabba	y	$&-$1-$2-$3	bbaaaabba-bba-b-a
(a)|(b)	b	y	$-[0]	0
(a)|(b)	b	y	$+[0]	1
(a)|(b)	b	y	x$-[1]	x
(a)|(b)	b	y	x$+[1]	x
(a)|(b)	b	y	$-[2]	0
(a)|(b)	b	y	$+[2]	1
'abc'i	ABC	y	$&	ABC
'abc'i	XBC	n	-	-
'abc'i	AXC	n	-	-
'abc'i	ABX	n	-	-
'abc'i	XABCY	y	$&	ABC
'abc'i	ABABC	y	$&	ABC
'ab*c'i	ABC	y	$&	ABC
'ab*bc'i	ABC	y	$&	ABC
'ab*bc'i	ABBC	y	$&	ABBC
'ab*?bc'i	ABBBBC	y	$&	ABBBBC
'ab{0,}?bc'i	ABBBBC	y	$&	ABBBBC
'ab+?bc'i	ABBC	y	$&	ABBC
'ab+bc'i	ABC	n	-	-
'ab+bc'i	ABQ	n	-	-
'ab{1,}bc'i	ABQ	n	-	-
'ab+bc'i	ABBBBC	y	$&	ABBBBC
'ab{1,}?bc'i	ABBBBC	y	$&	ABBBBC
'ab{1,3}?bc'i	ABBBBC	y	$&	ABBBBC
'ab{3,4}?bc'i	ABBBBC	y	$&	ABBBBC
'ab{4,5}?bc'i	ABBBBC	n	-	-
'ab??bc'i	ABBC	y	$&	ABBC
'ab??bc'i	ABC	y	$&	ABC
'ab{0,1}?bc'i	ABC	y	$&	ABC
'ab??bc'i	ABBBBC	n	-	-
'ab??c'i	ABC	y	$&	ABC
'ab{0,1}?c'i	ABC	y	$&	ABC
'^abc$'i	ABC	y	$&	ABC
'^abc$'i	ABCC	n	-	-
'^abc'i	ABCC	y	$&	ABC
'^abc$'i	AABC	n	-	-
'abc$'i	AABC	y	$&	ABC
'^'i	ABC	y	$&	
'$'i	ABC	y	$&	
'a.c'i	ABC	y	$&	ABC
'a.c'i	AXC	y	$&	AXC
'a.*?c'i	AXYZC	y	$&	AXYZC
'a.*c'i	AXYZD	n	-	-
'a[bc]d'i	ABC	n	-	-
'a[bc]d'i	ABD	y	$&	ABD
'a[b-d]e'i	ABD	n	-	-
'a[b-d]e'i	ACE	y	$&	ACE
'a[b-d]'i	AAC	y	$&	AC
'a[-b]'i	A-	y	$&	A-
'a[b-]'i	A-	y	$&	A-
'a[b-a]'i	-	c	-	Invalid [] range "b-a"
'a[]b'i	-	c	-	Unmatched [
'a['i	-	c	-	Unmatched [
'a]'i	A]	y	$&	A]
'a[]]b'i	A]B	y	$&	A]B
'a[^bc]d'i	AED	y	$&	AED
'a[^bc]d'i	ABD	n	-	-
'a[^-b]c'i	ADC	y	$&	ADC
'a[^-b]c'i	A-C	n	-	-
'a[^]b]c'i	A]C	n	-	-
'a[^]b]c'i	ADC	y	$&	ADC
'ab|cd'i	ABC	y	$&	AB
'ab|cd'i	ABCD	y	$&	AB
'()ef'i	DEF	y	$&-$1	EF-
'*a'i	-	c	-	Quantifier follows nothing
'(*)b'i	-	c	-	Quantifier follows nothing
'$b'i	B	n	-	-
'a\'i	-	c	-	Search pattern not terminated
'a\(b'i	A(B	y	$&-$1	A(B-
'a\(*b'i	AB	y	$&	AB
'a\(*b'i	A((B	y	$&	A((B
'a\\b'i	A\B	y	$&	A\B
'abc)'i	-	c	-	Unmatched )
'(abc'i	-	c	-	Unmatched (
'((a))'i	ABC	y	$&-$1-$2	A-A-A
'(a)b(c)'i	ABC	y	$&-$1-$2	ABC-A-C
'a+b+c'i	AABBABC	y	$&	ABC
'a{1,}b{1,}c'i	AABBABC	y	$&	ABC
'a**'i	-	c	-	Nested quantifiers
'a.+?c'i	ABCABC	y	$&	ABC
'a.*?c'i	ABCABC	y	$&	ABC
'a.{0,5}?c'i	ABCABC	y	$&	ABC
'(a+|b)*'i	AB	y	$&-$1	AB-B
'(a+|b){0,}'i	AB	y	$&-$1	AB-B
'(a+|b)+'i	AB	y	$&-$1	AB-B
'(a+|b){1,}'i	AB	y	$&-$1	AB-B
'(a+|b)?'i	AB	y	$&-$1	A-A
'(a+|b){0,1}'i	AB	y	$&-$1	A-A
'(a+|b){0,1}?'i	AB	y	$&-$1	-
')('i	-	c	-	Unmatched )
'[^ab]*'i	CDE	y	$&	CDE
'abc'i		n	-	-
'a*'i		y	$&	
'([abc])*d'i	ABBBCD	y	$&-$1	ABBBCD-C
'([abc])*bcd'i	ABCD	y	$&-$1	ABCD-A
'a|b|c|d|e'i	E	y	$&	E
'(a|b|c|d|e)f'i	EF	y	$&-$1	EF-E
'abcd*efg'i	ABCDEFG	y	$&	ABCDEFG
'ab*'i	XABYABBBZ	y	$&	AB
'ab*'i	XAYABBBZ	y	$&	A
'(ab|cd)e'i	ABCDE	y	$&-$1	CDE-CD
'[abhgefdc]ij'i	HIJ	y	$&	HIJ
'^(ab|cd)e'i	ABCDE	n	x$1y	XY
'(abc|)ef'i	ABCDEF	y	$&-$1	EF-
'(a|b)c*d'i	ABCD	y	$&-$1	BCD-B
'(ab|ab*)bc'i	ABC	y	$&-$1	ABC-A
'a([bc]*)c*'i	ABC	y	$&-$1	ABC-BC
'a([bc]*)(c*d)'i	ABCD	y	$&-$1-$2	ABCD-BC-D
'a([bc]+)(c*d)'i	ABCD	y	$&-$1-$2	ABCD-BC-D
'a([bc]*)(c+d)'i	ABCD	y	$&-$1-$2	ABCD-B-CD
'a[bcd]*dcdcde'i	ADCDCDE	y	$&	ADCDCDE
'a[bcd]+dcdcde'i	ADCDCDE	n	-	-
'(ab|a)b*c'i	ABC	y	$&-$1	ABC-AB
'((a)(b)c)(d)'i	ABCD	y	$1-$2-$3-$4	ABC-A-B-D
'[a-zA-Z_][a-zA-Z0-9_]*'i	ALPHA	y	$&	ALPHA
'^a(bc+|b[eh])g|.h$'i	ABH	y	$&-$1	BH-
'(bc+d$|ef*g.|h?i(j|k))'i	EFFGZ	y	$&-$1-$2	EFFGZ-EFFGZ-
'(bc+d$|ef*g.|h?i(j|k))'i	IJ	y	$&-$1-$2	IJ-IJ-J
'(bc+d$|ef*g.|h?i(j|k))'i	EFFG	n	-	-
'(bc+d$|ef*g.|h?i(j|k))'i	BCDD	n	-	-
'(bc+d$|ef*g.|h?i(j|k))'i	REFFGZ	y	$&-$1-$2	EFFGZ-EFFGZ-
'((((((((((a))))))))))'i	A	y	$10	A
'((((((((((a))))))))))\10'i	AA	y	$&	AA
'((((((((((a))))))))))${bang}'i	AA	n	-	-
'((((((((((a))))))))))${bang}'i	A!	y	$&	A!
'(((((((((a)))))))))'i	A	y	$&	A
'(?:(?:(?:(?:(?:(?:(?:(?:(?:(a))))))))))'i	A	y	$1	A
'(?:(?:(?:(?:(?:(?:(?:(?:(?:(a|b|c))))))))))'i	C	y	$1	C
'multiple words of text'i	UH-UH	n	-	-
'multiple words'i	MULTIPLE WORDS, YEAH	y	$&	MULTIPLE WORDS
'(.*)c(.*)'i	ABCDE	y	$&-$1-$2	ABCDE-AB-DE
'\((.*), (.*)\)'i	(A, B)	y	($2, $1)	(B, A)
'[k]'i	AB	n	-	-
'abcd'i	ABCD	y	$&-\$&-\\$&	ABCD-$&-\ABCD
'a(bc)d'i	ABCD	y	$1-\$1-\\$1	BC-$1-\BC
'a[-]?c'i	AC	y	$&	AC
'(abc)\1'i	ABCABC	y	$1	ABC
'([a-c]*)\1'i	ABCABC	y	$1	ABC
a(?!b).	abad	y	$&	ad
a(?=d).	abad	y	$&	ad
a(?=c|d).	abad	y	$&	ad
a(?:b|c|d)(.)	ace	y	$1	e
a(?:b|c|d)*(.)	ace	y	$1	e
a(?:b|c|d)+?(.)	ace	y	$1	e
a(?:b|c|d)+?(.)	acdbcdbe	y	$1	d
a(?:b|c|d)+(.)	acdbcdbe	y	$1	e
a(?:b|c|d){2}(.)	acdbcdbe	y	$1	b
a(?:b|c|d){4,5}(.)	acdbcdbe	y	$1	b
a(?:b|c|d){4,5}?(.)	acdbcdbe	y	$1	d
((foo)|(bar))*	foobar	y	$1-$2-$3	bar-foo-bar
:(?:	-	c	-	Sequence (? incomplete
a(?:b|c|d){6,7}(.)	acdbcdbe	y	$1	e
a(?:b|c|d){6,7}?(.)	acdbcdbe	y	$1	e
a(?:b|c|d){5,6}(.)	acdbcdbe	y	$1	e
a(?:b|c|d){5,6}?(.)	acdbcdbe	y	$1	b
a(?:b|c|d){5,7}(.)	acdbcdbe	y	$1	e
a(?:b|c|d){5,7}?(.)	acdbcdbe	y	$1	b
a(?:b|(c|e){1,2}?|d)+?(.)	ace	y	$1$2	ce
^(.+)?B	AB	y	$1	A
^([^a-z])|(\^)$	.	y	$1	.
^[<>]&	<&OUT	y	$&	<&
^(a\1?){4}$	aaaaaaaaaa	y	$1	aaaa
^(a\1?){4}$	aaaaaaaaa	n	-	-
^(a\1?){4}$	aaaaaaaaaaa	n	-	-
^(a(?(1)\1)){4}$	aaaaaaaaaa	y	$1	aaaa
^(a(?(1)\1)){4}$	aaaaaaaaa	n	-	-
^(a(?(1)\1)){4}$	aaaaaaaaaaa	n	-	-
((a{4})+)	aaaaaaaaa	y	$1	aaaaaaaa
(((aa){2})+)	aaaaaaaaaa	y	$1	aaaaaaaa
(((a{2}){2})+)	aaaaaaaaaa	y	$1	aaaaaaaa
(?:(f)(o)(o)|(b)(a)(r))*	foobar	y	$1:$2:$3:$4:$5:$6	f:o:o:b:a:r
(?<=a)b	ab	y	$&	b
(?<=a)b	cb	n	-	-
(?<=a)b	b	n	-	-
(?<!c)b	ab	y	$&	b
(?<!c)b	cb	n	-	-
(?<!c)b	b	y	-	-
(?<!c)b	b	y	$&	b
(?<%)b	-	c	-	Sequence (?<%...) not recognized
(?:..)*a	aba	y	$&	aba
(?:..)*?a	aba	y	$&	a
^(?:b|a(?=(.)))*\1	abc	y	$&	ab
^(){3,5}	abc	y	a$1	a
^(a+)*ax	aax	y	$1	a
^((a|b)+)*ax	aax	y	$1	a
^((a|bc)+)*ax	aax	y	$1	a
(a|x)*ab	cab	y	y$1	y
(a)*ab	cab	y	y$1	y
(?:(?i)a)b	ab	y	$&	ab
((?i)a)b	ab	y	$&:$1	ab:a
(?:(?i)a)b	Ab	y	$&	Ab
((?i)a)b	Ab	y	$&:$1	Ab:A
(?:(?i)a)b	aB	n	-	-
((?i)a)b	aB	n	-	-
(?i:a)b	ab	y	$&	ab
((?i:a))b	ab	y	$&:$1	ab:a
(?i:a)b	Ab	y	$&	Ab
((?i:a))b	Ab	y	$&:$1	Ab:A
(?i:a)b	aB	n	-	-
((?i:a))b	aB	n	-	-
'(?:(?-i)a)b'i	ab	y	$&	ab
'((?-i)a)b'i	ab	y	$&:$1	ab:a
'(?:(?-i)a)b'i	aB	y	$&	aB
'((?-i)a)b'i	aB	y	$&:$1	aB:a
'(?:(?-i)a)b'i	Ab	n	-	-
'((?-i)a)b'i	Ab	n	-	-
'(?:(?-i)a)b'i	aB	y	$&	aB
'((?-i)a)b'i	aB	y	$1	a
'(?:(?-i)a)b'i	AB	n	-	-
'((?-i)a)b'i	AB	n	-	-
'(?-i:a)b'i	ab	y	$&	ab
'((?-i:a))b'i	ab	y	$&:$1	ab:a
'(?-i:a)b'i	aB	y	$&	aB
'((?-i:a))b'i	aB	y	$&:$1	aB:a
'(?-i:a)b'i	Ab	n	-	-
'((?-i:a))b'i	Ab	n	-	-
'(?-i:a)b'i	aB	y	$&	aB
'((?-i:a))b'i	aB	y	$1	a
'(?-i:a)b'i	AB	n	-	-
'((?-i:a))b'i	AB	n	-	-
'((?-i:a.))b'i	a\nB	n	-	-
'((?s-i:a.))b'i	a\nB	y	$1	a\n
'((?s-i:a.))b'i	B\nB	n	-	-
(?:c|d)(?:)(?:a(?:)(?:b)(?:b(?:))(?:b(?:)(?:b)))	cabbbb	y	$&	cabbbb
(?:c|d)(?:)(?:aaaaaaaa(?:)(?:bbbbbbbb)(?:bbbbbbbb(?:))(?:bbbbbbbb(?:)(?:bbbbbbbb)))	caaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb	y	$&	caaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
'(ab)\d\1'i	Ab4ab	y	$1	Ab
'(ab)\d\1'i	ab4Ab	y	$1	ab
foo\w*\d{4}baz	foobar1234baz	y	$&	foobar1234baz
a(?{})b	cabd	y	$&	ab
a(?{)b	-	c	-	Sequence (?{...}) not terminated or not {}-balanced
a(?{{})b	-	c	-	Sequence (?{...}) not terminated or not {}-balanced
a(?{}})b	-	c	-	
a(?{"{"})b	-	c	-	Sequence (?{...}) not terminated or not {}-balanced
a(?{"\{"})b	cabd	y	$&	ab
a(?{"{"}})b	-	c	-	Unmatched right curly bracket
a(?{$bl="\{"}).b	caxbd	y	$bl	{
x(~~)*(?:(?:F)?)?	x~~	y	-	-
^a(?#xxx){3}c	aaac	y	$&	aaac
'^a (?#xxx) (?#yyy) {3}c'x	aaac	y	$&	aaac
(?<![cd])b	dbcb	n	-	-
(?<![cd])[ab]	dbaacb	y	$&	a
(?<!(c|d))b	dbcb	n	-	-
(?<!(c|d))[ab]	dbaacb	y	$&	a
(?<!cd)[ab]	cdaccb	y	$&	b
^(?:a?b?)*$	a--	n	-	-
((?s)^a(.))((?m)^b$)	a\nb\nc\n	y	$1;$2;$3	a\n;\n;b
((?m)^b$)	a\nb\nc\n	y	$1	b
(?m)^b	a\nb\n	y	$&	b
(?m)^(b)	a\nb\n	y	$1	b
((?m)^b)	a\nb\n	y	$1	b
\n((?m)^b)	a\nb\n	y	$1	b
((?s).)c(?!.)	a\nb\nc\n	y	$1	\n
((?s).)c(?!.)	a\nb\nc\n	y	$1:$&	\n:\nc
((?s)b.)c(?!.)	a\nb\nc\n	y	$1	b\n
((?s)b.)c(?!.)	a\nb\nc\n	y	$1:$&	b\n:b\nc
^b	a\nb\nc\n	n	-	-
()^b	a\nb\nc\n	n	-	-
((?m)^b)	a\nb\nc\n	y	$1	b
(?(1)a|b)	a	n	-	-
(?(1)b|a)	a	y	$&	a
(x)?(?(1)a|b)	a	n	-	-
(x)?(?(1)b|a)	a	y	$&	a
()?(?(1)b|a)	a	y	$&	a
()(?(1)b|a)	a	n	-	-
()?(?(1)a|b)	a	y	$&	a
^(\()?blah(?(1)(\)))$	(blah)	y	$2	)
^(\()?blah(?(1)(\)))$	blah	y	($2)	()
^(\()?blah(?(1)(\)))$	blah)	n	-	-
^(\()?blah(?(1)(\)))$	(blah	n	-	-
^(\(+)?blah(?(1)(\)))$	(blah)	y	$2	)
^(\(+)?blah(?(1)(\)))$	blah	y	($2)	()
^(\(+)?blah(?(1)(\)))$	blah)	n	-	-
^(\(+)?blah(?(1)(\)))$	(blah	n	-	-
(?(1?)a|b)	a	c	-	Switch condition not recognized
(?(1)a|b|c)	a	c	-	Switch (?(condition)... contains too many branches
(?(?{0})a|b)	a	n	-	-
(?(?{0})b|a)	a	y	$&	a
(?(?{1})b|a)	a	n	-	-
(?(?{1})a|b)	a	y	$&	a
(?(?!a)a|b)	a	n	-	-
(?(?!a)b|a)	a	y	$&	a
(?(?=a)b|a)	a	n	-	-
(?(?=a)a|b)	a	y	$&	a
(?=(a+?))(\1ab)	aaab	y	$2	aab
^(?=(a+?))\1ab	aaab	n	-	-
(\w+:)+	one:	y	$1	one:
$(?<=^(a))	a	y	$1	a
(?=(a+?))(\1ab)	aaab	y	$2	aab
^(?=(a+?))\1ab	aaab	n	-	-
([\w:]+::)?(\w+)$	abcd:	n	-	-
([\w:]+::)?(\w+)$	abcd	y	$1-$2	-abcd
([\w:]+::)?(\w+)$	xy:z:::abcd	y	$1-$2	xy:z:::-abcd
^[^bcd]*(c+)	aexycd	y	$1	c
(a*)b+	caab	y	$1	aa
([\w:]+::)?(\w+)$	abcd:	n	-	-
([\w:]+::)?(\w+)$	abcd	y	$1-$2	-abcd
([\w:]+::)?(\w+)$	xy:z:::abcd	y	$1-$2	xy:z:::-abcd
^[^bcd]*(c+)	aexycd	y	$1	c
(?{$a=2})a*aa(?{local$a=$a+1})k*c(?{$b=$a})	yaaxxaaaacd	y	$b	3
(?{$a=2})(a(?{local$a=$a+1}))*aak*c(?{$b=$a})	yaaxxaaaacd	y	$b	4
(>a+)ab	aaab	n	-	-
(?>a+)b	aaab	y	-	-
([[:]+)	a:[b]:	y	$1	:[
([[=]+)	a=[b]=	y	$1	=[
([[.]+)	a.[b].	y	$1	.[
[a[:xyz:	-	c	-	Unmatched [
[a[:xyz:]	-	c	-	POSIX class [:xyz:] unknown
[a[:]b[:c]	abc	y	$&	abc
([a[:xyz:]b]+)	pbaq	c	-	POSIX class [:xyz:] unknown
[a[:]b[:c]	abc	y	$&	abc
([[:alpha:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	ABcd
([[:alnum:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	ABcd01Xy
([[:ascii:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	ABcd01Xy__--  ${nulnul}
([[:cntrl:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	${nulnul}
([[:digit:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	01
([[:graph:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	ABcd01Xy__--
([[:lower:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	cd
([[:print:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	ABcd01Xy__--  
([[:punct:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	__--
([[:space:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	  
([[:word:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	ABcd01Xy__
([[:upper:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	AB
([[:xdigit:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	ABcd01
([[:^alpha:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	01
([[:^alnum:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	__--  ${nulnul}${ffff}
([[:^ascii:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	${ffff}
([[:^cntrl:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	ABcd01Xy__--  
([[:^digit:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	ABcd
([[:^lower:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	AB
([[:^print:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	${nulnul}${ffff}
([[:^punct:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	ABcd01Xy
([[:^space:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	ABcd01Xy__--
([[:^word:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	--  ${nulnul}${ffff}
([[:^upper:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	cd01
([[:^xdigit:]]+)	ABcd01Xy__--  ${nulnul}${ffff}	y	$1	Xy__--  ${nulnul}${ffff}
[[:foo:]]	-	c	-	POSIX class [:foo:] unknown
[[:^foo:]]	-	c	-	POSIX class [:^foo:] unknown
((?>a+)b)	aaab	y	$1	aaab
(?>(a+))b	aaab	y	$1	aaa
((?>[^()]+)|\([^()]*\))+	((abc(ade)ufh()()x	y	$&	abc(ade)ufh()()x
(?<=x+)y	-	c	-	Variable length lookbehind not implemented
a{37,17}	-	c	-	Can't do {n,m} with n > m
\Z	a\nb\n	y	$-[0]	3
\z	a\nb\n	y	$-[0]	4
$	a\nb\n	y	$-[0]	3
\Z	b\na\n	y	$-[0]	3
\z	b\na\n	y	$-[0]	4
$	b\na\n	y	$-[0]	3
\Z	b\na	y	$-[0]	3
\z	b\na	y	$-[0]	3
$	b\na	y	$-[0]	3
'\Z'm	a\nb\n	y	$-[0]	3
'\z'm	a\nb\n	y	$-[0]	4
'$'m	a\nb\n	y	$-[0]	1
'\Z'm	b\na\n	y	$-[0]	3
'\z'm	b\na\n	y	$-[0]	4
'$'m	b\na\n	y	$-[0]	1
'\Z'm	b\na	y	$-[0]	3
'\z'm	b\na	y	$-[0]	3
'$'m	b\na	y	$-[0]	1
a\Z	a\nb\n	n	-	-
a\z	a\nb\n	n	-	-
a$	a\nb\n	n	-	-
a\Z	b\na\n	y	$-[0]	2
a\z	b\na\n	n	-	-
a$	b\na\n	y	$-[0]	2
a\Z	b\na	y	$-[0]	2
a\z	b\na	y	$-[0]	2
a$	b\na	y	$-[0]	2
'a\Z'm	a\nb\n	n	-	-
'a\z'm	a\nb\n	n	-	-
'a$'m	a\nb\n	y	$-[0]	0
'a\Z'm	b\na\n	y	$-[0]	2
'a\z'm	b\na\n	n	-	-
'a$'m	b\na\n	y	$-[0]	2
'a\Z'm	b\na	y	$-[0]	2
'a\z'm	b\na	y	$-[0]	2
'a$'m	b\na	y	$-[0]	2
aa\Z	aa\nb\n	n	-	-
aa\z	aa\nb\n	n	-	-
aa$	aa\nb\n	n	-	-
aa\Z	b\naa\n	y	$-[0]	2
aa\z	b\naa\n	n	-	-
aa$	b\naa\n	y	$-[0]	2
aa\Z	b\naa	y	$-[0]	2
aa\z	b\naa	y	$-[0]	2
aa$	b\naa	y	$-[0]	2
'aa\Z'm	aa\nb\n	n	-	-
'aa\z'm	aa\nb\n	n	-	-
'aa$'m	aa\nb\n	y	$-[0]	0
'aa\Z'm	b\naa\n	y	$-[0]	2
'aa\z'm	b\naa\n	n	-	-
'aa$'m	b\naa\n	y	$-[0]	2
'aa\Z'm	b\naa	y	$-[0]	2
'aa\z'm	b\naa	y	$-[0]	2
'aa$'m	b\naa	y	$-[0]	2
aa\Z	ac\nb\n	n	-	-
aa\z	ac\nb\n	n	-	-
aa$	ac\nb\n	n	-	-
aa\Z	b\nac\n	n	-	-
aa\z	b\nac\n	n	-	-
aa$	b\nac\n	n	-	-
aa\Z	b\nac	n	-	-
aa\z	b\nac	n	-	-
aa$	b\nac	n	-	-
'aa\Z'm	ac\nb\n	n	-	-
'aa\z'm	ac\nb\n	n	-	-
'aa$'m	ac\nb\n	n	-	-
'aa\Z'm	b\nac\n	n	-	-
'aa\z'm	b\nac\n	n	-	-
'aa$'m	b\nac\n	n	-	-
'aa\Z'm	b\nac	n	-	-
'aa\z'm	b\nac	n	-	-
'aa$'m	b\nac	n	-	-
aa\Z	ca\nb\n	n	-	-
aa\z	ca\nb\n	n	-	-
aa$	ca\nb\n	n	-	-
aa\Z	b\nca\n	n	-	-
aa\z	b\nca\n	n	-	-
aa$	b\nca\n	n	-	-
aa\Z	b\nca	n	-	-
aa\z	b\nca	n	-	-
aa$	b\nca	n	-	-
'aa\Z'm	ca\nb\n	n	-	-
'aa\z'm	ca\nb\n	n	-	-
'aa$'m	ca\nb\n	n	-	-
'aa\Z'm	b\nca\n	n	-	-
'aa\z'm	b\nca\n	n	-	-
'aa$'m	b\nca\n	n	-	-
'aa\Z'm	b\nca	n	-	-
'aa\z'm	b\nca	n	-	-
'aa$'m	b\nca	n	-	-
ab\Z	ab\nb\n	n	-	-
ab\z	ab\nb\n	n	-	-
ab$	ab\nb\n	n	-	-
ab\Z	b\nab\n	y	$-[0]	2
ab\z	b\nab\n	n	-	-
ab$	b\nab\n	y	$-[0]	2
ab\Z	b\nab	y	$-[0]	2
ab\z	b\nab	y	$-[0]	2
ab$	b\nab	y	$-[0]	2
'ab\Z'm	ab\nb\n	n	-	-
'ab\z'm	ab\nb\n	n	-	-
'ab$'m	ab\nb\n	y	$-[0]	0
'ab\Z'm	b\nab\n	y	$-[0]	2
'ab\z'm	b\nab\n	n	-	-
'ab$'m	b\nab\n	y	$-[0]	2
'ab\Z'm	b\nab	y	$-[0]	2
'ab\z'm	b\nab	y	$-[0]	2
'ab$'m	b\nab	y	$-[0]	2
ab\Z	ac\nb\n	n	-	-
ab\z	ac\nb\n	n	-	-
ab$	ac\nb\n	n	-	-
ab\Z	b\nac\n	n	-	-
ab\z	b\nac\n	n	-	-
ab$	b\nac\n	n	-	-
ab\Z	b\nac	n	-	-
ab\z	b\nac	n	-	-
ab$	b\nac	n	-	-
'ab\Z'm	ac\nb\n	n	-	-
'ab\z'm	ac\nb\n	n	-	-
'ab$'m	ac\nb\n	n	-	-
'ab\Z'm	b\nac\n	n	-	-
'ab\z'm	b\nac\n	n	-	-
'ab$'m	b\nac\n	n	-	-
'ab\Z'm	b\nac	n	-	-
'ab\z'm	b\nac	n	-	-
'ab$'m	b\nac	n	-	-
ab\Z	ca\nb\n	n	-	-
ab\z	ca\nb\n	n	-	-
ab$	ca\nb\n	n	-	-
ab\Z	b\nca\n	n	-	-
ab\z	b\nca\n	n	-	-
ab$	b\nca\n	n	-	-
ab\Z	b\nca	n	-	-
ab\z	b\nca	n	-	-
ab$	b\nca	n	-	-
'ab\Z'm	ca\nb\n	n	-	-
'ab\z'm	ca\nb\n	n	-	-
'ab$'m	ca\nb\n	n	-	-
'ab\Z'm	b\nca\n	n	-	-
'ab\z'm	b\nca\n	n	-	-
'ab$'m	b\nca\n	n	-	-
'ab\Z'm	b\nca	n	-	-
'ab\z'm	b\nca	n	-	-
'ab$'m	b\nca	n	-	-
abb\Z	abb\nb\n	n	-	-
abb\z	abb\nb\n	n	-	-
abb$	abb\nb\n	n	-	-
abb\Z	b\nabb\n	y	$-[0]	2
abb\z	b\nabb\n	n	-	-
abb$	b\nabb\n	y	$-[0]	2
abb\Z	b\nabb	y	$-[0]	2
abb\z	b\nabb	y	$-[0]	2
abb$	b\nabb	y	$-[0]	2
'abb\Z'm	abb\nb\n	n	-	-
'abb\z'm	abb\nb\n	n	-	-
'abb$'m	abb\nb\n	y	$-[0]	0
'abb\Z'm	b\nabb\n	y	$-[0]	2
'abb\z'm	b\nabb\n	n	-	-
'abb$'m	b\nabb\n	y	$-[0]	2
'abb\Z'm	b\nabb	y	$-[0]	2
'abb\z'm	b\nabb	y	$-[0]	2
'abb$'m	b\nabb	y	$-[0]	2
abb\Z	ac\nb\n	n	-	-
abb\z	ac\nb\n	n	-	-
abb$	ac\nb\n	n	-	-
abb\Z	b\nac\n	n	-	-
abb\z	b\nac\n	n	-	-
abb$	b\nac\n	n	-	-
abb\Z	b\nac	n	-	-
abb\z	b\nac	n	-	-
abb$	b\nac	n	-	-
'abb\Z'm	ac\nb\n	n	-	-
'abb\z'm	ac\nb\n	n	-	-
'abb$'m	ac\nb\n	n	-	-
'abb\Z'm	b\nac\n	n	-	-
'abb\z'm	b\nac\n	n	-	-
'abb$'m	b\nac\n	n	-	-
'abb\Z'm	b\nac	n	-	-
'abb\z'm	b\nac	n	-	-
'abb$'m	b\nac	n	-	-
abb\Z	ca\nb\n	n	-	-
abb\z	ca\nb\n	n	-	-
abb$	ca\nb\n	n	-	-
abb\Z	b\nca\n	n	-	-
abb\z	b\nca\n	n	-	-
abb$	b\nca\n	n	-	-
abb\Z	b\nca	n	-	-
abb\z	b\nca	n	-	-
abb$	b\nca	n	-	-
'abb\Z'm	ca\nb\n	n	-	-
'abb\z'm	ca\nb\n	n	-	-
'abb$'m	ca\nb\n	n	-	-
'abb\Z'm	b\nca\n	n	-	-
'abb\z'm	b\nca\n	n	-	-
'abb$'m	b\nca\n	n	-	-
'abb\Z'm	b\nca	n	-	-
'abb\z'm	b\nca	n	-	-
'abb$'m	b\nca	n	-	-
(^|x)(c)	ca	y	$2	c
a*abc?xyz+pqr{3}ab{2,}xy{4,5}pq{0,6}AB{0,}zz	x	n	-	-
a(?{$a=2;$b=3;($b)=$a})b	yabz	y	$b	2
round\(((?>[^()]+))\)	_I(round(xs * sz),1)	y	$1	xs * sz
'((?x:.) )'	x 	y	$1-	x -
'((?-x:.) )'x	x 	y	$1-	x-
foo.bart	foo.bart	y	-	-
'^d[x][x][x]'m	abcd\ndxxx	y	-	-
.X(.+)+X	bbbbXcXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	y	-	-
.X(.+)+XX	bbbbXcXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	y	-	-
.XX(.+)+X	bbbbXXcXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	y	-	-
.X(.+)+X	bbbbXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	n	-	-
.X(.+)+XX	bbbbXXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	n	-	-
.XX(.+)+X	bbbbXXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	n	-	-
.X(.+)+[X]	bbbbXcXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	y	-	-
.X(.+)+[X][X]	bbbbXcXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	y	-	-
.XX(.+)+[X]	bbbbXXcXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	y	-	-
.X(.+)+[X]	bbbbXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	n	-	-
.X(.+)+[X][X]	bbbbXXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	n	-	-
.XX(.+)+[X]	bbbbXXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	n	-	-
.[X](.+)+[X]	bbbbXcXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	y	-	-
.[X](.+)+[X][X]	bbbbXcXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	y	-	-
.[X][X](.+)+[X]	bbbbXXcXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	y	-	-
.[X](.+)+[X]	bbbbXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	n	-	-
.[X](.+)+[X][X]	bbbbXXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	n	-	-
.[X][X](.+)+[X]	bbbbXXXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	n	-	-
tt+$	xxxtt	y	-	-
([a-\d]+)	za-9z	y	$1	a-9
([\d-z]+)	a0-za	y	$1	0-z
([\d-\s]+)	a0- z	y	$1	0- 
([a-[:digit:]]+)	za-9z	y	$1	a-9
([[:digit:]-z]+)	=0-z=	y	$1	0-z
([[:digit:]-[:alpha:]]+)	=0-z=	y	$1	0-z
\GX.*X	aaaXbX	n	-	-
(\d+\.\d+)	3.1415926	y	$1	3.1415926
(\ba.{0,10}br)	have a web browser	y	$1	a web br
'\.c(pp|xx|c)?$'i	Changes	n	-	-
'\.c(pp|xx|c)?$'i	IO.c	y	-	-
'(\.c(pp|xx|c)?$)'i	IO.c	y	$1	.c
^([a-z]:)	C:/	n	-	-
'^\S\s+aa$'m	\nx aa	y	-	-
(^|a)b	ab	y	-	-
^([ab]*?)(b)?(c)$	abac	y	-$2-	--
(\w)?(abc)\1b	abcab	n	-	-
^(?:.,){2}c	a,b,c	y	-	-
^(.,){2}c	a,b,c	y	$1	b,
^(?:[^,]*,){2}c	a,b,c	y	-	-
^([^,]*,){2}c	a,b,c	y	$1	b,
^([^,]*,){3}d	aaa,b,c,d	y	$1	c,
^([^,]*,){3,}d	aaa,b,c,d	y	$1	c,
^([^,]*,){0,3}d	aaa,b,c,d	y	$1	c,
^([^,]{1,3},){3}d	aaa,b,c,d	y	$1	c,
^([^,]{1,3},){3,}d	aaa,b,c,d	y	$1	c,
^([^,]{1,3},){0,3}d	aaa,b,c,d	y	$1	c,
^([^,]{1,},){3}d	aaa,b,c,d	y	$1	c,
^([^,]{1,},){3,}d	aaa,b,c,d	y	$1	c,
^([^,]{1,},){0,3}d	aaa,b,c,d	y	$1	c,
^([^,]{0,3},){3}d	aaa,b,c,d	y	$1	c,
^([^,]{0,3},){3,}d	aaa,b,c,d	y	$1	c,
^([^,]{0,3},){0,3}d	aaa,b,c,d	y	$1	c,
(?i)		y	-	-
'(?!\A)x'm	a\nxb\n	y	-	-
^(a(b)?)+$	aba	y	-$1-$2-	-a--
^(aa(bb)?)+$	aabbaa	y	-$1-$2-	-aa--
'^.{9}abc.*\n'm	123\nabcabcabcabc\n	y	-	-
^(a)?a$	a	y	-$1-	--
^(a)?(?(1)a|b)+$	a	n	-	-
^(a\1?)(a\1?)(a\2?)(a\3?)$	aaaaaa	y	$1,$2,$3,$4	a,aa,a,aa
^(a\1?){4}$	aaaaaa	y	$1	aa
^(0+)?(?:x(1))?	x1	y	-	-
^([0-9a-fA-F]+)(?:x([0-9a-fA-F]+)?)(?:x([0-9a-fA-F]+))?	012cxx0190	y	-	-
^(b+?|a){1,2}c	bbbac	y	$1	a
^(b+?|a){1,2}c	bbbbac	y	$1	a
\((\w\. \w+)\)	cd. (A. Tw)	y	-$1-	-A. Tw-
((?:aaaa|bbbb)cccc)?	aaaacccc	y	-	-
((?:aaaa|bbbb)cccc)?	bbbbcccc	y	-	-
(a)?(a)+	a	y	$1:$2	:a	-
(ab)?(ab)+	ab	y	$1:$2	:ab	-
(abc)?(abc)+	abc	y	$1:$2	:abc	-
'b\s^'m	a\nb\n	n	-	-
\ba	a	y	-	-
^(a(??{"(?!)"})|(a)(?{1}))b	ab	y	$2	a	# [ID 20010811.006]
ab(?i)cd	AbCd	n	-	-	# [ID 20010809.023]
ab(?i)cd	abCd	y	-	-
(A|B)*(?(1)(CD)|(CD))	CD	y	$2-$3	-CD
(A|B)*(?(1)(CD)|(CD))	ABCD	y	$2-$3	CD-
(A|B)*?(?(1)(CD)|(CD))	CD	y	$2-$3	-CD	# [ID 20010803.016]
(A|B)*?(?(1)(CD)|(CD))	ABCD	y	$2-$3	CD-
'^(o)(?!.*\1)'i	Oo	n	-	-
(.*)\d+\1	abc12bc	y	$1	bc
(?m:(foo\s*$))	foo\n bar	y	$1	foo
(.*)c	abcd	y	$1	ab
(.*)(?=c)	abcd	y	$1	ab
(.*)(?=c)c	abcd	yB	$1	ab
(.*)(?=b|c)	abcd	y	$1	ab
(.*)(?=b|c)c	abcd	y	$1	ab
(.*)(?=c|b)	abcd	y	$1	ab
(.*)(?=c|b)c	abcd	y	$1	ab
(.*)(?=[bc])	abcd	y	$1	ab
(.*)(?=[bc])c	abcd	yB	$1	ab
(.*)(?<=b)	abcd	y	$1	ab
(.*)(?<=b)c	abcd	y	$1	ab
(.*)(?<=b|c)	abcd	y	$1	abc
(.*)(?<=b|c)c	abcd	y	$1	ab
(.*)(?<=c|b)	abcd	y	$1	abc
(.*)(?<=c|b)c	abcd	y	$1	ab
(.*)(?<=[bc])	abcd	y	$1	abc
(.*)(?<=[bc])c	abcd	y	$1	ab
(.*?)c	abcd	y	$1	ab
(.*?)(?=c)	abcd	y	$1	ab
(.*?)(?=c)c	abcd	yB	$1	ab
(.*?)(?=b|c)	abcd	y	$1	a
(.*?)(?=b|c)c	abcd	y	$1	ab
(.*?)(?=c|b)	abcd	y	$1	a
(.*?)(?=c|b)c	abcd	y	$1	ab
(.*?)(?=[bc])	abcd	y	$1	a
(.*?)(?=[bc])c	abcd	yB	$1	ab
(.*?)(?<=b)	abcd	y	$1	ab
(.*?)(?<=b)c	abcd	y	$1	ab
(.*?)(?<=b|c)	abcd	y	$1	ab
(.*?)(?<=b|c)c	abcd	y	$1	ab
(.*?)(?<=c|b)	abcd	y	$1	ab
(.*?)(?<=c|b)c	abcd	y	$1	ab
(.*?)(?<=[bc])	abcd	y	$1	ab
(.*?)(?<=[bc])c	abcd	y	$1	ab
2(]*)?$\1	2	y	$&	2
(??{})	x	y	-	-
a(b)??	abc	y	<$1>	<>	# undef [perl #16773]
(\d{1,3}\.){3,}	128.134.142.8	y	<$1>	<142.>	# [perl #18019]
^.{3,4}(.+)\1\z	foobarbar	y	$1	bar	# 16 tests for [perl #23171]
^(?:f|o|b){3,4}(.+)\1\z	foobarbar	y	$1	bar
^.{3,4}((?:b|a|r)+)\1\z	foobarbar	y	$1	bar
^(?:f|o|b){3,4}((?:b|a|r)+)\1\z	foobarbar	y	$1	bar
^.{3,4}(.+?)\1\z	foobarbar	y	$1	bar
^(?:f|o|b){3,4}(.+?)\1\z	foobarbar	y	$1	bar
^.{3,4}((?:b|a|r)+?)\1\z	foobarbar	y	$1	bar
^(?:f|o|b){3,4}((?:b|a|r)+?)\1\z	foobarbar	y	$1	bar
^.{2,3}?(.+)\1\z	foobarbar	y	$1	bar
^(?:f|o|b){2,3}?(.+)\1\z	foobarbar	y	$1	bar
^.{2,3}?((?:b|a|r)+)\1\z	foobarbar	y	$1	bar
^(?:f|o|b){2,3}?((?:b|a|r)+)\1\z	foobarbar	y	$1	bar
^.{2,3}?(.+?)\1\z	foobarbar	y	$1	bar
^(?:f|o|b){2,3}?(.+?)\1\z	foobarbar	y	$1	bar
^.{2,3}?((?:b|a|r)+?)\1\z	foobarbar	y	$1	bar
^(?:f|o|b){2,3}?((?:b|a|r)+?)\1\z	foobarbar	y	$1	bar
.*a(?!(b|cd)*e).*f	......abef	n	-	-	# [perl #23030]
x(?#	x	c	-	Sequence (?#... not terminated
:x(?#:	x	c	-	Sequence (?#... not terminated
(WORDS|WORD)S	WORDS	y	$1	WORD
(X.|WORDS|X.|WORD)S	WORDS	y	$1	WORD
(WORDS|WORLD|WORD)S	WORDS	y	$1	WORD
(X.|WORDS|WORD|Y.)S	WORDS	y	$1	WORD
(foo|fool|x.|money|parted)$	fool	y	$1	fool
(x.|foo|fool|x.|money|parted|y.)$	fool	y	$1	fool
(foo|fool|money|parted)$	fool	y	$1	fool
(foo|fool|x.|money|parted)$	fools	n	-	-
(x.|foo|fool|x.|money|parted|y.)$	fools	n	-	-
(foo|fool|money|parted)$	fools	n	-	-
(a|aa|aaa|aaaa|aaaaa|aaaaaa)(b|c)	aaaaaaaaaaaaaaab	y	$1$2	aaaaaab
(a|aa|aaa|aaaa|aaaaa|aaaaaa)(??{$1&&""})(b|c)	aaaaaaaaaaaaaaab	y	$1$2	aaaaaab
(a|aa|aaa|aaaa|aaaaa|aaaaaa)(??{$1&&"foo"})(b|c)	aaaaaaaaaaaaaaab	n	-	-
^(a*?)(?!(aa|aaaa)*$)	aaaaaaaaaaaaaaaaaaaa	y	$1	a	# [perl #34195]
^(a*?)(?!(aa|aaaa)*$)(?=a\z)	aaaaaaaa	y	$1	aaaaaaa
^(.)\s+.$(?(1))	A B	y	$1	A	# [perl #37688]

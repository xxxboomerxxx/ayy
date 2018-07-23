#!/usr/bin/perl
use strict;
use v5.010;
use List::Util qw ( shuffle );

my $current = "";
my @items = qx % ls | grep -i -e '\\.png\$' -e '\\.jpg\$' -e '\\.gif\$' -e '\\.webm\$' %;
chomp @items;
@items = grep defined, @items;
@items = shuffle @items;

while(defined ($current = shift @items)) {
    my ($ext) = $current =~ /\.(gif|webm|png|jpg|jpeg)$/;
    my $time = qx % date +\%s\%9N %;
    chomp($time);
    my $new_file = $time . "." . $ext;
    qx % mv -f "$current" "$new_file" %;
    @items = shuffle @items;
}

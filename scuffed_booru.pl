#!/usr/bin/perl
use v5.010;

# generate json list of all files we want to display
# default only .gif, .png, .jpg, .jpeg
@file_list = qx % ls -l | grep -E '\\.(jp[e]?g|png|gif)\$' | sed 's/^.* \\([^\\ ]*\\)/\\1/g' % ;
chomp @file_list;
# need full path to imagez
$path = qx % pwd %;
chomp $path;
@json = map "\"$path/$_\",", @file_list;
substr (@json[-1], -1) = "";
@json[0] = "[" . @json[0];
@json[-1] = @json[-1] . "]";

#generate a big guy
$bigguy = "";
for (@json) {$bigguy .= "$_ ";}


# html page we be using
$html = qq(<!DOCTYPE html><html><head><title>Scuffed Booru</title><style>body {margin:0;padding:0;background:black;}img {max-height:95vh;max-width:100%;display:block;margin:0 auto;}</style></head><body onload="change(randy(img_list))"><img id="nigger" src="" /><script>document.onkeydown = checkem;let img_list = LONG_UNIQUE_STRING_TBH;function randy(list) {    return list[Math.floor(Math.random()*list.length)];}function change(sauce) {    var x = document.getElementById("nigger");    x.src = sauce;}function checkem(e) {    e = e || window.event;    x = e.keyCode;    if (x == "38" || x == "40" || x == "37" || x == "39") {change(randy(img_list));}}</script></body></html>);

$html =~ s/\QLONG_UNIQUE_STRING_TBH\E/$bigguy/g;

# create unique name tbh
$filename = qx % date +\%s\%9N %;
chomp $filename;

open($file, '>', "/tmp/sb$filename.html") or die "Fix ur permissions faggot";
print $file "$html\n";
close $file;

print "Open this file in your web browser:\n\t\t---->  /tmp/sb$filename.html\n";

# uncomment to open with chromium automatically
qx % chromium-browser /tmp/sb$filename.html  %;

#!/usr/bin/perl

# Ian McDougall
# August 2024
# generating cards by populating a template from a spreadhseet

use strict;
use warnings;
use 5.36.0;

my $template_path = './template.svg';
my $template_handle;

open (my $template, "<", 'template.svg') or die "Can't open < template.svg: $!";
open (my $sheet, "<", 'minideck.csv') or die "Can't open < minideck.csv: $!";

while (<$sheet>)
{
	chomp;
	my ($seq, $type, $pips, $domain, $domColor, $kingdom, $roll, $illo, $color, $fill, $shape, $suit, $rank, $position, $topName, $topIcon, $topInset, $botName, $botIcon, $botInset) = split /,/;
	open (my $outfile, ">", "$seq.svg") or die "Can't open > $seq.csv: $!";
	while(<$template>)
	{
		s/&lt;0&gt;/$seq/;
		s/Normal/$type/;
		s/piptext/$pips/;
		s/\.\.\/domain\/land\.svg/$domain/;
		s/#ff00ff/$domColor/g;
		s/\.\.\/kingdom\/triple-claws-lorc\.svg/$kingdom/;
		s/⚃/$roll/;
		s/\.\.\/illo\/Caribou\.png/$illo/;
		s/#654321/$color/;
		s/#123456/$fill/;
		s/♣/$suit/;
		s/&lt;J&gt;/$rank/;
		s/LF/$position/;
		s/Rider/$topName/;
		s/\.\.\/lenormand\/cavalry-delapoite\.svg/$topIcon/;
		s/\.\.\/german\/hart-09\.svg/$topInset/;
		s/Snake/$botName/;
		s/\.\.\/lenormand\/snake-spiral-delapoite\.svg/$botIcon/;
		s/\.\.\/german\/eichel-12_ober\.svg/$botInset/;
		if ($shape eq 'kiki')
		{
			s/ry="\d+.\d+"//g;
		}
		if ($fill eq '#FFFFFF')
		{
			s/#fedcba/$color/g;
		} else
		{
			s/#fedcba/#FFFFFF/;
		}
		print $outfile "$_";
	}
	seek $template, 0, 0;
	close $outfile;
}
close $sheet;
close $template;

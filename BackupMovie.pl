#!/usr/bin/perl

sub getMovies {
	local $| = 1;
	my $fromDir = shift;
	my $totalMovies = `ls -1 "$fromDir" | wc -l`;
	$totalMovies =~ /(\d+)/;
	print "Processing $1 movies...\n";
	my @moviesAtDir = `./GetMovies.sh "$fromDir"`;
	my @movies = ();
	foreach $movie (@moviesAtDir) {
		$movie =~ /.*\/(.*)/;
		$movie = $1;
		#$movie =~ s/_/:/;
		push @movies, $movie 
	}
	return @movies;
}

$iTunesDir="/Volumes/My Book/Shared iTunes/iTunes Media/Movies";
$backupDir="/Volumes/Public/Shared Videos/Movies";

@movies = getMovies "$iTunesDir";
print $_ foreach (@movies);

#@movies = getMovies "$backupDir";
#print $_ foreach (@movies);
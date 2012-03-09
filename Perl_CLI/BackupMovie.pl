#!/usr/bin/perl

sub getMoviesFromDir {
	my $fromDir = shift;
	
	my @moviesAtDir = `ls "$fromDir"/*/*`;

	my @movies = ();
	foreach $movie (@moviesAtDir) {
		$movie =~ /.*\/(.*)/;
		$movie = $1;
		#$movie =~ s/_/:/;
		push @movies, $movie 
	}
	#print "Done\n";
	return @movies;
}

sub getMoviesDB {
	my ($originalDir, $backupDir) = @_;
	
	my %moviesDB = ();

	my @movies = getMoviesFromDir "$originalDir";
	push( @{ $moviesDB{$_} }, (1, 0)) foreach (@movies);
	#print "$_\n" foreach (@movies);

	@movies = getMoviesFromDir "$backupDir";
	foreach (@movies) {
		if (exists $moviesDB{$_}) {
			$moviesDB{$_}->[1] = 1;
		} else {
			push( @{ $moviesDB{$_} }, (0, 1)); 
		}
	}
	
	return %moviesDB;
}

sub getMoviesFromDB {
	my ($v1, $v2, %moviesDB) = @_;
	my @moviesFromDB = ();
	
	foreach ( keys %moviesDB ) { 
		push( @moviesFromDB, $_ ) if ($moviesDB{$_}->[0] == $v1 and $moviesDB{$_}->[1] == $v2) 
	} 
	
	return @moviesFromDB;
}

sub getMoviesToBackup {	return getMoviesFromDB(1,0,@_); }
sub getMoviesFromBackup{ return getMoviesFromDB(0,1,@_); }

my $iTunesDir="/Volumes/My Book/Shared iTunes/iTunes Media/Movies";
my $backupDir="/Volumes/Public/Shared Videos/Movies";

my %moviesDB = getMoviesDB($iTunesDir, $backupDir);
my @moviesToBackup = getMoviesToBackup(%moviesDB);
my @moviesFromBackup = getMoviesFromBackup(%moviesDB);

print "Movies to Backup:\n";
print "$_\n" for (@moviesToBackup);

print "Movies from Backup:\n";
print "$_\n" for (@moviesFromBackup);
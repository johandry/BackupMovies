package BackupMedia;

use strict;
use Exporter;

our (@ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS, $VERSION);

$VERSION = 1.00;
@ISA = qw(Exporter);
@EXPORT = qw($VERBOSE &getMoviesDB &getTVShowsDB &getToBackup &getFromBackup);
@EXPORT_OK = qw(&getMoviesFromDir &getTVShowsFromDir);

my $VERBOSE;

sub getMoviesFromDir {
	my $fromDir = shift;
	my ($movie, @movies);
	
	my @moviesAtDir = `ls "$fromDir"/*/*`;

	@movies = ();
	foreach $movie (@moviesAtDir) {
		$movie =~ /.*\/(.*)/;
		$movie = $1;
		#$movie =~ s/_/:/;
		push @movies, $movie 
	}
	return @movies;
}

sub getTVShowsFromDir {
	my $fromDir = shift;
	my ($tvShow, @tvShows);
	
	my @tvShowsAtDir = `ls "$fromDir"/*/*/*`;

	@tvShows = ();
	foreach $tvShow (@tvShowsAtDir) {
		$tvShow =~ /.*\/(.*\/.*\/.*)/;
		$tvShow = $1;
		#$tvShow =~ s/_/:/;
		push @tvShows, $tvShow 
	}
	return @tvShows;
}

sub getMediaDB {
	my ($areMovies, $originalDir, $backupDir) = @_;
	
	my %DB = ();

	my @files = $areMovies ? getMoviesFromDir "$originalDir" : getTVShowsFromDir "$originalDir";
	push( @{ $DB{$_} }, (1, 0)) foreach (@files);
	#print "$_\n" foreach (@files);

	@files = $areMovies ? getMoviesFromDir "$backupDir" : getTVShowsFromDir "$backupDir";
	foreach (@files) {
		if (exists $DB{$_}) {
			$DB{$_}->[1] = 1;
		} else {
			push( @{ $DB{$_} }, (0, 1)); 
		}
	}
	
	return %DB;
}

sub getMoviesDB { return getMediaDB(1,@_[0],@_[1]) }
sub getTVShowsDB { return getMediaDB(0,@_[0],@_[1]) }

sub getFromDB {
	my ($v1, $v2, %moviesDB) = @_;
	my @moviesFromDB = ();
	
	foreach ( keys %moviesDB ) { 
		push( @moviesFromDB, $_ ) if ($moviesDB{$_}->[0] == $v1 and $moviesDB{$_}->[1] == $v2) 
	} 
	
	return @moviesFromDB;
}

sub getToBackup { return getFromDB(1,0,@_) }
sub getFromBackup { return getFromDB(0,1,@_) }

1;
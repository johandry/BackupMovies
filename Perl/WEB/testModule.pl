#!/usr/bin/perl

use BackupMedia;

sub testAll {
	my ($areMovies, $iTunesDir, $backupDir) = @_;
	
	my %DB = $areMovies ? BackupMedia::getMoviesDB($iTunesDir, $backupDir) : BackupMedia::getTVShowsDB($iTunesDir, $backupDir);
	my @toBackup = BackupMedia::getToBackup(%DB);
	my @fromBackup = BackupMedia::getFromBackup(%DB);

	my $title = $areMovies ? "Movies" : "TVShows";
	if (@toBackup) {
		print "$title to Backup:\n";
		print "$_\n" for (@toBackup);
	}
	if (@fromBackup) {
		print "$title from Backup:\n";
		print "$_\n" for (@fromBackup);
	}
	
}

testAll(1, "/Volumes/My Book/Shared iTunes/iTunes Media/Movies", "/Volumes/Public/Shared Videos/Movies");
testAll(0, "/Volumes/My Book/Shared iTunes/iTunes Media/TV Shows", "/Volumes/Public/Shared Videos/TV Shows");
!#/usr/bin/env perluse warnings; parent3 - child7=39~2 
use strict; 
use Bean::DB qw(get_dbi_alt);
my $csv_dir = '/tmp'; 
my $csv_filename = 'gradleaders_feed_list.csv'; 
my $csv_path = "$csv_dir" . '/' . "$csv_filename"; # this is concatinating the given directory and filename to create a relative path to the file we want to open
# File Handler
open($csv, '>' . $csv_path) or die "Could not open file $csv_path $!\n";
# DB Handler
my $dbh = get_dbi('reports');
print $csv "\nDEBUG - Starting Report.\n";
# below is making a query from the DB to return values 'id,name,nice_name, and url' from the table 'board' where the url field contains 'mbafocus' anywhere in the url or exactly 'myinterfase'  
my $boards_query = $dbh->prepare( 
	"SELECT id, name, nice_name, url FROM board WHERE url LIKE '\%mbafocus\%' OR url LIKE 'myinterfase'" # I would point out the spelling of myinterfase is wierd
)
# Error handling would be good on line below but the way its written is not neccesarily wrong.
$boards_query->execute();
print $csv 'Board ID,Name,Nice Name,URL\n'; # adds a header to the file
# Adding the values of the hash from the DB query to the file in the same order that we listed in the header
while (my %board = $boards_query->fetchhash()) {
	print $csv "$board{'id'},$board{'name'},$board{'nice_name'},$board{'url'}\n";  
}
print $csv "DEBUG - Finished Report.\n";
# Added closing commands to the DB and file I/O
$boards_query->finish();
close( $csv );
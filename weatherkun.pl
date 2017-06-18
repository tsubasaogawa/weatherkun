#!/usr/bin/perl

use strict;
use warnings;
use LWP::UserAgent;
use JSON;
use Encode;
use Data::Dumper;

require './wkcommon.pl';
require './get_weather.pl';

my @coordinates = (139, 35);
my $date = '201706182200';
my $yahoo_app_id = WKCommon::get_yahoo_app_id();

my $request = GetWeather::set_request(@coordinates, $yahoo_app_id, $date);
my $response = GetWeather::get_response($request);

if($response->is_success) {
  my $json = JSON->new->decode($response->content);
  print $json->{ResultInfo}, "\n";
}
else {
  print STDERR "response error: ", $response->status_line, "\n";
}

1;


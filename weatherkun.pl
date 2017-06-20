#!/usr/bin/perl

use strict;
use warnings;
use LWP::UserAgent;
use JSON;
use Encode;
use Data::Dumper;
use Date::Simple;

require './wkcommon.pl';
require './get_weather.pl';

my @coordinates = (139, 35);
my $now = Date::Simple->new();
my $date = $now->format('%Y%m%d%H%M');
my $yahoo_app_id = WKCommon::get_yahoo_app_id();

sub forecast_raining {
  my @rainfalls = @_;
  my $raining_flag = undef;

  # processing

  return $raining_flag;
}

my $request = GetWeather::get_request_instance(@coordinates, $yahoo_app_id, $date);
my $response = GetWeather::get_response($request);

if($response->is_success) {
  my $json = JSON->new->decode($response->content);
  print $json->{ResultInfo}, "\n";
}
else {
  print STDERR "response error: ", $response->status_line, "\n";
}

1;


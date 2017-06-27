#!/usr/bin/perl

use strict;
use warnings;
use utf8;
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
my $raining_threshold = 0.1;

sub will_it_rain {
  my @rainfalls = @_;
  my $raining_flag = undef;

  # processing

  return $raining_flag;
}

sub report_forecast {
}

# main

# get weather data
my $request = GetWeather::create_request_instance(@coordinates, $yahoo_app_id, $date);
my $response = GetWeather::get_response($request);

if(! $response->is_success) {
  die "response error: ", $response->status_line, "\n";
}

my $json = JSON->new->decode($response->content);
# a record of @weather has three keys: 'Type', 'Rainfall' and 'Date'.
my $weather = $json->{Feature}[0]->{Property}->{WeatherList}->{Weather};

# pick up values of rainfall
my @rainfalls = ();
foreach my $rainfall (@{$weather}) {
  print Dumper $rainfall->{Rainfall};
  # push(@rainfalls, $$rainfall{'Rainfall'});
}

# processing json

# if(will_it_rain()) {
#   my $report_ret = report_forecast();
#   die 'report_forecast(): failed.' if(! $report_ret);
# }

1;


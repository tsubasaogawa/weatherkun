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

my @coordinates = (35.681167, 139.767052);
my $now = Date::Simple->new();
my $date = $now->format('%Y%m%d%H%M');
my $app_id = WKCommon::app_id();
my $raining_threshold = 0.1;

sub get_rain_probability {
  my $request = GetWeather::create_request_instance(@coordinates, $app_id);
  my $response = GetWeather::get_response($request);

  if(! $response->is_success) {
    die "response error: ", $response->status_line, "\n";
  }

  my $json = JSON->new->decode($response->content);
  my $rain_prob = $json->{hourly}->{data}[0]->{precipProbability};

  return $rain_prob;
}

sub will_it_rain {
  my $rain_prob = &get_rain_probability();
  my $raining_flag = 0;

  $raining_flag = 1 if($rain_prob > $raining_threshold);

  return $raining_flag;
}

sub report_forecast {
  print "Today it will rain.\n";
  return 0;
}

# main

if(&will_it_rain()) {
  my $report_ret = report_forecast();
  die 'report_forecast(): failed.' if($report_ret != 0);
}

1;


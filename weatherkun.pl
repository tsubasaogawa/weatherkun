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

sub will_it_rain {
  my @rainfalls = @_;
  my $raining_flag = undef;

  # processing

  return $raining_flag;
}

sub report_forecast {
}

my $request = GetWeather::create_request_instance(@coordinates, $yahoo_app_id, $date);
my $response = GetWeather::get_response($request);

if(! $response->is_success) {
  die "response error: ", $response->status_line, "\n";
}

my $json = JSON->new->decode($response->content);
# print $json->{ResultInfo}, "\n";

# processing json

if(will_it_rain()) {
  my $report_ret = report_forecast();
  die 'report_forecast(): failed.' if(! $report_ret);
}

1;


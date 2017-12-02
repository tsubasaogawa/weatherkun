#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use LWP::UserAgent;
use JSON;
use Encode;
use Data::Dumper;

require './wkcommon.pl';
require './get_weather.pl';

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);  
my $date = sprintf("%04d/%02d/%02d %02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min);  

sub get_rain_probability {
  my $request = GetWeather::create_request_instance(WKCommon::coordinates(), WKCommon::app_id());
  my $response = GetWeather::get_response($request);

  if(! $response->is_success) {
    die "response error: ", $response->status_line, "\n";
  }

  my $json = JSON->new->decode($response->content);
  my $rain_prob = $json->{hourly}->{data}[0]->{precipProbability};

  printf STDERR "rain_prob: $rain_prob\n";
  return $rain_prob;
}

sub will_it_rain {
  my $rain_prob = &get_rain_probability();
  my $raining_flag = 0;

  $raining_flag = 1 if($rain_prob > WKCommon::raining_threshold());

  return $raining_flag;
}

sub report_forecast {
  WKCommon::trigger_function();
  return 0;
}

# main

system("echo '$date started' >> ./weatherkun.log");
if(&will_it_rain()) {
  my $report_ret = report_forecast();
  die 'report_forecast(): failed.' if($report_ret != 0);
}

1;


#!/usr/bin/perl

use strict;
use warnings;
use LWP::UserAgent;
use JSON;
use Encode;
use Data::Dumper;

require './common.pl';

my $api_uri = 'https://map.yahooapis.jp/weather/V1/place';
my @coordinates = (139, 35);
my $output = 'json';
my $date = '20170617230000';
my $yahoo_app_id = common::get_yahoo_app_id();

my $user_agent = LWP::UserAgent->new;
my $uri = "${api_uri}?coordinates=$coordinates[0],$coordinates[1]&appid=$yahoo_app_id&output=$output&date=$date";
my $request = HTTP::Request->new(GET => $uri);

$request->header("Content-Type" => "application/json");
my $response = $user_agent->request($request);

print Dumper $response;

if($response->is_success) {
  my $json = JSON->new->decode($response->content);
  print $json->{ResultInfo}, "\n";
}
else {
  print STDERR "response error: ", $response->status_line, "\n";
}

1;


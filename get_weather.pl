package GetWeather;

my $api_uri = 'https://map.yahooapis.jp/weather/V1/place';

sub set_request {
  my @coordinates = (shift, shift);
  my $appid = shift;
  my $date = shift;

  my $uri = "${api_uri}?coordinates=$coordinates[0],$coordinates[1]&appid=$appid&output=json&date=$date";
  my $request = HTTP::Request->new(GET => $uri);
  print "$uri\n";
  return $request;
}

sub get_response {
  $request = shift;

  $request->header("Content-Type" => "application/json");
  my $user_agent = LWP::UserAgent->new;
  my $response = $user_agent->request($request);

  return $response;
}

1;

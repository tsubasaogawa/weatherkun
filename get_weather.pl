package GetWeather;

my $api_uri = 'https://map.yahooapis.jp/weather/V1/place';
my $is_outputs_with_json = 1; # 0: XML, 1: JSON

sub create_request_instance {
  die 'create_request_instance(): argc is invalid.' if(@_ != 3);

  my($lat, $lon) = (shift, shift);
  my $appid = shift;

  my $output_type = $is_outputs_with_json ? 'json' : 'xml';
  # past=1 を省略すると降水強度実測値を得ることができない
  my $uri = "${api_uri}?coordinates=$lat,$lon&appid=$appid&output=$output_type&past=1";
  my $request = HTTP::Request->new(GET => $uri);
  return $request;
}

sub get_response {
  die 'get_response(): argc is invalid.' if(@_ != 1);

  $request = shift;

  $request->header("Content-Type" => "application/json");
  my $user_agent = LWP::UserAgent->new;
  my $response = $user_agent->request($request);

  return $response;
}

1;

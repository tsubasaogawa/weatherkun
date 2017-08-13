package GetWeather;

my $api_uri = 'https://api.darksky.net/forecast';

sub create_request_instance {
  die 'create_request_instance(): argc is invalid.' if(@_ != 3);

  my($lat, $lon) = (shift, shift);
  my $appid = shift;

  my $uri = "${api_uri}/$appid/$lat,$lon";
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

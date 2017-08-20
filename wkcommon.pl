package WKCommon;

sub app_id {
  return 'xxxxx';
}

sub coordinates {
  return (35.681167, 139.767052);
}

sub raining_threshold {
  return 0.5;
}

sub trigger_function {
  system("/usr/local/bin/AquesTalkPi 'Kasa ga iru yo' | aplay");
}

1;

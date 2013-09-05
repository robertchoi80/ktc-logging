# vim: ft=sh:
# only run on rhel
@test "should have logstash running" {
  [ "$(ps aux | grep logstash | grep -v grep)" ]
}

@test "should have apache running" {
  [ "$(ps aux | grep apache2 | grep -v grep)" ]
}

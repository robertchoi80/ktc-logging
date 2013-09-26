# vim: ft=sh:
# only run on rhel
@test "should have logstash running" {
  [ "$(ps aux | grep logstash | grep -v grep)" ]
}

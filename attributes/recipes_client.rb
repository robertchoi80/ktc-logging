#
# Run list requirements for monitoring client
#
default[:logging][:client_recipes] = []

default[:logging][:client_recipes].concat %w{
  ktc-rsyslog::default
}

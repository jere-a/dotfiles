TRAPINT() {
  # print "Caught SIGINT, aborting."
  return $(( 128 + $1 ))
}

class gnuradio::params {

  case $::osfamily {
    'RedHat': {
      $package = "gnuradio"

    }

    'Debian': {
      $package = "gnuradio"

    }

    default: {
      fail("Only Debian and Redhat OS distros are supported")
    }

}

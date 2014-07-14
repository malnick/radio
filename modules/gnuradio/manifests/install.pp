class gnuradio::install (
  $package = $::gnuradio::params::package,


){

  package{$package:
    ensure => present,
  }

}

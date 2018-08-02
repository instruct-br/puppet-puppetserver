class { 'puppetserver':
  version      => '5.3.4-1.el7',
  autosign     => false,
  enable_ca    => false,
  certname     => $trusted['certname'],
  ca_server    => 'masterca.puppet.dev',
  dns_altnames => [ 'puppet', 'puppetmaster' ],
  java_args    => '-Xms2g -Xmx2g -XX:MaxPermSize=256m',
}

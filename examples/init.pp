class { 'puppetserver':
  certname           => $trusted['certname'],
  version            => '5.3.1-1.el7',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2g -XX:MaxPermSize=256m',
  puppetdb           => true,
  puppetdb_server    => $trusted['certname'],
  puppetdb_port      => 8081,
  system_config_path => '/etc/sysconfig'
}

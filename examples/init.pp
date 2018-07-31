class { 'puppetserver':
  certname           => $trusted['certname'],
  version            => '5.3.4-1.el7',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2g -XX:MaxPermSize=256m',
  system_config_path => '/etc/sysconfig'
}

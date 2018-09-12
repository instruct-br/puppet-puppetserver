# docs
class puppetserver::config {

  augeas {'puppetserver_main_certname':
    context => '/files/etc/puppetlabs/puppet/puppet.conf',
    changes => [ "set main/certname ${puppetserver::certname}", ],
    notify  => Service['puppetserver']
  }

  augeas {'puppetserver_main_server':
    context => '/files/etc/puppetlabs/puppet/puppet.conf',
    changes => [ "set main/server ${puppetserver::main_server}", ],
    notify  => Service['puppetserver']
  }

  augeas {'puppetserver_main_ca_server':
      context => '/files/etc/puppetlabs/puppet/puppet.conf',
      changes => [ "set main/ca_server ${puppetserver::ca_server}", ],
      notify  => Service['puppetserver']
  }

  augeas {'puppetserver_master_dns_alt_names':
    context => '/files/etc/puppetlabs/puppet/puppet.conf',
    changes => [ "set master/dns_alt_names ${puppetserver::dns_alt_names}", ],
    notify  => Service['puppetserver']
  }

  if ! $puppetserver::enable_ca {

    augeas {'puppetserver_ca_config':
      context => '/files/etc/puppetlabs/puppet/puppet.conf',
      changes => [ 'set master/ca false', ],
      notify  => Service['puppetserver']
    }

  }

  augeas {'puppetserver_java_args':
    context => "${puppetserver::system_config_path}/puppetserver",
    changes => [ "set JAVA_ARGS '\"${puppetserver::java_args}\"'", ],
    notify  => Service['puppetserver']
  }

  file { 'puppetserver_ca_config':
    ensure  => file,
    path    => '/etc/puppetlabs/puppetserver/services.d/ca.cfg',
    content => epp('puppetserver/ca.cfg.epp'),
    notify  => Service['puppetserver']
  }

  if $puppetserver::autosign {
    augeas {'puppetserver_master_autosign':
      context => '/files/etc/puppetlabs/puppet/puppet.conf/master',
      changes => [ 'set autosign true', ],
      notify  => Service['puppetserver']
    }
  }
}

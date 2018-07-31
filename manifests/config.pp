# docs
class puppetserver::config {

  augeas {'main_certname':
    context => '/files/etc/puppetlabs/puppet/puppet.conf',
    changes => [ "set master/certname ${puppetserver::certname}", ],
  }

  augeas {'main_server':
    context => '/files/etc/puppetlabs/puppet/puppet.conf',
    changes => [ "set master/server ${puppetserver::certname}", ],
  }

  augeas {'java_args':
    context => "${puppetserver::system_config_path}/puppetserver",
    changes => [ "set JAVA_ARGS '\"${puppetserver::java_args}\"'", ],
    notify  => Service['puppetserver']
  }

  if $puppetserver::autosign {
    augeas {'master_autosign':
      context => '/files/etc/puppetlabs/puppet/puppet.conf/master',
      changes => [
        'set autosign true',
      ],
      notify  => Service['puppetserver']
    }
  }
}

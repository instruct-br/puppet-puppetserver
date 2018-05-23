# docs
class puppetserver::install {

  package { 'puppetserver':
    ensure => $puppetserver::version,
  }

  if $puppetserver::puppetdb {
    package { 'puppetdb-termini':
      ensure => $puppetserver::puppetdb_version,
    }
  }

}

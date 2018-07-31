# Puppetserver class.
#
# This is a class to install and manage Puppetserver:
#
# @example Declaring the class
#   include puppetserver
#
# @param [String] certname Certificate name for the server and agent
# @param [String] version Package version for puppetserver
# @param [Boolean] autosign Set the parameter autosign inside puppet.conf
# @param [String] java_args Set the JAVA_ARGS for puppetserver JVM
# @param [String] system_config_path The path to be used for the system config

class puppetserver(
  String $certname,
  String $version,
  Boolean $autosign,
  String $java_args,
  String $system_config_path,
  ) {

  include puppetserver::install
  include puppetserver::config
  include puppetserver::service

  Class['puppetserver::install']
  -> Class['puppetserver::config']
    -> Class['puppetserver::service']

}

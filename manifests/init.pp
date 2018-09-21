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
# @param [String] enable_ca Set the parameter to enable the CA service
# @param [String] ca_server Set the parameter to define the CA Server address
# @param [String] dns_alt_names Set the parameter to define the DNS Alt Names for master certificate
# @param [String] environment Set the parameter to define the environment for agent
# @param [String] runinterval Set the parameter to define the interval between agent runs
# @param [Integer] jruby_instances Set the parameter to define the number of jruby instances running


class puppetserver(
  String $certname,
  String $version,
  Boolean $autosign,
  String $java_args,
  String $system_config_path,
  Boolean $enable_ca,
  String $ca_server,
  String $main_server,
  String $dns_alt_names,
  String $environment,
  String $runinterval,
  Integer $jruby_instances,
  ) {

  include puppetserver::install
  include puppetserver::config
  include puppetserver::service

  Class['puppetserver::install']
  -> Class['puppetserver::config']
    -> Class['puppetserver::service']

}

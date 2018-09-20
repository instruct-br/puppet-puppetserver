require 'spec_helper'
describe 'puppetserver', :type => :class do
  on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        it { is_expected.to compile }
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('puppetserver') }
        it { is_expected.to contain_class('puppetserver::install').that_comes_before('Class[puppetserver::config]') }
        it { is_expected.to contain_class('puppetserver::config').that_comes_before('Class[puppetserver::service]') }
        it { is_expected.to contain_class('puppetserver::service') }


        context 'puppetserver::install defaults' do
          it { is_expected.to contain_package('puppetserver') }
        end

        context 'puppetserver::config defaults' do
          it { is_expected.to contain_augeas('puppetserver_main_certname').with({
            'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
             })
          }
          it { is_expected.to contain_augeas('puppetserver_main_server').with({
            'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
          })}
          it { is_expected.to contain_augeas('puppetserver_main_ca_server').with({
            'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
          })}
          it { is_expected.to contain_augeas('puppetserver_main_environment').with({
            'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
          })}
          it { is_expected.to contain_augeas('puppetserver_main_runinterval').with({
            'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
          })}
          it { is_expected.to contain_augeas('puppetserver_master_dns_alt_names').with({
            'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
          })}
          it { is_expected.to contain_augeas('puppetserver_java_args') }
          it { is_expected.to contain_file('puppetserver_ca_config') }
        end

        context 'puppetserver::service defaults' do
          it { is_expected.to contain_service('puppetserver').with({
            'ensure' => 'running',
            'enable' => true,
            })
          }
          it { is_expected.not_to contain_service('puppet') }
        end
    end
  end
end

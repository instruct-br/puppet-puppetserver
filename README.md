[![Build Status](https://travis-ci.org/instruct-br/puppet-puppetserver.svg?branch=master)](https://travis-ci.org/instruct-br/puppet-puppetserver)  ![License](https://img.shields.io/badge/license-Apache%202-blue.svg) ![Version](https://img.shields.io/puppetforge/v/instruct/puppetserver.svg) ![Downloads](https://img.shields.io/puppetforge/dt/instruct/puppetserver.svg)

# Puppetserver

#### Table of contents

1. [Overview](#overview)
3. [Supported Platforms](#supported-platforms)
4. [Requirements](#requirements)
5. [Installation](#installation)
6. [Usage](#usage)
7. [References](#references)
8. [Development](#development)

## Overview

This module will install the latest puppetserver 5 series in your system.

This is a very simple module, usually used for development and test purposes.

Yes, you can use it in production, but it is a simple module, you may miss some parameters for production use.

The main objective is to install puppetserver with minimal intervention in the default files.

Augeas resource type is used to change parameters inside the puppet.conf.

## Supported Platforms

This module was tested under these platforms

- CentOS 6 and 7
- Debian 8, 9
- Ubuntu 16.04

Tested only in X86_64 arch.

#### Debian notes

Debian is not officially supported, but the module works on Debian 8/9. You just need to enable debian backports and install jdk8 before use the module.

Instructions for Debian 8

```
echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
apt-get update
apt-get -y -t jessie-backports install "openjdk-8-jdk-headless"
```

Instructions for Debian 9

```
echo "deb http://ftp.debian.org/debian stretch-backports main" >> /etc/apt/sources.list
apt-get update
apt-get -y -t stretch-backports install "openjdk-8-jdk-headless"
```
In the future I will try to support this requirements inside the module, for now, you should do this before.

You can try my debian8 box with jdk and backport enabled.

- https://app.vagrantup.com/gutocarvalho/boxes/debian8x64

## Requirements

### Pre-Reqs

You need internet to install packages.

You should configure your hostname properly.

You should configure your /etc/hosts properly.

    ip fqdn alias puppet

### Requirements

- Puppet >= 5.x
  - Hiera >= 3.x (v5 format)
  - Facter >= 3.x

## Installation

via git

    # cd /etc/puppetlabs/code/environment/production/modules
    # git clone https://github.com/instruct-br/puppet-puppetserver.git puppetserver

via puppet

    # puppet module install instruct/puppetserver

via puppetfile

    mod 'instruct-puppetserver'

## Usage

### Quick run

    puppet apply -e "include puppetserver"

### Using with parameters

#### Example in EL 7

```
class { 'puppetserver':
  certname           => $trusted['certname'],
  version            => '5.3.4-1.el7',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2g -XX:MaxPermSize=256m',
  system_config_path => '/etc/sysconfig'
}
```
#### Example in Ubuntu 16.04

```
class { 'puppetserver':
  certname           => $trusted['certname'],
  version            => '5.3.4-1puppetlabs1',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2g -XX:MaxPermSize=256m',
  system_config_path => '/etc/default'
}
```

#### Example in Debian 8

```
class { 'puppetserver':
  certname           => $trusted['certname'],
  version            => '5.3.1-1puppetlabs1',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2g -XX:MaxPermSize=256m',
  system_config_path => '/etc/default'
}
```

## References

### Classes

```
puppetserver
puppetserver::install (private)
puppetserver::config (private)
puppetserver::service (private)
```

### Parameters type

#### `certname`

Type: String

Certificate name for the agent and server.

#### `version`

Type: String

The puppet server package version. ( 5.3.4-1puppetlabs1 | installed | latest )

#### `autosign`

Type: Boolean

If true puppet server will sign every certificate request.

#### `java_args`

Type: String

Configuration for the puppetserver JVM.

#### `system_config_path`

Type: String

Path for the default OS configuration for puppetserver package.

### Hiera Keys

```
puppetserver::certname: "%{trusted.certname}"
puppetserver::version: '5.3.1-1.el7'
puppetserver::autosign: false
puppetserver::java_args: '-Xms2g -Xmx2g -XX:MaxPermSize=256m'
puppetserver::system_config_path: '/etc/sysconfig'
```

### Hiera module config

This is the Hiera v5 configuration inside the module.

This module does not have params class, everything is under hiera v5.

```
---
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: "OSes"
    paths:
     - "oses/distro/%{facts.os.name}/%{facts.os.release.major}.yaml"
     - "oses/family/%{facts.os.family}.yaml"

  - name: "common"
    path: "common.yaml"

```

This is an example of files under modules/puppetserver/data

```
oses/family/RedHat.yaml
oses/family/Debian.yaml
oses/distro/CentOS/7.yaml
oses/distro/CentOS/6.yaml
oses/distro/Ubuntu/16.04.yaml
```

## Development

### My dev environment

This module was developed using

- Puppet 5.5
  - Hiera 3.33.3 (v5 format)
  - Facter 3.11
  - CentOS 7.4
- Vagrant 2.0.1
  - box: gutocarvalho/centos7x64puppet5

### Testing

This module uses puppet-lint, puppet-syntax, metadata-json-lint, rspec-puppet, beaker and travis-ci. We hope you use them before submitting your PR.

#### Installing gems

    gem install bundler --no-rdoc --no-ri
    bundle install --without development

#### Running syntax tests

    bundle exec rake syntax
    bundle exec rake lint
    bundle exec rake metadata_lint

#### Running unit tests

    bundle exec rake spec

#### Running acceptance tests

Acceptance tests (Beaker) can be executed using ./acceptance.sh. There is a matrix 1/3 to test this class under Centos 6/7 and Ubuntu 16.04.

    bash ./acceptance.sh

If you want a detailed output, set this before run acceptance.sh

    export BEAKER_debug=true

If you want to test a specific OS from our matrix

    BEAKER_set=centos-6-x64 bundle exec rake beaker

Our matrix values

    centos-6-x64
    centos-7-x64
    ubuntu-1604-x64

This matrix needs vagrant (>=2.x) and virtualbox (>=5.1) to work properly, make sure that you have both of them installed.

### Author

Guto Carvalho (gutocarvalho at instruct dot com dot br)

### Contributors

Taciano Tres (taciano at instruct dot com dot br)
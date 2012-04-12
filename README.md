# puppet-elasticsearch
================

Install elasticsearch service

## REQUIREMENTS

* Puppet >=2.6 if using parameterized classes
* Currently supports CentOS6.2, but should work on others...

## Installation

Clone or submodule this repository into:

/etc/puppet/modules/elasticsearch

## Invocation

To install on a node:

include elasticsearch

or with parameters:

class{elasticsearch:
    $version => "0.19.2",
    $install_root => "/opt"
}

## Issues

Originally this installs elasticsearch from tarballs, which was bloated the git repository. It should now grab ElasticSearch directly from github, though getting elasticsearch as a package would be ideal.

## References

* ElasticSearch homepage: http://www.elasticsearch.org/
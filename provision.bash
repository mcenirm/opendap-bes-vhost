#!/bin/bash

set -e

rpmquery --quiet epel-release \
|| yum -y install epel-release

rpmquery --quiet libdap.x86_64 \
|| yum -y install /vagrant/hyrax_releases/binary/hyrax-1.13.0/centos6.6/libdap{,-devel}-3.17.0-1.el6.x86_64.rpm

rpmquery --quiet bes.x86_64 \
|| yum -y install /vagrant/hyrax_releases/binary/hyrax-1.13.0/centos6.6/bes{,-devel}-3.17.0-1.static.el6.x86_64.rpm

rpmquery --quiet netcdf.x86_64 \
|| yum -y install {netcdf,nco}{,-devel}.x86_64

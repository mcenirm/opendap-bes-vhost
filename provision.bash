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

for env in dev test ops ; do
  exdir=/data/${env}/example
  cdl=${exdir}/example_${env}.cdl
  nc=${exdir}/example_${env}.nc

  mkdir -p -- "$exdir"
  if ! [ -f "$cdl" ] ; then
    cat > "$cdl" <<EOF
netcdf example_$env {   // example of CDL notation
dimensions:
  x = 3 ;
  y = 8 ;
variables:
  float rh(x, y) ;
  rh:units = "percent" ;
  rh:long_name = "relative humidity" ;
// global attributes
  :title = "example in $env" ;
data:
  rh =
    2, 3, 5, 7, 11, 13, 17, 19,
    23, 29, 31, 37, 41, 43, 47, 53,
    59, 61, 67, 71, 73, 79, 83, 89 ;
}
EOF
  fi
  if [ "$cdl" -nt "$nc" ] ; then
    ncgen -o "$nc" "$cdl"
  fi
done

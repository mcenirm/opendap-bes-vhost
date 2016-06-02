#!/bin/bash

set -e

rpmquery --quiet epel-release \
|| yum -y install epel-release

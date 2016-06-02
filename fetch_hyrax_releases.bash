#!/bin/bash

set -e

DEST='hyrax_releases'
OPENDAP_BASE_URL='http://www.opendap.org/pub/'
HYRAX_RPMS_PATH='binary/hyrax-1.13.0/centos6.6'


dest=$( cd "$(dirname "$0")" && /bin/pwd )/${DEST}
mkdir -p -- "$dest"

wget --no-verbose --mirror -nH -np --cut-dirs=1 --reject-regex '\?C=.;O=.$' -P "$dest" "$OPENDAP_BASE_URL$HYRAX_RPMS_PATH/"

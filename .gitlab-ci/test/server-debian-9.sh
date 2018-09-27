#!/bin/sh

set -e

if [ "$1" = "setup" ]
then
  set -x
  apt-get install --no-install-recommends --yes $(./share/requires.py -p lava-dispatcher -d debian -s stretch -n)
  apt-get install --no-install-recommends --yes -t stretch-backports $(./share/requires.py -p lava-dispatcher -d debiqn -s stretch-backports -n)
else
  set -x
  PYTHONPATH=. py.test-3 --cache-clear -v --junitxml=common.xml lava_common/test
  PYTHONPATH=. py.test-3 --cache-clear --ds lava_server.settings.development -v --junitxml=server.xml lava_scheduler_app/tests lava_results_app/tests linaro_django_xmlrpc/tests.py
fi
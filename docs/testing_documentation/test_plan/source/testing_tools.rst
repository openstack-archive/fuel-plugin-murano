.. _testing-tools:

=====================================
Testing tools recommended by Mirantis
=====================================

Mirantis recommends that you use a series of testing tools to make sure your
plugin meets both Mirantis and OpenStack Community testing standards.
For your convenience, the list below also provides the specific categories
of the plugin to apply these tools.

Download URLs are listed in :ref:`appendix`.

.. _ostf:

OSTF
~~~~

Mirantis OpenStack has built-in system called Health Check for a quick
high-level verification of the cloud. Health Check will test the basic
operations of the OpenStack API, HA validation (check MySQL and RabbitMQ
clusters status) and other critical functions.

OSTF (aka Health Checks) run automatically on deploying your cluster with
the plugin installed. This means, OSTF is obligatory step in all test cases.

Suitable for any plugin.

.. _shaker:

Shaker
~~~~~

Shaker is used to test network performance. It’s the distributed data-plane
testing tool for OpenStack.

Suitable for Networking/SDN plugins.

.. _rally:

Rally
~~~~~

Rally is used to test API functionality and performance.
Rally is a benchmarking tool developed by OpenStack community and is widely
used in OpenStack ecosystem.

Suitable for any plugin.

.. _tempest:

Tempest
~~~~~~~

Tempest is an original test framework developed by community and aimed
to cover all possible API functionality available in Openstack components
or added by third-party modules/drivers/plugins.

It contains hundreds of tests.

Suitable for any plugin.

.. _fio:

Fio
~~~

Fio is used for disk performance measurement.

Suitable for storage plugins.

.. _wally:

Wally
~~~~~

Wally enables testing framework for measuring block storage devices performance.

Suitable for storage plugins.
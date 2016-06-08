.. _tp-other:

=====
Other
=====

Fuel plugin interoperability testing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Mirantis recommends that you test your plugin with any other plugins that
belong to different category.

For instance, if you have SDN solution turned into the plugin, you could take
up the one that provides some application to run at the top of
Mirantis OpenStack. Below you can find the list of most commonly used plugin
combinations:

* LDAP
* Contrail
* Stacklight
* Zabbix

The latest versions of these plugins can be downloaded from the
`Fuel Plugin Catalog <https://www.mirantis.com/validated-solution-integrations/fuel-plugins/>`_.
Please, be sure to reach out to `Partner Enablement team <unlocked-tech@mirantis.com>`_
to get the latest information on the most frequently used plugin combination
to plan your testing procedure accordingly.

Performance testing
~~~~~~~~~~~~~~~~~~~

Please note that all instructions on installing and configuring the tools are
provided in the Testing tools recommended by Mirantis section  of this document.

.. note::

   Performance testing is supposed to be run on 20+ nodes (specifically,
   when using Rally and Shaker).

Networking performance
----------------------

Be sure to download and install Shaker.

API benchmarking
----------------

Download and install Rally.

Storage  performance
--------------------

Download and install Fio or Wally.

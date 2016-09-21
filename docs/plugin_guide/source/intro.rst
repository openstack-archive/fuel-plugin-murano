.. _overview:

Overview
~~~~~~~~

Murano plugin for Fuel is a plugin to install the Application Catalog Service
for OpenStack.
Murano plugin provides flexibility for the OpenStack Application Catalog
service by supporting multiple releases and versions (for some Fuel version).
Also, the plugin provides the capability to detach Murano from the controller
node as a separate node.

.. _prerequisites:

Software prerequisites
----------------------

To use Murano plugin, verify that your environment meets the following prerequisites:

======================= =================================
Prerequisites           Version/Comment
======================= =================================
Fuel                    9.0
======================= =================================

Limitations
-----------

* Murano plugin is known to conflict with Contrail plugin. The reason is that
  both ``murano-api`` and ``contrail-api`` services use 8082 as their
  default port. To resolve this, please specify a
  custom port for ``contrail-api`` in Contrail plugin.

Licenses
--------

================= ============
**Component**     **License**
================= ============
Murano plugin     Apache 2.0
================= ============

References
----------

For more information about Murano plugin for Fuel described in this document,
see:

* `Specification <https://specs.openstack.org/openstack/fuel-specs/specs/9.0/murano-fuel-plugin.html>`__

* `Launchpad project <https://launchpad.net/fuel-plugin-murano>`__

* `GitHub project <http://git.openstack.org/cgit/openstack/fuel-plugin-murano>`__

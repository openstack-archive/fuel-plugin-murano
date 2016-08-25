.. _pg-install:

=====================
Install Murano plugin
=====================

Before you install Murano plugin, verify that your environment meets
the requirements described in :ref:`pg-prerequisites`. You must have the Fuel
Master node installed and configured before you can install the plugin.
Typically, you install a Fuel plugin before you deploy an OpenStack environment.

**To install Murano plugin:**

#. Download Murano plugin from the `Fuel Plugins Catalog`_.

#. Copy the plugin ``.rpm`` package to the Fuel Master node:

   **Example:**

   .. code-block:: console

      # scp detach-murano-<plugin_version> root@fuel-master:/tmp

#. Log into Fuel Master node CLI as root.

#. Install the plugin by typing:

   .. code-block:: console

      # fuel plugins --install detach-murano-<plugin_version>

#. Verify that the plugin is installed correctly:

   .. code-block:: console

     # fuel plugins
     id | name          | version | package_version
     ---|---------------|---------|----------------
     1  | detach-murano |<version>| <version>

#. Proceed to :ref:`pg-configure`.

.. _Fuel Plugins Catalog: https://www.mirantis.com/products/openstack-drivers-and-plugins/fuel-plugins/

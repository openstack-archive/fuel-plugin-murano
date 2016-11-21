.. _pg-install:

Installing the Murano plugin
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before you install the Murano plugin, verify that your environment meets the
requirements described in :ref:`prerequisites`. You must have the Fuel
Master node installed and configured before you can install the plugin.
Typically, you install a Fuel plugin before you deploy an OpenStack environment.

**To install the Murano plugin:**

#. Download the Murano plugin from the `Fuel Plugins Catalog`_.

#. Copy the plugin ``.rpm`` package to the Fuel Master node:

   **Example:**

   .. code-block:: console

      # scp detach-murano-<plugin_version> root@fuel-master:/tmp

#. Log in to the Fuel Master node CLI as root.

#. Install the plugin by typing:

   .. code-block:: console

      # fuel plugins --install detach-murano-<plugin_version>

#. Verify that the plugin is installed correctly:

   .. code-block:: console

     # fuel plugins
     id | name          | version | package_version
     ---|---------------|---------|----------------
     1  | detach-murano | 1.3.0   | 4.0.0

#. Proceed to :ref:`pg-configure`.

.. _Fuel Plugins Catalog: https://www.mirantis.com/products/openstack-drivers-and-plugins/fuel-plugins/

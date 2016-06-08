.. _upd-upgr:

==================
Update and upgrade
==================

This section provides test cases recommended in terms of update and upgrade
procedure.

The Fuel Master node upgrade testing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Please refer to the `official Fuel documentation <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-install-guide/upgrade/upgrade-fuel.html>`_
to learn more about the procedure and make up the corresponding test case for
your plugin.

In general, this case is for the situation when, for exaple, your plugin is
targeted at 6.1 release of Mirantis OpenStack and you'd like to perform
upgrade of the Fuel Master node to 7.0 Mirantis OpenStack.

Test Case ID: upgrade_Master_node

Steps to reproduce:

For example, your plugin is compatible with 6.1 MOS. Then:

#. Install the version of MOS that is compatible with your plugin (e.g. 6.1).

#. Install a plugin that is compatible with this version (e.g., 6.1) using standard flow.

#. Finalize the environment configuration and deploy it.

#. Deploy an environment.

#. Upgrade the Fuel Master node (e.g., 6.1->7.0).

#. Verify cluster and plugin functionality:

   * Verify that all nodes are left in ready state
   * Run OSTF checks
   * Verify all plugin-related services are running.

Expected result:

* Cluster and plugin stay fully operational.

* When the upgrade is complete, the following messages will appear under
  the Releases tab in the Fuel Web UI: *New release available: Kilo on Ubuntu
  14.04 (2015.1.0-7.0).*

Update the plugin to minor version in the deployed environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fuel Plugin Framework allows updating the plugin to the minor version.
Please consider adding this case because bug fixes for Fuel plugins are
delivered as new minor versions. Refer to
the `Fuel CLI reference <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/cli/cli_plugins.html>`_
on Fuel plugins to learn about the procedure.

Test Case ID: update_plugin_to_minor

Steps to reproduce:

#. Copy the first version of the plugin to the Fuel Master node (please refer
   to the User Guide for more details).

#.  Install the plugin.

#. Ensure that plugin is installed successfully with running
   ``fuel plugins --list`` command in the Fuel CLI.

#. Add 3 nodes with Controller role and 1 node with Compute and  another role.

#. Finalize environment configuration (e.g. networking, nodes interfaces).

#.Enable the plugin and configure it following the instructions from the Plugin Guide.

#. Run network verification check.

#. Deploy the cluster.

#. Run OSTF.

#. Copy the second version of the plugin (minor one) to the Fuel Master node
   (please refer to the User Guide for more details).

#.  Run the following command::

       fuel plugins --update <fuel-plugin-file>

#. Make sure all nodes are left in ready state.

#.Run OSTF checks.

#. Make sure all plugin-related services are running.

Expected result:

* The new plugin version is displayed in the output of the ``fuel plugins --list`` command.

Apply maintenance updates to deployed environment
-------------------------------------------------

Mirantis OpenStack features the ability to receive patches via
the common flow called Maintenance Updates. Please reach out to
Partner Enablement team about the latest Maintenance Updates portion to test
against with you plugin.
You can also check
`this page <https://docs.mirantis.com/openstack/fuel/fuel-8.0/maintenance-updates.html#maintenance-updates-for-mirantis-openstack-8-0>`_.

Test Case ID: apply_mu

Steps to reproduce:

#. Copy the plugin to the Fuel Master node (please refer to the User Guide for more details).

#. Install the plugin.

#. Ensure that plugin is installed successfully with running
   ``fuel plugins --list`` command in the Fuel CLI.

#. Add 3 nodes with Controller role and 1 node with Compute and  another role.

#. Finalize environment configuration (e.g. networking, nodes interfaces).

#. Enable the plugin and configure it following the instructions from the Plugin Guide.

#. Run network verification check.

#. Deploy the cluster.

#. Run OSTF.

#. Once environment is deployed, apply maintenance updates following the instructions.

#. Check is plugin services continue running.

#. Make sure all nodes are in ready state and no regression is observed.

#. Run OSTF checks.

Expected result:

* Plugin is installed successfully at the Fuel Master node and
  the corresponding output appears in the CLI.

* Cluster is created and network verification check is passed.

* Plugin is enabled and configured in the Fuel Web UI.

* OSTF tests (Health Checks) are passed.

* Environment is deployed successfully.

* Maintenance Updates do not affect running services related to the plugin
  (e.g. the services aren't restarted).

* Cluster remains in the fully operational state after applying
  the Maintenance Updates.
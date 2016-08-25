.. _pg-configure:

=======================
Configure Murano plugin
=======================

Once the *Murano Plugin* is installed following the instructions of
the :ref:`pg-install`, you can create a Mirantis OpenStack (MOS) environment
with Murano services.
This plugin was created to provide flexibility for Murano: to support multiple
releases and versions (for some Fuel version). Also plugin provides ability to
detach Murano from controller node as separate node.

Plugin configuration
--------------------

#. To use Murano plugin, you need to create an OpenStack environment as
   described in the `Fuel User Guide <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/create-environment.html>`_ or use already deployed.

#. Make sure that plugin is properly installed on the Fuel Master node.

   Go to the *Plugins* tab. You should see the following:

   .. image:: images/murano-plugin-on9-0.png
    :width: 100%

#. Enable Murano plugin

   Go to the *Environments* tab and select the *Murano plugin* checkbox:

   .. image:: images/murano-plugin-9-0.png
    :width: 100%

#. Murano plugin has options to configure and select available features:

   **Murano Repository URL** field specifyes murano applications repository,
   to import a package.

   **Install Murano service broker for Cloud Foundry** checkbox enables
   Cloud Foundry Service Broker API.
   Cloud Foundry is PaaS which supports full lifecycle from initial development,
   through all testing stages, to deployment. Most well known Cloud Foundry
   flavours is Cloud Foundry OSS, Pivotal Cloud Foundry and Pivotal Web Services.
   Since Cloud Foundry Service Broker API is enabled murano apps will be available
   at Cloud Foundry as services.

   **Enable glance artifact repository** checkbox enables usage of new Glance API,
   which store not only the VM images, but also data assets and their metadata for
   other OpenStack projects.
   This specification defines the usage of this feature in Murano, so Murano may
   store its packages in Glance and benefit from all its features.

   **Install Application Catalog UI** checkbox enables the OpenStack Community App
   Catalog, which will help make applications available on OpenStack cloud by
   providing a community driven catalog containing Glance images, Heat templates
   and Murano applications.

   **Additional config** field allows to specify Murano end-user credentials:
   names of Murano users (db, keystone, rabbit), passwords and etc.

   .. image:: images/murano-options-9-0.png
    :width: 100%

#. Murano plugin has also two possible ways to be installed:

   1) Murano services can be installed in standalone mode;
   2) Murano services can be installed on controllers;

   In 1) case you need to choose *Murano node* role. In this case Murano services
   will be installed only on nodes with this role. There are no any restrictions
   on combining Murano role with other roles.

   .. image:: images/murano-node-role-9-0.png
    :width: 100%

   In 2) case Murano services will be installed on *Controller node*.


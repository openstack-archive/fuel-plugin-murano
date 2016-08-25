.. _pg-configure:

=======================
Configure Murano plugin
=======================

Once the *Murano Plugin* is installed, follow the instruction below to create
an OpenStack environment with Murano services.

Plugin configuration
--------------------

**To configure the plugin:**

#. To use the Murano plugin, create an OpenStack environment as
   described in the
   `Fuel User Guide <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/create-environment.html>`_
   or use an already deployed one.

#. To verify that the plugin is properly installed on the Fuel Master node,
   navigate to the :guilabel:`Plugins` tab. You should see the following:

   .. image:: images/murano-plugin-on9-0.png
      :width: 100%

#. To enable the Murano plugin, navigate to the :guilabel:`Environments` tab
   and select the :guilabel:`Murano plugin` checkbox:

   .. image:: images/murano-plugin-9-0.png
      :width: 100%

#. Select and configure available features:

   **Murano Repository URL** specifies the murano applications repository
   to import a package.

   **Install Murano service broker for Cloud Foundry** enables Cloud Foundry
   Service Broker API. Cloud Foundry is PaaS which supports full lifecycle
   from initial development through all testing stages to deployment. Most
   well-known Cloud Foundry flavours are Cloud Foundry OSS, Pivotal Cloud
   Foundry, and Pivotal Web Services. Since Cloud Foundry Service Broker API
   is enabled, murano apps will be available at Cloud Foundry as services.

   **Enable glance artifact repository** enables usage of new Glance API,
   which stores not only the VM images, but also data assets and their
   metadata for other OpenStack projects. This specification defines the usage
   of this feature in Murano. Therefore, Murano may store its packages in
   Glance and benefit from all its features.

   **Install Application Catalog UI** enables the OpenStack Community App
   Catalog, which will help make applications available on OpenStack cloud by
   providing a community-driven catalog containing Glance images, Heat
   templates, and Murano applications.

   **Additional config** allows to specify Murano end-user credentials, such
   as names of Murano users (db, keystone, rabbit), passwords, and others.

   .. image:: images/murano-options-9-0.png
      :width: 100%

#. Install Murano services following one of the two ways:

   * In standalone mode. In this case, choose the *Murano node* role. Murano
     services will be installed only on nodes with this role. There are no
     other restrictions on combining Murano role with other roles.

     .. image:: images/murano-node-role.png
        :width: 100%

   * On controllers. In this case, Murano services will be installed on
     *Controller node*.

#. Configure your environment as described in the
   `Fuel User Guide <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/configure-environment.html>`__.

As a result, deploy your environment as described in the
`Fuel user Guide <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/deploy-environment.html>`__.
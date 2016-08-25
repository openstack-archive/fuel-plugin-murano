.. _pg-configure:

=======================
Configure Murano plugin
=======================

Once the *Murano Plugin* is installed, follow the instruction below to create
an OpenStack environment with Murano services.

Plugin configuration
--------------------

**To configure the plugin:**

#. Create an OpenStack environment as described in the
   `Fuel User Guide <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/create-environment.html>`_
   or use an existing one.

#. To enable the Murano plugin, navigate to the :guilabel:`Environments` tab
   and select the :guilabel:`Murano plugin` checkbox:

   .. image:: images/murano-plugin-9-0.png
      :width: 440pt

#. Configure the Murano plugin as required selecting the following available
   settings.

   :guilabel:`Murano Repository URL` specifies the murano applications
   repository to import a package.

   :guilabel:`Install Murano service broker for Cloud Foundry` enables Cloud
   Foundry Service Broker API. Cloud Foundry is PaaS which supports full
   lifecycle from initial development through all testing stages to
   deployment. Most well-known Cloud Foundry flavors are Cloud Foundry OSS,
   Pivotal Cloud Foundry, and Pivotal Web Services. If Cloud Foundry Service
   Broker API is enabled, Murano apps are available at Cloud Foundry as
   services.

   :guilabel:`Enable glance artifact repository` enables usage of new Glance
   API, which stores not only the VM images but also data assets and their
   metadata for other OpenStack projects. This specification defines the usage
   of this feature in Murano. Therefore, Murano may store its packages in
   Glance and benefit from all its features.

   :guilabel:`Install Application Catalog UI` enables the OpenStack Community
   App Catalog, which will help make applications available on OpenStack cloud
   by providing a community-driven catalog containing Glance images, Heat
   templates, and Murano applications.

   :guilabel:`Additional config` allows specifying Murano end-user credentials,
   such as names of Murano users (db, keystone, rabbit), passwords, and others.

   .. image:: images/murano-options-9-0.png
      :width: 440pt

#. To deploy Murano services on a particular OpenStack node, assign the
   :guilabel:`Murano node` role to this node in the :guilabel:`Nodes` tab.
   There are no restrictions to combining the Murano role with other node
   roles. Otherwise, Murano services will be deployed on controller nodes.

   .. image:: images/murano-node-role.png
      :width: 440pt

#. Configure your environment as described in the
   `Fuel User Guide <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/configure-environment.html>`__.

Now, you can deploy your OpenStack environment with Murano as described in the
`Fuel user Guide <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/deploy-environment.html>`__.
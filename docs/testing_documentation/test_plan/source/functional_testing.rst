.. _functional-testing:

==================
Functional testing
==================

Functional testing is obligatory for your plugin and highly depends on
the plugin's use case.

Tempest
~~~~~~~

Case title should be short. Provide the description below.

Test Case ID: tempest_run
-------------------------

Steps to reproduce:

#. Copy the plugin to the Fuel Master node (please refer to the User Guide
   for more details).

#. Install the plugin.

#. Ensure that plugin is installed successfully with running
   ``fuel plugins --list command`` in the Fuel CLI.

#. Create an environment with enabled plugin in the Fuel Web UI.

#. Add 3 nodes with Controller role and 1 node with Compute and  another role.

#. Finalize environment configuration (e.g. networking, nodes interfaces).

#. Run network verification check.

#. Deploy the cluster.

#. Run OSTF.

#. Install Tempest suite at the Fuel Master node according to the instructions
   (found in `README.md <https://github.com/Mirantis/mos-tempest-runner>`_ file).

Expected result:

* Plugin is installed successfully at the Fuel Master node and
  the corresponding output appears in the CLI.

* Cluster is created and network verification check is passed.

* Plugin is enabled and configured in the Fuel Web UI.

* OSTF tests (Health Checks) are passed.

* Environment is deployed successfully.

* All Tempest tests are passed successfully except for those expected to fail
  (the latter are listed `here <https://github.com/Mirantis/mos-tempest-runner/tree/master/shouldfail>`_).

Tool name
~~~~~~~~~

Test Case ID: *unique name*
---------------------------

Steps to reproduce:

#. ...

#. .....

Expected result:

* ...

* ...

* ...

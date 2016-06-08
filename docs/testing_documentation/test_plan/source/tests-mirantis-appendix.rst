:orphan:

.. _tests_tools:

Tests included into tools [DO NOT COPY]
=======================================

.. note:: Please do not copy this list into your Test Plan. This is just FYI list.

This section provides the detailed information on the test cases run within every specific tool listed in
:ref:`the corresponding section<testing-tools>`.

OSTF (Health Checks)
-------------------

Sanity group
++++++++++++

* Ceilometer test to list meters, alarms and resources
* Request flavor list
* Request image list using Nova
* Request instance list
* Request absolute limits list
* Request snapshot list
* Request volume list
* Request image list using Glance v1
* Request image list using Glance v2
* Request stack list
* Request active services list
* Request user list
* Check that required services are running
* Request list of networks

Smoke group
+++++++++++

* Create instance flavor
* Check create, update and delete image actions using Glance v1
* Check create, update and delete image actions using Glance v2
* Create volume and boot instance from it
* Create volume and attach it to instance
* Instance live migration
* Check network connectivity from instance via floating IP
* Create keypair
* Create security group
* Check network parameters
* Launch instance
* Launch instance, create snapshot, launch instance from snapshot
* Create user and authenticate with it to Horizon

HA group
++++++++

* Check data replication over mysql
* Check if amount of tables in databases is the same on each node
* Check galera environment state
* Check pacemaker status
* RabbitMQ availability
* RabbitMQ replication

Platform group
++++++++++++++

* Ceilometer test to check alarm state and get Nova metrics
* Ceilometer test to check notifications from Glance
* Ceilometer test to check notifications from Keystone
* Ceilometer test to check notifications from Neutron
* Ceilometer test to check notifications from Cinder
* Ceilometer test to create, check and list samples
* Ceilometer test to create, update, check and delete alarm
* Typical stack actions: create, delete, show details, etc.
* Advanced stack actions: suspend, resume and check
* Check stack autoscaling
* Check stack rollback
* Update stack actions: in-place, replace and update whole template

Cloud validation group
++++++++++++++++++++++

* Check disk space outage on controller and compute nodes
* Check log rotation configuration on all nodes

Tempest
-------
All Tempest tests are running except a small number of those known as
‘should-fail’ for a particular MOS version.
Tempest also covers negative scenarios such as authorization violation or parameters’ mismatch. The following tests are expected to fail:
The tests listed `here <https://github.com/Mirantis/mos-tempest-runner/tree/master/shouldfail/7_0 >`_.
Tests for Swift because there is RadosGW instead of Swift.

Rally
-----

The following test cases are tested using Rally:

Ceilometer
++++++++++

* A user is able to define, modify, check a status and history, get a list and delete alarms
* A user is able to create meters and get statistics for them
* A user is able to define list of meters and resources

Cinder
++++++

* A user is able to create, clone, extend, attach and delete volumes
* A user is able to create a volume backup and restore from it
* A user is able to convert a volume to an image
* A user is able to clone volumes
* A user is able to create and delete snapshots of volumes
* A user is able to convert snapshots back to new volumes and delete the volumes afterwards
* A user is able to get a list of volumes and snapshots

Heat
++++

* A user is able to create, suspend, resume, check and delete stacks
* A user is able to add, modify, and delete resources from stacks
* A user is able to manage resource groups

Glance
++++++

* A user is able to create, modify their metadata, and delete images
* A user is able to get a list of images

Keystone
++++++++

* A user is able to manage (create, modify, and delete) services and roles
* A user is able to manage users and tenants
* A user is able to assign roles to users

Murano
++++++

* A user is able to import, update, and delete packages
* A user is able to create, deploy, and delete an environment

Nova
++++

* A user is able to create (one by one or multiple at once) and destroy VMs
* A user is able to do power management of VM (hard/soft reboot, power off/on)
* A user is able to pause/unpause a VM
* A user is able to assign Security Groups to a VM
* A user is able to migrate a VM between hypervisors
* A user is able to rebuild a VM using another image
* A user is able to resize a VM
* A user is able to attach a volume to a VM
* A user is able to migrate a VM with attached volume
* A user is able to boot a VM from volume
* A user is able to manage (add, update, and delete) quotas
* A user is able to manage keypairs
* A user is able to assign a keypair to a VM

Neutron
+++++++

* A user is able to manage networks and subnets
* A user is able to manage ports, attach them to networks
* A user is able to manage routers, attach them to networks
* A user is able to update quotas

Swift
+++++

* A user is able to create, list, and delete containers
* A user is able to upload objects into container, list objects, download, and delete them

Rally
+++++

The same functional test cases as above are running concurrently to measure an API response time while it’s under load.
Two runs should be performed with the concurrency set to 5 and 10.

Shaker
++++++
The following test cases are run by Shaker:

* Full_l2.yaml scenario tests the bandwidth between pairs of instances in the same virtual network (L2 domain). Each instance is deployed on own compute node. The test increases the load from 1 pair until all available instances are used.
* Full_l3_east_west.yaml scenario tests the bandwidth between pairs of instances deployed in different virtual networks plugged into the same router. Each instance is deployed on its own compute node. The test increases the load from 1 pair pair until all available instances are used.
* Full_l3_north_south.yaml tests the bandwidth between pairs of instances deployed in different virtual networks. Instances with master agents are located in one network, instances with slave agents are reached via their floating IPs. Each instance is deployed on its own compute node. The test increases the load from 1 pair pair until all available instances are used.
* TCP scenario tests TCP bandwidth to the destination host. By default it sends traffic to one of public iperf servers
* UDP scenario tests UDP packets per second to the destination host. By default it sends traffic to one of public iperf servers. 

Storage performance
+++++++++++++++++++

* Image Uploading to Glance
* Testing on 20G raw image via time glance image-create… command

IOPS for block devices
+++++++++++++++++++++

* Mixed sequential reads and writes and mixed random reads and writes.
* IOPS of Ephemeral disks of a single VM.
* IOPS of Ephemeral disks of 10, 20 VMs.
* IOPS for Cinder volumes of a single VM.
* IOPS for Cinder volumes of 10, 20 VMs.

The tests are done by fio utility with the following configs:
[random_reads_writes]
ramp_time=30
runtime=120
rw=randrw
direct=1
buffered=0
numjobs=32
blocksize=4k
group_reporting
iodepth=64
norandommap=1
thread=1
time_based=1
wait_for_previous
randrepeat=0
filename=/dev/vdc
size=22g

[sequential_reads_writes]
ramp_time=30
runtime=120
rw=readwrite
direct=1
buffered=0
numjobs=32
blocksize=4k
group_reporting
iodepth=64
norandommap=1
thread=1
time_based=1
wait_for_previous
randrepeat=0
filename=/dev/vdc
size=22g

[random-writers]
ramp_time=30
runtime=120
rw=randwrite
direct=1
buffered=0
numjobs=32
blocksize=4k
group_reporting=1
iodepth=64
unified_rw_reporting=1
norandommap=1
thread=1
time_based=1
wait_for_previous=1
randrepeat=0
filename=/dev/vdc
size=22g


Resiliency Tests
++++++++++++++++

* Graceful shutdown one of the controller nodes.
* Gracefully shut down one of the controller nodes. (Controller 1)
(target controller): shutdown -h 0
Boot 5 VMs and verify that they all are up and running.
(other controller): nova boot --flavor 1 --image TestVM --min-count 5 --nic net-id=<net04 ID> ha-test
Turn on controller and wait until all services are up (Time limit 30 min)
(IPMI): power on
(other controller): pcs status
Boot 5 VMs and verify that they all are up and running.
(other controller): nova boot --flavor 1 --image TestVM --min-count 5 --nic net-id=<net04 ID> ha-test
Return the cluster to initial state.
(other controller): for uuid in `nova list|grep ha-test|awk '{print $2}'`; do nova delete $uuid; done
Hard power off one of the controller nodes.
Hard power off one of the controller nodes. (Controller 2)
(IPMI): power off
Boot 5 VMs and verify that they all are up and running.
(other controller): nova boot --flavor 1 --image TestVM --min-count 5 --nic net-id=<net04 ID> ha-test
Turn on controller and wait until all services are up, but not longer than 30 min.
(IPMI): power on
(other controller): pcs status
Boot 5 VMs and verify that they all are up and running.
(other controller): nova boot --flavor 1 --image TestVM --min-count 5 --nic net-id=<net04 ID> ha-test
Return the cluster to initial state.
(other controller): for uuid in `nova list|grep ha-test|awk '{print $2}'`; do nova delete $uuid; done
Cut network communication on one of the controller nodes.
Cut network communication on one of the controller nodes. (Controller 3)
(IPMI): ip link set down <NIC> #For every physical NIC
Boot 5 VMs and verify that they all are up and running.
(other controller): nova boot --flavor 1 --image TestVM --min-count 5 --nic net-id=<net04 ID> ha-test
Reboot controller
(IPMI): power reset
Boot 5 VMs and verify that they all are up and running.
(other controller): nova boot --flavor 1 --image TestVM --min-count 5 --nic net-id=<net04 ID> ha-test
Return the cluster to initial state.
(other controller): for uuid in `nova list|grep ha-test|awk '{print $2}'`; do nova delete $uuid; done




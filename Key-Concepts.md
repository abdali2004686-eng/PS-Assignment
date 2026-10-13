# Key concepts

## RAID

RAID combines disks. RAID 1 keeps a copy on another disk. RAID 5 uses parity and needs at least three disks. RAID 10 combines mirroring and striping. RAID helps when a disk fails, but backups are still needed.

## DevOps

DevOps means developers and operations work together to build, release and maintain software. Git, automated builds, tests and monitoring help with this work.

## HA and DR

High availability means keeping a service running when part of the system fails. For example, two Tomcat servers behind HAProxy can keep serving requests if one server stops.

Disaster Recovery means recovering after a serious failure. This needs backups and tested restore steps. PostgreSQL supports replication and point-in-time recovery. Oracle Data Guard can maintain a standby database. RPO is how much data loss is acceptable; RTO is how long recovery should take.

## Cloud computing

Cloud providers include AWS, Azure, Google Cloud and Oracle Cloud. Public cloud uses a provider's infrastructure. Private cloud is dedicated to one organisation. Hybrid cloud connects public and private environments.

- IaaS provides VMs, storage and networking. The customer manages the OS and applications.
- PaaS provides a platform for running applications.
- SaaS provides a complete application, such as an online email service.

## DNS and load balancers

DNS maps a name to an IP address. A load balancer sends requests to different healthy servers. Nginx and HAProxy can do this and can also act as reverse proxies.

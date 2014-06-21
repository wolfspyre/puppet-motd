#motd

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with motd](#setup)
    * [What motd affects](#what-motd-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with motd](#beginning-with-motd)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

This module manages your system's motd.

##Module Description

This module will manage your system's motd, and will show some relevant information for your system from the last time puppet ran.

Additionally, it will show an optional header, or tail message for conveying notices about the specific system. These are populated by a parameter, so can easily be fed with hiera.

It can display:
* **AWS**
  * AMI_id
  * ec2_hostname
  * ec2_instance_id
  * ec2_instance_type
* FQDN
* Local / Private IP address
* Kernel Release
* Total memory in the system
* Operating System Release
* Public IP address

##Setup

###What motd affects

* **Directories:**
* **Files:**  `templatized files are displayed like this`
  * `/etc/motd`
  * /var/run/motd
* **Cron Jobs**
* **Logs being rotated**
* **Packages: **
  * **RedHat:**
  * **Debian:**

###Setup Requirements

* **Required Modules**
  * stdlib
  * network

* notes here

###Beginning with motd

* `include motd`

##Usage

Classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module.
The **motd** class does ...

###Hiera Example
    motd::show_ec2:       true
    motd::show_env:       true
    motd::show_func:      true
    motd::show_ip:        true
    motd::show_product:   true
    motd::show_region:    true
    motd::show_warn:      true
    motd::func_hr:        'Human Readable Function'
    motd::head:
     - 'this would be the first line'
     - 'this would be the next line'
    motd::location:       'Some Location'
    motd::product_hr      'Human Readable Productname'
    motd::region:         'aus'
    motd::tail:           false
    motd::tier:           'prd'
    motd::tier_alt_color: 'lred'
    motd::tier_color:     'red'
    motd::tier_hr:        'Production'

###Parameters
* **motd** Class
  * **func_hr** *string*

 This is the human readable name of the function this server performs
  * **head** *array*

 This is an array, (one line per array element) which is displayed at the top of the motd banner
  * **location** *string*

 This is the location of the server
  * **product_hr** *string*

 This is the human readable product/business unit that the server belongs to
  * **region *string*

 This is the region the server is in.
  * **show_ec2** *bool*

 Whether or not to display Amazon ec2 fact information in the motd
  * **show env** *bool*

 Whether or not to display the environment name in the motd
  * **show_func** *bool*

 Whether or not to display the function name in the motd
  * **show_ip** *bool*

 Whether or not to display the server's public and private ips in the motd
  * **show_product** *bool*

 Whether or not to display the product name in the motd
  * **show_region** *bool*

 Whether or not to display the region name in the motd
  * **show_warn** *bool*

 Whether or not to display a warning / security message before the motd. The content of this warning is static, and managed inside the template.
  * **tail** *array*

 This is an array, (one line per array element) which is displayed after the motd banner. Useful for conveying notes about the particular server, or service enablement instructions.
  * **tier** *string*

 This is a short name for the code maturity,service, or environment tier the server is a part of.
  * **tier_alt_color** *string* (Valid options:  *blue* *green* *lblue* *lgreen* *lpurple* *lred* *purple* *red* *white* *yellow*)

 The embelishment color to display around the tier
  * **tier_alt_color** *string* (Valid options:  *blue* *green* *lblue* *lgreen* *lpurple* *lred* *purple* *red* *white* *yellow*)

 The color to display the tier in.
  * **tier_hr** *string*

 This is a pretty name for the code maturity,service, or environment tier the server is a part of.

##Reference


##Limitations

This module is mostly agnostic as to what unix distro it works on. it is tailored to debian/ubuntu, but should work on others. Pull requests welcome

##Development

Please submit pull requests with your changes. Please update the spec tests accordingly

<wolf@wolfspyre.com>

##Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here. You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.

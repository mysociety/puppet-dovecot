# dovecot

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with dovecot](#setup)
    * [What dovecot affects](#what-dovecot-affects)
    * [Beginning with dovecot](#beginning-with-dovecot)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This is a simple module to install and manage a secure Dovecot-based POP3 service.

This module requires at least Dovecot 2.3.13.

Currently tested on Debian 11 and 12.

## Module Description

This module installs, configures and manages a secure dovecot based POP3 service.

It only managed the files required, all others are left as the installer deploys them.

Default settings require TLSv2+ and disables all non-ECC DH cliphers, obviating the need
to use a Diffie-Helman paramters file and the `ssl_dh` option.

## Setup

### What dovecot affects

* Installs dovecot-pop3d
* Manages dovecot.conf and 10-ssl.conf
* Manages the dovecot service

### Beginning with dovecot

```
include ::dovecot
```

## Usage

There's a single entry point via the `dovecot` class through which configuration
overrides can be passed.

```
class { '::dovecot':
  ssl_cert => '</etc/ssl/certs/mail.crt',
  ssl_key  => '</etc/ssl/private/mail.key',
}
```

## Reference

This really is a very simple module using the install -> config ~> service model.

See the comments in `init.pp` for a list of parameters and defaults.

## Limitations

Currently this module only configures some very basic settings that are relevant 
to our usage.

We may add further features as we need them.

## Development

Pull requests welcomed and considered.

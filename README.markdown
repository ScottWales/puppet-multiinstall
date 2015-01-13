MultiInstall
============

Installs multiple versions of a program or library simultaneously

In multi-user environments you sometimes want to support multiple versions of a
software package at the same time, so that for instance you can gradually
migrate users between versions. In HPC environments the 'Module' system is
commonly used for this.

MultiInstall is a highly configurable Puppet module for installing and
configuring multiple versions of a package on a single server.

[![Build Status](https://travis-ci.org/ScottWales/puppet-multiinstall.svg?branch=master)](https://travis-ci.org/ScottWales/puppet-multiinstall)

Using MultiInstall
------------------

The `multiinstall` Puppet type takes a list of tags signifying the package
versions to install, as well as the names of three Puppet types. These are the
'installer', the 'configurer' and the 'chooser' types. These in turn install a
single tag, configure that tag and provide a mechanism for users to choose
which of the tags to run.

There are a set of example types in the manifest directory that show how this works.

 * The type `multiinstall::install::vcsrepo` downloads tags from a
   version-controlled repository using the `puppetlabs-vcsrepo` module

 * The type `multiinstall::configure::template` configures a package using a
   Puppet template file

 * The type `multiinstall::chooser::wrapper` sets up a wrapper which selects
   the version to run using an environment variable

To expand the options you can pass in your own custom types to `multiinstall`.
For instance you might create an installer that installs different Python
library versions using Pip, and a chooser that creates module files for each
version. Pull requests are welcomed to add new helper types

Other notes
-----------

Each of the helper types can be passed options by using the hashes in the main
`multiinstall` type, eg.

    multiinstall {'cylc':
        install_version => 'master',
        install_type    => 'multiinstall::install::vcsrepo',
        install_options => {
            repository  => 'https://github.com/cylc/cylc',
        },
    }

Obsolete versions can be purged by setting the `purge` option to true

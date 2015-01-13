## \file    manifests/init.pp
#  \author  Scott Wales <scott.wales@unimelb.edu.au>
#
#  Copyright 2015 ARC Centre of Excellence for Climate Systems Science
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

# $install_path
#   Base path where installed versions will lie under
#
# $install_tags (array or string)
#   Tags of the repository to install under $install_path. Puppetlabs-Vcsrepo
#   should recognise this as version or tag names for $source_repository
#
# $default_tag (optional)
#   Default tag to be run by the chooser script. If defined should match one of
#   the $install_tags
#
# $install_type
#   Puppet type that handles installing a single tag. The hash $install_options
#   is passed to the type, as well as the variables '$tag_name' and
#   '$tag_install_path' that specify the version and install path to use
#
#   multiinstall::install::vcsrepo is an example type that installs from a
#   version-controlled repository
#
# $config_type (optional)
#   Puppet type that handles configuring a single installed tag. The hash
#   $config_options is passed to the type, as well as the variables '$tag_name' and
#   '$tag_install_path' that specify the version and install path to use
#
#   multiinstall::config::template is an example type that creates a config
#   file using a template
#
# $chooser_type
#   Puppet type that sets up a system where users can choose what tag to run.
#   The hash $chooser_options is passed to the type, as well as the variables
#   '$install_path', '$default_tag' and '$installed_tags' that specify the
#   base install path and available versions
#
#   multiinstall::chooser::wrapper is an example script that creates a wrapper
#   script in $install_path/bin
#
# $purge
#   Purge files in $install_path not managed by puppet

define multiinstall (
  $install_path      = "/opt/${name}",

  $install_tags      = [],
  $default_tag       = undef,

  $install_type      = 'multiinstall::install::vcsrepo',
  $install_options   = {},

  $config_type       = undef,
  $config_options    = {},

  $chooser_type      = 'multiinstall::chooser::wrapper',
  $chooser_options   = {},

  $purge             = false,
) {

  validate_absolute_path($install_path)
  validate_string($install_type)
  validate_hash($install_options)
  validate_hash($config_options)
  validate_hash($chooser_options)
  validate_bool($purge)

  # Check if default is actually installed
  if ($default_tag) {
    if (($default_tag != $install_tags) and
        !($default_tag in $install_tags)) {
      warning("Default tag ${default_tag} is not being installed")
    }
  }

  file {$install_path:
    ensure => directory,
    purge  => $purge,
    force  => true,
  }

  # Put the tags in a namespace
  if is_array($install_tags) {
    $namespaced_tags = prefix($install_tags,"${name}:")
  } else {
    $namespaced_tags = "${name}:${install_tags}"
  }

  # Install the required tags under $install_path
  multiinstall::install {$namespaced_tags:
    install_path    => $install_path,
    install_type    => $install_type,
    install_options => $install_options,
    config_type     => $config_type,
    config_options  => $config_options,
  }

  # Configure the chooser
  $chooser_config = {
    'install_path' => $install_path,
    'install_tags' => $install_tags,
    'default_tag'  => $default_tag,
  }
  if $chooser_type {
    $merged_options = merge($chooser_options, $chooser_config)
    $resource_hash = {"${name}" => $merged_options}
    create_resources($chooser_type, $resource_hash)
  }

}

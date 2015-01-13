## \file    manifests/chooser/modulefile.pp
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

# Set up modulefiles for installed versions
define multiinstall::chooser::modulefile (
  $install_path,
  $install_tags,
  $default_tag,

  $module_path = '/etc/modules',

  $template = 'multiinstall/modulefile.erb',
  $options  = {},
) {

  file {"${module_path}/${name}":
    ensure => directory,
  }

  # Set default modulefile
  if $default_tag {
    file {"${module_path}/${name}/.version":
      ensure  => file,
      content => "#%Module1.0\nset ModulesVersion \"${default_tag}\"",
    }
  }

  # Install modulefiles for each version
  multiinstall::chooser::modulefile_tag {$install_tags:
    install_path => $install_path,
    module_path  => "${module_path}/${name}",
    template     => $template,
    options      => $options,
  }

}

## \file    manifests/install.pp
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

# Install and configure a single tag
define multiinstall::install (
  $install_path,

  $install_type,
  $install_options,

  $config_type,
  $config_options,
) {

  $tag = $name
  $tag_install_path = "${install_path}/${tag}"

  # Ensure the directory is not purged
  file {$tag_install_path:
    recurse => true,
  }

  $tag_config = {
    'tag_name'         => $tag,
    'tag_install_path' => $tag_install_path,
  }

  # Perform the install
  if $install_type {
    $merged_options = merge($install_options, $tag_config)
    $resource_hash = {"${tag_install_path}" => $merged_options}
    create_resources($install_type, $resource_hash)
  }

  # Configure the install
  if $config_type {
    $merged_options = merge($config_options, $tag_config)
    $resource_hash = {"${tag_install_path}" => $merged_options}
    create_resources($config_type, $resource_hash)
  }
}

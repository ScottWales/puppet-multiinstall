## \file    manifests/chooser/modulefile_tag.pp
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

# Set up a modulefile for a single tag
define multiinstall::chooser::modulefile_tag (
  $install_path,
  $module_path,
  $template,
  $options,
) {
  $tag = $name

  file {"${module_path}/${tag}":
    ensure  => file,
    content => template($template),
  }
}

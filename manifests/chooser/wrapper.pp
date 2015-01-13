## \file    manifests/chooser/wrapper.pp
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

# Install a script to choose between the different installed tags. The options
# can be used by the template to choose the correct version to use
define multiinstall::chooser (
  $install_path,
  $install_tags,
  $default_tag,

  $template = 'multiinstall/wrapper.erb',
  $options  = {},
) {

  file {"${install_path}/bin/${name}":
    content => template($template),
  }

}

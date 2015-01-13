## \file    manifests/vcsrepo_install.pp
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

# Install from a version controlled repository
define multiinstall::vcsrepo_install (
  $tag,
  $tag_install_path,

  $repository_type,
  $repository,
) {

  # Check out the local copy
  vcsrepo {$tag_install_path:
    ensure   => latest,
    provider => $repository_type,
    source   => $repository,
    revision => $tag,
  }

}

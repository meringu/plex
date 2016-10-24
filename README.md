# plex Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/plex.svg?style=flat)](https://supermarket.chef.io/cookbooks/plex)
[![Build Status](https://travis-ci.org/meringu/plex.svg?branch=master)](https://travis-ci.org/meringu/plex)

Installs the latest version of Plex from the Plex downloads API.

# Requirements

Fedora, Debian or RHEL family Linux

# Usage

## Quick start

Add `recipe[plex]` to your run_list to install/upgrade to the latest version of
Plex media server

## Recipes

### default.rb

Installs, starts, and enables Plex media server.

### disable_pms.rb

Disables Plex media server.

### enable_pms.rb

Enables Plex media server.

### install_pms.rb

Installs Plex media server.

### restart_pms.rb

Restarts Plex media server.

### start_pms.rb

Starts Plex media server.

### stop_pms.rb

Stops Plex media server.

### uninstall_pms.rb

Uninstalls Plex media server.

## Attributes

|             Attribute              | Default |                                                Description                                                 |
|:----------------------------------:|:-------:|:----------------------------------------------------------------------------------------------------------:|
|     `node['plex']['channel']`      |  `nil`  |                   Set to `'plexpass'` to use the Plex Pass version of Plex media server                    |
|      `node['plex']['token']`       |  `nil`  | If you set `channel` to `'plexpass`' this be the value the `X-Plex-Token` header when logged in to plex.tv |
| `node['plex']['service_provider']` |  `nil`  |           Override the service provider chef uses to interact with the Plex media server service           |
|      `node['plex']['source']`      |  `nil`  |                        Override to install from a custom location to pin a version                         |

## Resources and Providers

### plex_media_server.rb

Manages the Plex media server installation

#### Actions

Default: `install`, `enable`, `start`

- `enable`
- `install`
- `restart`
- `start`
- `stop`
- `uninstall`

#### Attributes

- `channel` - Set to `'plexpass'` to use the Plex Pass version of Plex media server
- `token` - If you set `channel` to `'plexpass'` this be the value the `X-Plex-Token` header when logged in to plex.tv
- `service_provider` - Override the service provider chef uses to interact with the Plex media server service
- `source` - Override to install from a custom location to pin a version

# Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License & Authors

Author: Henry Muru Paenga (meringu@gmail.com)

```
Copyright 2016 Henry Muru Paenga <meringu@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

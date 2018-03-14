# Hassio Node-Red addons By Charley

## Description
a Node-Red addon support Custom Package

if you like what you're seeing! give me a smoke,tks. :)

![Donation](https://raw.githubusercontent.com/charleyzhu/HomeAssistant_Components/master/Images/Donation.png)

# Install

1. Add my Repository (https://github.com/charleyzhu/hassio-addons) To your Hass.io
2. Install the "Node-RED" add-on
3. (Optional) if you use HomeKit ,set packages like this
    ```json
    {
    "log_level": "info",
    "avahi_interfaces": "",
    "avahi_hostname": "",
    "avahi_domainname": "local",
    "enable_ipv6": true,
    "boot_commands": [],
    "packages": [
        "make",
        "g++",
        "avahi-compat-libdns_sd",
        "python",
        "avahi-dev",
        "py-rpigpio"
    ],
    "init_commands": [],
    "plugins": [],
    "ssl": false,
    "certfile": "fullchain.pem",
    "keyfile": "privkey.pem",
    "users": [
        {
        "username": "admin",
        "password": "password",
        "permissions": "*"
        }
    ],
    "http_node_user": [
        {
        "username": "admin",
        "password": "password"
        }
    ],
    "projects": false
    }
    ```

4. (Optional) To enable SSL support, set SSL to true
    ```json
    {
    "log_level": "info",
    "avahi_interfaces": "",
    "avahi_hostname": "",
    "avahi_domainname": "local",
    "enable_ipv6": true,
    "boot_commands": [],
    "packages": [],
    "init_commands": [],
    "plugins": [],
    "ssl": true,
    "certfile": "fullchain.pem",
    "keyfile": "privkey.pem",
    "users": [
        {
        "username": "admin",
        "password": "password",
        "permissions": "*"
        }
    ],
    "http_node_user": [
        {
        "username": "admin",
        "password": "password"
        }
    ],
    "projects": false
    }
    ```
5. (Optional) Disable IDE authentication by removing all users from users array
    ```json
    {
    "ssl": true,
    "certfile": "fullchain.pem",
    "keyfile": "privkey.pem",
    "users": [
    ],
    "projects": false
    }
    ```
6. (Optional) Disable HTTP Node (Dashboard UI) authentication by removing the user from http_node_user
    ```json
    {
    "ssl": true,
    "certfile": "fullchain.pem",
    "keyfile": "privkey.pem",
    "http_node_user": [
    ],
    "projects": false
    }
    ```
7. (Optional) Add additional IDE users to users array. Use permission of read to grant read-only permissions to additional users.
    ```json
    {
    "ssl": true,
    "certfile": "fullchain.pem",
    "keyfile": "privkey.pem",
    "users": [
        {
        "username": "admin",
        "password": "password",
        "permissions": "*"
        },
        {
        "username": "user2",
        "password": "password2",
        "permissions": "read"
        }
    ],
    "projects": false
    }
    ```
8. (Optional) Enable projects feature in v0.18.x by setting `projects` to `true`. Refer to [Node-RED Projects](https://nodered.org/docs/user-guide/projects/) for additional info about setting up projects.
    ```json
    {
      "ssl": true,
      "certfile": "fullchain.pem",
      "keyfile": "privkey.pem",
      "users": [
        {
          "username": "admin",
          "password": "password",
          "permissions": "*"
        }
      ],
      "http_node_user": [
        {
          "username": "admin",
          "password": "password"
        }
      ],
      "projects": true
    }
    ```
9. Start the "Node-RED" add-on
10. (Optional) Configure [panel_iframe](https://home-assistant.io/components/panel_iframe/) component to embed Node-RED UI into Home Assistant UI using this example:

    ```yaml
    panel_iframe:
      nodered_flows:
        title: 'Node-RED Flows'
        url: 'http://hassio.local:1880'
        icon: mdi:nodejs
    ```

11. (Optional) If you install [Node-RED Dashboard](https://github.com/node-red/node-red-dashboard) in Node-RED, you can expose the dashboard in the [Hass.io](https://home-assistant.io/hassio/) UI using this example to your [panel_iframe](https://home-assistant.io/components/panel_iframe/) section:

    ```yaml
    panel_iframe:
      nodered_ui:
        title: 'Node-RED Dashboard'
        url: 'http://hassio.local:1880/ui'
        icon: mdi:nodejs
    ```

12. (Optional) Install [node-red-contrib-home-assistant](https://flows.nodered.org/node/node-red-contrib-home-assistant) from Manage Palette window. After install place some HA node to flow and setup HA server for it. As you are running Node-RED inside Hass.io addon/container you can use Hass.io API Proxy address `http://hassio/homeassistant` as Home Assistant server address (server node Base URL). This way you don't need any real network address.

## Support

Please use [Github Issues](https://github.com/charleyzhu/hassio-addons/issues) for feedback.

## Changelog

### 0.1.0 (2017-07-31)
#### Initial Release

# 中文
## 简介
hass.io 的Node-Red插件 支持启动安装系统组件

如果你感觉这个组件对你有所帮助请赐我根烟 :）

![Donation](https://raw.githubusercontent.com/charleyzhu/HomeAssistant_Components/master/Images/Donation.png)

# 安装

1. 在hass.io 的 ADD-ON STORE 选项卡添加我的插件仓库 (https://github.com/charleyzhu/hassio-addons)
2. 选择 Node-Red 组件安装
3. (可选) 如果你需要使用HomeKit请将packages组数设置为这样
    ```json
    {
    "log_level": "info",
    "avahi_interfaces": "",
    "avahi_hostname": "",
    "avahi_domainname": "local",
    "enable_ipv6": true,
    "boot_commands": [],
    "packages": [
        "make",
        "g++",
        "avahi-compat-libdns_sd",
        "python",
        "avahi-dev",
        "py-rpigpio"
    ],
    "init_commands": [],
    "plugins": [],
    "ssl": false,
    "certfile": "fullchain.pem",
    "keyfile": "privkey.pem",
    "users": [
        {
        "username": "admin",
        "password": "password",
        "permissions": "*"
        }
    ],
    "http_node_user": [
        {
        "username": "admin",
        "password": "password"
        }
    ],
    "projects": false
    }
    ```

4. (可选) 开启SSL(HTTPS)支持请将ssl设置为true
    ```json
    {
    "log_level": "info",
    "avahi_interfaces": "",
    "avahi_hostname": "",
    "avahi_domainname": "local",
    "enable_ipv6": true,
    "boot_commands": [],
    "packages": [],
    "init_commands": [],
    "plugins": [],
    "ssl": true,
    "certfile": "fullchain.pem",
    "keyfile": "privkey.pem",
    "users": [
        {
        "username": "admin",
        "password": "password",
        "permissions": "*"
        }
    ],
    "http_node_user": [
        {
        "username": "admin",
        "password": "password"
        }
    ],
    "projects": false
    }
    ```
5. (可选) 如果你想禁用Web页面的用户认证请删除users数组中的对象来禁用验证，如下
    ```json
    {
    "ssl": true,
    "certfile": "fullchain.pem",
    "keyfile": "privkey.pem",
    "users": [
    ],
    "projects": false
    }
    ```
6. (可选) 如果你想禁用Dashboard UI页面的用户认证请删除http_node_user数组中的对象来禁用验证，如下
    ```json
    {
    "ssl": true,
    "certfile": "fullchain.pem",
    "keyfile": "privkey.pem",
    "http_node_user": [
    ],
    "projects": false
    }
    ```
7. (可选) 如果你想设置一个用户只读用户可以参考users数组中的user2用户的permissions选项
    ```json
    {
    "ssl": true,
    "certfile": "fullchain.pem",
    "keyfile": "privkey.pem",
    "users": [
        {
        "username": "admin",
        "password": "password",
        "permissions": "*"
        },
        {
        "username": "user2",
        "password": "password2",
        "permissions": "read"
        }
    ],
    "projects": false
    }
    ```
8. (可选) 启用projects功能（v0.18.x）设置 projects true 参考 [Node-RED Projects](https://nodered.org/docs/user-guide/projects/)
    ```json
        {
        "ssl": true,
        "certfile": "fullchain.pem",
        "keyfile": "privkey.pem",
        "users": [
            {
            "username": "admin",
            "password": "password",
            "permissions": "*"
            }
        ],
        "http_node_user": [
            {
            "username": "admin",
            "password": "password"
            }
        ],
        "projects": true
        }
    ```
9. 点击Start启动插件
10. (可选)配置 [panel_iframe](https://home-assistant.io/components/panel_iframe/) 将Node-Red 嵌入到Home Assistant:

    ```yaml
    panel_iframe:
      nodered_flows:
        title: 'Node-RED Flows'
        url: 'http://hassio.local:1880'
        icon: mdi:nodejs
    ```

11. (可选) 如果你安装了[Node-RED Dashboard](https://github.com/node-red/node-red-dashboard) 可以将:Node-RED Dashboard嵌入到Home Assistant：

    ```yaml
    panel_iframe:
      nodered_ui:
        title: 'Node-RED Dashboard'
        url: 'http://hassio.local:1880/ui'
        icon: mdi:nodejs
    ```

12. (可选) 安装 [node-red-contrib-home-assistant](https://flows.nodered.org/node/node-red-contrib-home-assistant) 调用 Home Assistant

## 反馈

如果你是使用中遇到了问题请到 [BBS](https://bbs.hassbian.com/thread-3065-1-1.html) 反馈

## 更新日志

### 0.1.0 (2018-03-14)
#### Initial Release

# About

EndpointOSC is a simple but powerful endpoint checker tool. It basically checks the given endpoints and alerts when error occured. Also it integrated with Telegram API that tool can send error alerts via Telegram Bot.


# Usage

```bash
endpointosc
```
With custom configuration file

```bash
endpointosc -f /path/to/file
```

# Requirments

 - Python 3.9 or above
 - noarch




# Installation

- Pre installation:
    `apt|yum|pkg  install python3-dev python3-pip`

- In Debian-based distibution, you can simply install the `.deb` package by running:

    `dpkg -i endpointosc-1.0.deb`

- For other distibutions:

    `mv ./usr/bin/endpointosc /usr/bin/endpointosc && chmod +x /usr/bin/endpointosc`

- Post installation (Optional)

    Create service file for command
        
        Example service file:

        `[Unit]
         Description=EndpointOSC Tool
         After=network.target

         [Service]
         Type=simple
         ExecStart=/usr/bin/endpointosc
         Restart=always
         RestartSec=10
         TimeoutStartSec=30
         TimeoutStopSec=30

         [Install]
         WantedBy=multi-user.target
            `


    
# Configuration file

Configuration file of the tool is located at:

`/etc/endpointosc/endpointosc.yml`

Example config:

```
endpoints:
  facebook: https://facebook.com
  google: https://google.com
general:
  interval: 5
  log_file: /var/log/endpointosc/endpointosc.log
  log_level: info
  reminder_interval: 60
telegram:
  bot_token: 0
  chat_id: 0
  enabled: 0
```


- "General" block

    - **interval** - Interval of checking each endpoint individually
    - **log_file** - Path of log file
    - **log_level** - classification of the severity of log messages generated by the tool

        - info - Both error and info logs
        - error  - Only error messages
    - **reminder_interval** - Inter of checking the endpoint that unavaliable.


- "Telegram" block

    Credentials of Telegram BOT

    Detailed information:

    [Telegram Bot API](https://core.telegram.org/bots/api)

    - **enabled**
      
      - **1** - Enable bot
      - **0** - Disable bot

    
    
## License

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)

## Support

For support, email info@sabirrajabov.com.



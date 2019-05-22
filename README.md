# ROOTSH CLOSE AND CLEAR

Script to close rootsh sessions and strip ANSI escape codes for Splunk consumption

## Requirements

- rootsh
- ansifilter


## Installation

```bash
cd /usr/src
wget https://github.com/josegof/rootsh_clear/archive/v1.0.zip
unzip master.zip
cp rootsh_clear-master/ansifilter_{linux or solaris} /usr/local/bin/ansifilter
cp rootsh_clear-master/rootsh_clear.sh {scripts_dir}/rootsh_clear.sh
```

## Usage

Place a cronjob with rootsh_clear.sh every 5 minutes


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)

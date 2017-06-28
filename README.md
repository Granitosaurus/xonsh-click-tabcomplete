# xonsh-click-tabcomplete
Tab completion for python applications based on [click cli framework.](http://click.pocoo.org)

<hr>

![PyPi version](https://img.shields.io/pypi/v/xonsh-vox-tabcomplete.svg?style=flat-square)
![PyPi license](https://img.shields.io/pypi/l/xonsh-vox-tabcomplete.svg?style=flat-square)
![PyPi license](https://img.shields.io/pypi/pyversions/xonsh-vox-tabcomplete.svg?style=flat-square)

This tab completion utilises generic --help messages of `click` framework 
to create command, subcommand and flag tab completion for any application 
that uses this framework.


## Installation

Installation via PIP:
```console
pip install xonsh-click-tabcomplete
```
or you can clone the repo via pip for the latest version
```console
pip install git+<this repo url>
```

## Configuration
To automatically load vox completion at startup, put
```console
xontrib load click_tabcomplete
```

in your `~/.xonshrc` file.

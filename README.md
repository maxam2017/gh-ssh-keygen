# gh-ssh-keygen
![banner](https://user-images.githubusercontent.com/25841814/193448112-34771b2c-b6db-493e-a6f4-b5e6466e496e.png)

## Install (on MacOS)

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/maxam2017/gh-ssh-keygen/HEAD/install.sh)"
```

## Usage
```sh
gh-ssh-keygen
````

or use once (without installation)
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/maxam2017/gh-ssh-keygen/HEAD/gh-ssh-keygen.sh)"
```

## Demo

https://user-images.githubusercontent.com/25841814/193447268-fd6e5e28-2e26-48f3-bd90-9c330bbd510a.mp4

## Manual

```
NAME
     gh-ssh-keygen 🔑 - adding a new SSH key to your GitHub account automatically

VERSION
     0.0.1

SYNOPSIS
     gh-ssh-keygen [-hv]

DESCRIPTION
     Want to enable authentication for Git operations over SSH?
     This script helps you generate a SSH key on your local machine and add the key to your account on GitHub.com.
     See more detail on GitHub official document - https://docs.github.com/en/authentication/connecting-to-github-with-ssh


     The following options are available:

     -h     show this message
     -v     get the version

ENVIRONMENT
     Currently only works on MacOS.

AUTHOR
     maxam2017 🦕
```

## Uninstall

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/maxam2017/gh-ssh-keygen/HEAD/uninstall.sh)"
```

## License
Distributed under the MIT License. See license for more information.

# gh-ssh-keygen
Adding a new SSH key to your GitHub account automatically. (MacOS only)

## Install

```sh
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/maxam2017/gh-ssh-keygen/HEAD/install.sh)"
```

## Usage
```sh
$ gh-ssh-keygen
````

or use once (without installation)
```sh
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/maxam2017/gh-ssh-keygen/HEAD/gh-ssh-keygen.sh)"
```

## manual

```
NAME
     gh-ssh-keygen 🔑 - adding a new SSH key to your GitHub account automatically

SYNOPSIS
     gh-ssh-keygen [-h]

DESCRIPTION
     Want to enable authentication for Git operations over SSH?
     This script helps you generate a SSH key on your local machine and add the key to your account on GitHub.com.
     See more detail on GitHub official document - https://docs.github.com/en/authentication/connecting-to-github-with-ssh

     The following options are available:

     -h     Print this Help.

ENVIRONMENT
     Currently only works on MacOS.

AUTHOR
     maxam2017 🦕
```

## License
Distributed under the MIT License. See license for more information.
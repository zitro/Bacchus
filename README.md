# Bacchus
Managing Wine prefixes can be somewhat daunting for a newcomer and the existing GUI utilities, in my opinion, are either needlessly confusing or simply nonfunctional. Bacchus is my attempt to create a simple Wine management utility that actually works.

## Current Features
* Installing software from a directory

* Installing software from a setup.exe file

## Planned Features
* Installing software from a self-contained exe file.

* Application management. Bacchus will manage all of your installed applications for you so you don't need to remember which application you installed in which prefix and how to launch it.

* An install.rb script so you don't have to make all of the dotfiles yourself.

## Dependencies
Ruby, bash, winetricks

## Supported Platforms
Currently only tested on macOS, however Linux and *BSD will both be supported as well. Windows is probably supported through the Linux subsystem but I'm not sure why you would want to run Wine on Windows (I am in no rush to test it).

## Contributing
I am currently not accepting pull requests but am definitely interested in hearing your complaints or suggestions. Feel free to write up an issue and I'll see what I can do.

I will be accepting pull-requests for presets files once that functionality is more developed.

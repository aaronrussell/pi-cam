# Pi Cam

So, you've got a Raspberry Pi with the CSI camera module and you want to run it permantly, capturing full HD video and streaming it over the web, huh?

This repo provides a collection of scripts and resources to do just that. The quality is stunning and the little Pi barely breaks a sweat.

## Credit where it's due

All of the hard work getting the Pi to stream using HLS was been done by [Andy Armstrong](https://github.com/AndyA/) over on the [Raspberry Pi forums](http://www.raspberrypi.org/phpBB3/viewtopic.php?f=38&t=45893). Andy also created [psips](https://github.com/AndyA/psips), which does some technical jiggery pokery to the h264 stream required by the HLS protocol.

## Status

A work in progress. More info coming soon.

## Todos

* Write this README
* Snazz up the web front end
* Create init script for daemonizing the shell script
# Dockerized Specify 6 Desktop UI

This repo contains materials to build an image with Specify 6 using Docker.

## Dependencies

The dependencies are:

1. git, make, docker, docker-compose (v1.8)
1. OpenJDK 8 (JRE)
1. X11 socket for GUI-launch of Specify 6

## Background

This project is intended to be used along with the `dina/specify-media` component which is a dockerized version of `web-asset-server` from Specify Software, available from GitHub.

## Usage

Use "make up" to bring up the services.

In Specify 6 GUI, use the relevant user/pass credentials pair at the first login...

Determine the user/pass credentials by "make get<TAB>", ie the "get-s6-login" target in the Makefile...

Then use "db" for the database server name, "specify6" for the database name and "ben" for the master user, unless you have other settings in your .env-file and in the s6init.sql file...

## GOTCHAs

Run "export $(cat .env | xargs) > /dev/null" and your Makefile will be aware of environment settings in the .env-file...

## TODO

Add mysql_config_edotr stuff from here:

http://stackoverflow.com/questions/20751352/suppress-warning-messages-using-mysql-from-within-terminal-but-password-written/22933056#22933056


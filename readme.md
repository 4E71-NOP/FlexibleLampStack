# A flexible LAMP stack

This projet goal is to help web developpers to test their creations in many different configurations (ex: PHP5 / PHP7 etc.). 

# Installation
* Clone this repository on your local computer
* Go to the `./script` folder and run : `./buildComposer.sh 'php74 mariadb'`
* Run the command : `docker-compose build`.
* Run the command : `docker-compose up`.

# Configuration and Usage
## General Information
This Docker Stack is built for local development and **not** for production usage. And as repetition is the key to pedagogy : YOU DO **NOT** USE IT FOR PRODUCTION.


## Configuration

To configure the composer you can edit the files in `./script/dc/` and `./script/env`. By default the defined directory which will be used in the volume entries are set to `./data/xxxx`. Ex: mariadb is set to : `./data/mariadb`. You can change it at will of course. 

Do **not** edit `docker-compose` and `.env` files directly as it will be overwritten as soon as you use the `/buildComposer.sh` script. We'll see that in the next section.

Example: if you want to set mysql in another directory. Edit `./script/env/env-mysql.env` and set MYSQL_DATA_DIR and MYSQL_LOG_DIR to a directory of your liking. Then execute `/buildComposer.sh`.


## Usage 

There is a set of options to tell the script how to 'assemble' the docker-compose file and .env file. Those 'options' are sent to the script as a single string (between quotes). 

Options:

* **[php54; php56; php71; php72; php73; php74]** adds an apache-php service with mysql, postgres and gd (image stuff) extensions.
* **[mysql; mysql8; mariadb]** adds mysql 5.7, 8 or mariadb. Note that the script forbids the use of 2 services sharing the same default port (3306 in this case). So you cannot do : `./buildComposer.sh 'php74 mariadb mysql'`. It will exit with an error.
* **postgres** adds postgresSQL
* **redis** adds redis
* **phpmyadmin** adds phpmyadmin
* **adminer** adds adminer
* **mc** adds opsenSSH + Midnight Commander (login/pass mc/mc)
* **pure-ftpd** adds pure-ftp server (login/pass flexible/flexible)

# How to go further ?
Open 2 terminals (it's better that way) on the project directory. On the first terminal, change directory to ***./script***. Then use the `buildComposer` script like the following.
```sh
meMyselfAndI@mypc:mydir$ ./buildComposer.sh 'php74 mariadb phpmyadmin'
```
Then on the second terminal you should see 2 new files when listing files:
 - docker-compose.yml 
 - .env

Do:
```sh
meMyselfAndI@mypc:mydir$ docker-compose build ; docker-compose up
```
Watch the logs scroll upward on the terminal for a moment and then it's up. Use the `-d` option if you want to 'detach' the docker-compose command.

Break execution with `CTRL-C` (or stop it if it's detached `docker-compose down`).

Then go back on the first terminal and change the previous command a little bit. 
```sh
meMyselfAndI@mypc:mydir$ ./buildComposer.sh 'php56 mariadb phpmyadmin'
```
List files (ls) in the second terminal. Now both *docker-compose* and *.env* files have been updated. Build & Up again. 

---

# Make sure it works
in `/data/www/html` there are 5 files. Those files will help you test everything is okay.
* gd_image.php
* gd_imagettf.php
* index.html
* info.php
* phpcapabilitiestest.php

You can test 3 URIs from http://localhost
* [index.html](http://locahost/index.html) is a simple html file. If many things go wrong, going back to HTML is good.
* [info.php](http://locahost/info.php) is a standart **`php_info()`** which will output a complete info about PHP.
* [phpcapabilitiestest.php](http://locahost/phpcapabilitiestest.php) is a test page including a connexion to mysql and postgres, and a GD drawing test. 

You can remove those files as well when all is ok for you. Then it's about configuration of volumes to suit your needs.

# Notes:

The first times you run the docker-compose command, the system will download and build everything. It can take some time depending on the bandwith you have. Most of the time it wont take more than 5 minutes for a ADSL connexion. 

As you are building different configurations, if you re-use a previously built container image it will be mush faster to start. So one way to save time in the future is to build many different configurations.

Example:
```sh
meMyselfAndI@mypc:mydir$ ./buildComposer.sh 'php54 mariadb postgress redis phpmyadmin adminer mc'
meMyselfAndI@mypc:mydir$ ./buildComposer.sh 'php56 mysql'
meMyselfAndI@mypc:mydir$ ./buildComposer.sh 'php71 mysql8'
meMyselfAndI@mypc:mydir$ ./buildComposer.sh 'php72 mysql8'
meMyselfAndI@mypc:mydir$ ./buildComposer.sh 'php73 mysql8'
meMyselfAndI@mypc:mydir$ ./buildComposer.sh 'php74 mysql8'
```
Make sure you build with docker-compose each time you change something. 

 ## Commented options

There is a number of evironement variables lines that are commented in the script/dc/dc-xxx.yml files. Those are not necessary for standart use. But if needed the user can enable those evironment variables.

## Directory separation

The volumes for each database type is voluntarly separated (ex: mysql(5.7), mysql8 & mariadb). This to prevent problems with data corruption. mysql can be sensitive and crash (like "something went horribly wrong" as mysql says).

## GD (php extension)
The font directory is usually empty on docker. If you want to use fonts with GD you will need to declare a path/volume to your font directories or to copy those files were you need it (var/www/html/ etc..).

# Future
* Include vsftpd
* Include some CMS like wordpress, dupral etc.

I'm open to suggestions. Feel free to open a request in the corresponding section of this depot. 

# Bugs
I'll do my best to help. 


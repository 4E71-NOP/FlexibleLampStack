
[license-link]: https://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[shield-png]: https://img.shields.io/badge/Licence-CC--BY--NC--SA-lightgrey
[downloads-badge]: https://img.shields.io/badge/Downloads-who%20cares%3F-green
[language-badge]: https://img.shields.io/badge/Language-Bash/Docker%20Compose-blue

[![CC BY-NC-SA 4.0][shield-png]][license-link]
![downloads-badge]
![language-badge]

# A flexible LAMP stack

This projet goal is to help web developpers to test their creations in many different configurations (ex: PHP5/7/8, MySQL/Postgres etc.). 

# Installation
* Clone this repository on your local computer
* Go to the `./script` folder and run : `./buildComposer.sh 'php74 mariadb'`
* Go back one level `cd ..`
* Run the command : `docker-compose build`.
* Run the command : `docker-compose up`.
* You're done.

# Heavy duty installation 
For those who want to build everything as fast as possible use the `hdi.sh` script. Depending on your connexion speed it will take some time. But after a while all images will be ready and you will be able to use `buildComposer` to setup the stack you want.

# Configuration and Usage
## General Information
This Docker Stack is built for local development and **not** for production usage. And as repetition is the key to pedagogy : YOU DO **NOT** USE IT FOR PRODUCTION.

* **Why ?** : The default behavior of those applications / containers is considered as loose in terms of security. Ex: this `php.ini` doesn't have a `'display_errors = 0'` entry which is considered as a security risk. You can add it of course. But by default PHP diplays errors. Also this project use configured password. It is safe to say you need to change that, right ?
* **Should I set those for you ?**  : No! Because you're supposed to know what to do about it, it's not the project goal, and nobody can do that as everyone has different needs. 

So by default and if you are using the default values. **Do not use this in production.**

## Configuration

To configure the composer you can edit the files in `./script/dc/` and `./script/env`. By default the defined directory which will be used in the volume entries are set to `./data/xxxx`. Ex: mariadb is set to : `./data/mariadb`. You can change it at will of course. 

Do **not** edit `docker-compose` and `.env` files directly as it will be overwritten as soon as you use the `/buildComposer.sh` script. We'll see that in the next section.

Example: if you want to set mysql in another directory. Edit `./script/env/env-mysql.env` and set MYSQL_DATA_DIR and MYSQL_LOG_DIR to a directory of your liking. Then execute `/buildComposer.sh 'php74 mysql'`.


## Usage 

There is a set of options to tell the script how to 'assemble' the docker-compose file and .env file. Those 'options' are sent to the script as a single string (between quotes). 

Options:

* **[php54; php56; php71; php72; php73; php74; php80]** adds an apache-php service with mysql, postgres and gd (image stuff) extensions.
* **[mysql; mysql8; mariadb]** adds mysql 5.7, 8 or Mariadb. Note that the script forbids the use of 2 services sharing the same default port (3306 in this case). So you cannot do : `./buildComposer.sh 'php74 mariadb mysql'`. It will exit with an error.
* **postgres** adds postgresSQL
* **redis** adds redis
* **phpmyadmin** adds phpmyadmin (see `Notes on using services`)
* **adminer** adds adminer (see `Notes on using services`)
* **mc** adds opsenSSH + Midnight Commander (see `Notes on using services`)
* **pure-ftpd** adds pure-ftp server (see `Notes on using services`)
* **nocheck** special option to bypass checks. It means you can run both mariadb and mysql for example. But it will work only if you configure the containers/dc-files/env-files **properly** to avoid running services on the same ports.

### Notes on using services 
Some services require login/pass to connect to. Do as follow
* **mysql** A default database is set on the mysql service. Connect to phpmyadmin with: host 'mysql', port '3306', dbname 'docker', user 'docker', password '1a2b3c4d'. This user is the standart readonly user. The `superUser` account use the same password. 
* **postgres** A default database is set on postgres. Connect with adminer with: host 'postgres', port '5432', dbname 'docker', user 'docker', password '1a2b3c4d'
* **mc** Connect to your localhost like this `ssh -l mc <your.local.server.IP> -p 2222`. Then use the password 'mc'.
* **pure-ftpd** Connect to the FTP service with any FTP sotware and use login: 'flexible', password 'flexible'



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
* [phpcapabilitiestest.php](http://locahost/phpcapabilitiestest.php) is a test page including a connexion to mysql and postgres, and a GD drawing test. Expect errors if no mysql or postgres service is up.

You can remove those files as well when all is ok for you. Then it's about configuration of volumes to suit your needs. Or creating a symlink pointing to the directory of your choice.


# Notes:

The first times you run the docker-compose command, the system will download and build everything. It can take some time depending on the bandwith you have. Most of the time it wont take more than 5 minutes for a ADSL connexion. 

As you are building different configurations, if you re-use a previously built container image it will be much faster to start. So one way to save time in the future is to build many different configurations.

Example:
```sh
meMyselfAndI@mypc:mydir$ ./buildComposer.sh 'php54 mariadb postgress redis phpmyadmin adminer mc'
meMyselfAndI@mypc:mydir$ cd ..
meMyselfAndI@mypc:mydir$ docker-compose build
meMyselfAndI@mypc:mydir$ cd script/
meMyselfAndI@mypc:mydir$ ./buildComposer.sh 'php56 mysql'
meMyselfAndI@mypc:mydir$ cd ..
meMyselfAndI@mypc:mydir$ docker-compose build
[...]
meMyselfAndI@mypc:mydir$ cd ..
meMyselfAndI@mypc:mydir$ docker-compose build
meMyselfAndI@mypc:mydir$ cd script/
meMyselfAndI@mypc:mydir$ ./buildComposer.sh 'php74 mysql8'
meMyselfAndI@mypc:mydir$ cd ..
meMyselfAndI@mypc:mydir$ docker-compose build
```
Make sure you build with docker-compose each time you change something. 

Also see **Heavy duty installation** above for a complete build.

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


# License details

[![CC BY-NC-SA 4.0][shield-png]][license-link]

This work is licensed under a : 
[Creative Commons Attribution 4.0 International License][license-link].


[![CC BY-NC-SA 4.0][cc-image]][license-link]


See more details in the the `license.md` file. 

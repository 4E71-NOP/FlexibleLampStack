#/bin/bash

echo "Building everything."
scriptFolder="script"

cd $scriptFolder
./buildComposer.sh 'php80 mysql postgres redis phpmyadmin adminer mc pure-ftpd'
cd ..
docker-compose build

cd $scriptFolder
./buildComposer.sh 'php74 mysql8'
cd ..
docker-compose build

cd $scriptFolder
./buildComposer.sh 'php73 mariadb'
cd ..
docker-compose build

cd $scriptFolder
./buildComposer.sh 'php72 mariadb'
cd ..
docker-compose build

cd $scriptFolder
./buildComposer.sh 'php71 mariadb'
cd ..
docker-compose build

cd $scriptFolder
./buildComposer.sh 'php56 mariadb'
cd ..
docker-compose build

cd $scriptFolder
./buildComposer.sh 'php54 mariadb'
cd ..
docker-compose build

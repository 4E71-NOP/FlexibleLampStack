#/bin/bash
echo -e "\n\e[46m\e[1m                    BuidlComposer.sh                    \e[21m\e[49m\e[39m\e[m"

if [ ${#1} = 0 ]; then
    echo -e "\e[1m\e[101mERROR :\e[0m No arguments were given.";
    echo -e "Please use this script like the following example:";
    echo -e "\e[2m./buildComposer.sh 'php73 mariadb phpmyadmin' \e[0m(between quotes as a list)";
    exit 1
else 
    echo -e "Building \e[1m\docker-compose.yml\e[0m file.";
    echo -e "Argument list contains : \e[1m"$1"\e[0m.";
    nockeck=0;
    phpVrs="";
    mysqlVrs="";
    mariadbVrs="";
    postgresVrs="";
    redisVrs="";
    phpmyadminVrs="";
    adminerVrs="";
    mcVrs="";
    vsftpdVrs="";
    pureftpdVrs="";
    svcMysql=0;
    svcFtp=0
    optionList='php54 php56 php71 php72 php73 php74 mariadb mysql mysql8 postgress redis phpmyadmin adminer mc pure-ftpd nocheck';
    for A in $1
    do
        optionMatch=0;
        # echo "O="$O" ; A="$A;
            case $A in
            "nocheck")
                nockeck=1
                optionMatch=1;
                ;;
            "php54"|"php56"|"php71"|"php72"|"php73"|"php74")
                phpVrs=$A
                optionMatch=1;
                ;;
            "mariadb")
                mariadbVrs=$A
                optionMatch=1;
                svcMysql=$((svcMysql+1));
                ;;
            "mysql"|"mysql8")
                mysqlVrs=$A
                optionMatch=1;
                svcMysql=$((svcMysql+1));
                ;;
            "postgres")
                postgresVrs=$A
                optionMatch=1;
                ;;
            "redis")
                redisVrs=$A
                optionMatch=1;
                ;;
            "phpmyadmin")
                phpmyadminVrs=$A
                optionMatch=1;
                ;;
            "adminer")
                adminerVrs=$A
                optionMatch=1;
                ;;
            "mc")
                mcVrs=$A
                optionMatch=1;
                ;;
            "vsftpd")
                vsftpdVrs=$A
                optionMatch=1;
                svcFtp=$((svcFtp+1));
                ;;
            "pure-ftpd")
                pureftpdVrs=$A
                optionMatch=1;
                svcFtp=$((svcFtp+1));
                ;;
            esac
        if [ $optionMatch -eq 0 ]; then 
            echo -e "\e[1m\e[101mERROR : \e[0mArgument '"$A"' is not in the available option list."
            exit 1
        fi
    done

    if [ $nockeck -eq 0 ]; then 
        # Checking one or two things before we begin
        if [ ${#phpVrs} == 0 ]; then
            echo -e "\e[1m\e[101mERROR :\e[0m option list need at least a PHP version and database type."
            exit 1
        fi

        if (( $svcFtp == 2 )); then
            echo -e "\e[1m\e[101mERROR :\e[0m Both vsftpd and pure-ftp are enabled. Please remove one of them."
            exit 1
        fi

        if (( $svcMysql == 2 )); then
            echo -e "\e[1m\e[101mERROR :\e[0m Both mariadb and mysql are enabled. Please remove one of them."
            exit 1
        fi
    else
        echo -e "\e[5m\e[1m\e[46m** WARNING **\e[25m\e[93m : You used the 'nocheck' option. It means you're SUPPOSED TO KNOW WHAT YOU'RE DOING. Right?\e[0m"
    fi
    # Everything seems ok so far so we continue
    echo "Copying initial files";
    if [ -f "./docker-compose.yml" ]; then 
        rm ./docker-compose.yml 
    fi 
    if [ -f "./.env" ]; then 
        rm ./.env 
    fi 
    cp ./dc/dc-begin.yml docker-compose.yml
    cp ./env/env-begin.env .env

    # Environment for PHP
    echo "Adding PHP";
    cat ./dc/dc-php.yml >> docker-compose.yml
    cat ./env/env-php.env >> .env
    sed -i "s/phpVrsString/"$phpVrs"/g" .env

    # Environment for mysql
    if [ ${#mysqlVrs} != 0 ]; then
        echo "Adding mysql"
        cat ./dc/dc-mysql.yml >> docker-compose.yml
        cat ./env/env-mysql.env >> .env
        sed -i "s/mysqlVrsString/"$mysqlVrs"/g" .env
    fi

    # Environment for mariadb
    if [ ${#mariadbVrs} != 0 ]; then
        echo "Adding mariadb"
        cat ./dc/dc-mariadb.yml >> docker-compose.yml
        cat ./env/env-mariadb.env >> .env
        sed -i "s/mariadbVrsString/"$mariadbVrs"/g" .env
    fi

    # Postgres
    if [ ${#postgresVrs} != 0 ]; then
        echo "Adding postgres"
        cat ./dc/dc-postgres.yml >> docker-compose.yml
        cat ./env/env-postgres.env >> .env
        sed -i "s/postgresVrsString/"$postgresVrs"/g" .env
    fi

    # Redis
    if [ ${#redisVrs} != 0 ]; then
        echo "Adding redis"
        cat ./dc/dc-redis.yml >> docker-compose.yml
        cat ./env/env-redis.env >> .env
    fi

    # Midnight Commander
    if [ ${#mcVrs} != 0 ]; then
        echo "Adding mc"
        cat ./dc/dc-mc.yml >> docker-compose.yml
        cat ./env/env-mc.env >> .env
        sed -i "s/mcVrsString/"$mcVrs"/g" .env
    fi

    # PHPMyAdmin
    if [ ${#phpmyadminVrs} != 0 ]; then
        echo "Adding PHPMyAdmin (PHPMyAdmin is on the port 8080)"
        cat ./dc/dc-phpmyadmin.yml >> docker-compose.yml
        cat ./env/env-phpmyadmin.env >> .env
        sed -i "s/phpmyadminVrsString/"$phpmyadminVrs"/g" .env
    fi

    # Adminer
    if [ ${#adminerVrs} != 0 ]; then
        echo "Adding Adminer (Adminer is on the port 8088)"
        cat ./dc/dc-adminer.yml >> docker-compose.yml
        cat ./env/env-adminer.env >> .env
        sed -i "s/adminerVrsString/"$adminerVrs"/g" .env
    fi
    
    # vsftpd
    # the code to add it in the composer is ready. The container is NOT.
    # What the hell is wrong with that one ?
    if [ ${#vsftpdVrs} != 0 ]; then
        echo "Adding vsftpd"
        cat ./dc/dc-vsftpd.yml >> docker-compose.yml
        cat ./env/env-vsftpd.env >> .env
        sed -i "s/vsftpdVrsString/"$vsftpdVrs"/g" .env
    fi

    # pure-ftpd
    if [ ${#pureftpdVrs} != 0 ]; then
        echo "Adding pure-ftpd"
        cat ./dc/dc-pure-ftpd.yml >> docker-compose.yml
        cat ./env/env-pure-ftpd.env >> .env
        sed -i "s/pureftpdVrsString/"$pureftpdVrs"/g" .env
    fi

    echo -e "\e[42mMoving files in the main directory and we're done.\e[0m"
        if [ -f "../docker-compose.yml" ]; then 
        rm ../docker-compose.yml
    fi 
    if [ -f "../.env" ]; then 
        rm ../.env 
    fi 
    mv ./docker-compose.yml ../
    mv ./.env ../
fi

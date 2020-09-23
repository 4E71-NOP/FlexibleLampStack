#/bin/sh
echo -e "\n\e[46m\e[1m                    BuidlComposer.sh                    \e[21m\e[49m\e[39m\e[m"

if [ ${#1} = 0 ]; then
    echo -e "\e[1m\e[101mERROR :\e[0m No arguments were given.";
    echo -e "Please use this script like the following example:";
    echo -e "\e[2m./buildComposer.sh 'php73 mariadb phpmyadmin' \e[0m(between quotes as a list)";
    exit 1
else 
    echo -e "Building \e[1m\docker-compose.yml\e[0m file.";
    echo -e "Argument list contains : \e[1m"$1"\e[0m.";
    mysqlVrs="";
    postgresVrs="";
    phpVrs="";
    mcVrs="";
    phpmyadminVrs="";
    optionList='mariadb mysql mysql8 php54 php56 php71 php72 php73 php74 mc';
    for A in $1
    do
        optionMatch=0;
        # echo "O="$O" ; A="$A;
            case $A in
            "mariadb"|"mysql"|"mysql8")
                mysqlVrs=$A
                optionMatch=1;
                ;;
            "postgres")
                postgresVrs=$A
                optionMatch=1;
                ;;
            "php54"|"php56"|"php71"|"php72"|"php73"|"php74")
                phpVrs=$A
                optionMatch=1;
                ;;
            "mc")
                mcVrs=$A
                optionMatch=1;
                ;;
            "phpmyadmin")
                phpmyadminVrs=$A
                optionMatch=1;
                ;;
            esac
        if [ $optionMatch -eq 0 ]; then 
            echo -e "\e[1m\e[101mERROR : \e[0mArgument '"$A"' is not in the available option list"
            exit 1
        fi
    done

    # Checking one or two things before we begin
    if ((${#phpVrs} == 0 || ${#mysqlVrs} == 0 )); then
        echo -e "\e[1m\e[101mERROR :\e[0m option list need at least a PHP version and database type"
        exit 1
    fi

    # Everything seems ok so far so we continue
    echo "Preparing initial files"
    rm ./docker-compose.yml
    cp dc-begin.txt docker-compose.yml
    cp env-begin.txt sample.env

    # Environment for PHP
    echo "Preparing PHP files"
    cat dc-php.txt >> docker-compose.yml
    cat env-php.txt >> sample.env
    sed -i "s/phpVrsString/"$phpVrs"/g" sample.env

    # Environment for mysql
    echo "Preparing mysql files"
    cat dc-mysql.txt >> docker-compose.yml
    cat env-mysql.txt >> sample.env
    sed -i "s/mysqlVrsString/"$mysqlVrs"/g" sample.env

    # Postgres
    if [ ${#postgresVrs} != 0 ]; then
        echo "Preparing postgres files"
        cat dc-postgres.txt >> docker-compose.yml
        cat env-postgres.txt >> sample.env
        sed -i "s/postgresVrsString/"$postgresVrs"/g" sample.env
    fi

    # Midnight Commander
    if [ ${#mcVrs} != 0 ]; then
        echo "Preparing mc files"
        cat dc-mc.txt >> docker-compose.yml
        cat env-mc.txt >> sample.env
        sed -i "s/mcVrsString/"$mcVrs"/g" sample.env
    fi
    # PHPMyAdmin
    if [ ${#phpmyadminVrs} != 0 ]; then
        echo "Preparing mc files"
        cat dc-mc.txt >> docker-compose.yml
        cat env-mc.txt >> sample.env
        sed -i "s/phpmyadminVrsString/"$phpmyadminVrs"/g" sample.env
    fi
    echo -e "\e[42mMoving files in the main directory and we're done.\e[0m"
    rm -rf ../docker-compose.yml ../sample.env
    mv ./docker-compose.yml ../
    mv ./sample.env ../
fi

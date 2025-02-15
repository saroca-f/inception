#!/bin/bash

# This script must be executed with bash

# Function used to ask for input without show the keys pressed
prompt_with_loop()
{
    local prompt_message=$1
    local input

    while true; do
        printf "%s " "$prompt_message" >&2
        read -sp " " input
        echo >&2
        if [ -z "$input" ]; then
            echo "This field cannot be empty. Please try again." >&2
        else
            break
        fi
    done

    echo "$input"
}

INCEPTION_USER="saroca-f"

NAME_USER="sergio"

ENV_FILE=".env"

read -p "Enter SQL database name: (default: my_database) " SQL_DATABASE
SQL_DATABASE=${SQL_DATABASE:-my_database}

read -p "Enter SQL user: (default: $INCEPTION_USER) " SQL_USER
SQL_USER=${SQL_USER:-$INCEPTION_USER}

SQL_PASSWORD=$(prompt_with_loop "Enter SQL password: ")

SQL_ROOT_PASSWORD=$(prompt_with_loop "Enter SQL root password: ")

read -p "Enter WordPress title (default: $INCEPTION_USER): " WP_TITLE
WP_TITLE=${WP_TITLE:-$INCEPTION_USER}

read -p "Enter WordPress admin username (default: $INCEPTION_USER): " WP_ADMIN_USR
WP_ADMIN_USR=${WP_ADMIN_USR:-$INCEPTION_USER}

WP_ADMIN_PWD=$(prompt_with_loop "Enter WordPress admin password: ")

read -p "Enter WordPress admin email (default: $INCEPTION_USER@student.42malaga.com)" WP_ADMIN_EMAIL
WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL:-$INCEPTION_USER@student.42malaga.com}

read -p "Enter WordPress username (default: $NAME_USER): " WP_USR
WP_USR=${WP_USR:-$NAME_USER}

WP_EMAIL=$(prompt_with_loop "Enter WordPress user email :")

WP_PWD=$(prompt_with_loop "Enter WordPress user password: ")

WP_URL=${WP_URL:-$INCEPTION_USER.42.fr}

read -p "Enter FTP_Server user (default: $INCEPTION_USER):" FTP_USER
FTP_USER=${FTP_USER:-$FTP_USER}

FTP_PASSWORD=$(prompt_with_loop "Enter FTP_Server password: ")

cat <<EOL > $ENV_FILE

SQL_DATABASE=$SQL_DATABASE
SQL_USER=$SQL_USER
SQL_PASSWORD=$SQL_PASSWORD
SQL_ROOT_PASSWORD=$SQL_ROOT_PASSWORD
WP_URL=$WP_URL
WP_TITLE=$WP_TITLE
WP_ADMIN_USR=$WP_ADMIN_USR
WP_ADMIN_PWD=$WP_ADMIN_PWD
WP_ADMIN_EMAIL=$WP_ADMIN_EMAIL
WP_USR=$WP_USR
WP_EMAIL=$WP_EMAIL
WP_PWD=$WP_PWD
WORDPRESS_DATA_LOCATION="/home/$INCEPTION_USER/data/wordpress"
MARIADB_DATA_LOCATION="/home/$INCEPTION_USER/data/mariadb"
FTP_USER=$FTP_USER
FTP_PASSWORD=$FTP_PASSWORD
EOL
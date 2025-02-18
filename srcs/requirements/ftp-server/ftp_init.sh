#!/bin/sh

if [ ! -f "/etc/vsftpd/vsftpd.conf.bak" ]; then

    mkdir -p /etc/vsftpd
    mkdir -p /var/www/html
    mkdir -p /var/run/vsftpd/empty

    mv /etc/vsftpd.conf /etc/vsftpd/vsftpd.conf
    cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak

    sed -i "s|listen=NO|listen=YES|g" /etc/vsftpd/vsftpd.conf
    sed -i "s|anonymous_enable=NO|anonymous_enable=YES|g" /etc/vsftpd/vsftpd.conf
    sed -i "s|#write_enable=YES|write_enable=YES|g" /etc/vsftpd/vsftpd.conf
    sed -i "s|#ftpd_banner=Welcome to blah FTP service.|ftpd_banner=Welcome to Inception FTP server!|g" /etc/vsftpd/vsftpd.conf
    sed -i "s|#chroot_local_user=YES|chroot_local_user=YES|g" /etc/vsftpd/vsftpd.conf
    sed -i "s|#chroot_list_enable=YES|chroot_list_enable=YES|g" /etc/vsftpd/vsftpd.conf
    sed -i "s|secure_chroot_dir=/var/run/vsftpd/empty|#secure_chroot_dir=/var/run/vsftpd/empty|g" /etc/vsftpd/vsftpd.conf

    echo "" >> /etc/vsftpd/vsftpd.conf

    echo "chroot_local_user=YES" >> /etc/vsftpd/vsftpd.conf
    echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf
    echo "user_sub_token=$FTP_USER" >> /etc/vsftpd/vsftpd.conf
    echo "local_root=/var/www/html" >> /etc/vsftpd/vsftpd.conf
    echo "listen_port=21" >> /etc/vsftpd/vsftpd.conf
    echo "listen_address=0.0.0.0" >> /etc/vsftpd/vsftpd.conf
    echo "seccomp_sandbox=NO" >> /etc/vsftpd/vsftpd.conf
    echo "pasv_enable=YES" >> /etc/vsftpd/vsftpd.conf
    echo "pasv_min_port=21100" >> /etc/vsftpd/vsftpd.conf
    echo "pasv_max_port=21110" >> /etc/vsftpd/vsftpd.conf
    echo "userlist_enable=YES" >> /etc/vsftpd/vsftpd.conf
    echo "userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd/vsftpd.conf
    echo "userlist_deny=NO" >> /etc/vsftpd/vsftpd.conf

    if [ ! -d "/var/www" ]; then
        useradd -m -d /var/www "$FTP_USER"
    else 
        useradd -d /var/www "$FTP_USER"
    fi
    
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

    usermod -aG www-data "$FTP_USER"

    chown -R $FTP_USER:$FTP_USER /var/www/html

    echo "$FTP_USER" | tee -a /etc/vsftpd.userlist > /dev/null

    chown -R www-data /var/www

    chmod -R 777 /var/www
fi

echo "FTP started on :21"
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
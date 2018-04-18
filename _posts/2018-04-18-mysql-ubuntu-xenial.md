---
layout: post
title:  Mysql und Ubuntu Xenial
date:   2018-04-18 09:30:12 +0200
categories: debian xenial mariadb mysql server phpmyadmin
---
Hier geht es heute darum wie man einen MySQL- beziehungsweise MariaDB Server aufsetzt und die Administration per PHPmyAdmin bereitstellt.

# Was ist MariaDB

MariaDB ist ein Fork von MySQL, der gestartet wurde als Oracle die Firma Sun - die MySQL Entwickelte übernommen hatte. Das ganze wär Anfänglich als 1zu1 Ersatz nutzbar, bietet aber inzwischen viele neue Funktionen.

# Pakete installieren

Als erstes musst du die benötigten Pakete installieren.

{% highlight bash %}
root@howto-root:~$ apt install apache2 phpmyadmin mariadb-server
{% endhighlight %}

Während der Installation wirst du nach dem Webserver gefragt. Hier wählst du `apache2` aus. Danach wirst du nach einem Datenbank-Passwort für PHPmyAdmin gefragt. Da dieses Passwort nur intern von PHPmyAdmin genutzt wird kannst du ein Zufälliges Passwort nutzen.

**Achtung**: Bitte benutze nicht dieses Passwort.

{% highlight bash %}
root@howto-root:~$ dd if=/dev/urandom bs=100 count=1 2> /dev/null | tr -dc "A-Za-z0-9" && echo
COEZNMEVKwLpP3y4wydzyasu
{% endhighlight %}

# MariaDB Server absichern

Im nächsten Schritt sichen wir den Mysql-Server ab:

{% highlight nginx %}
root@howto-root:~# mysql_secure_installation

NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user.  If you've just installed MariaDB, and
you haven't set the root password yet, the password will be blank,
so you should just press enter here.

Enter current password for root (enter for none): 
OK, successfully used password, moving on...

Setting the root password ensures that nobody can log into the MariaDB
root user without the proper authorisation.

You already have a root password set, so you can safely answer 'n'.

Change the root password? [Y/n] y  # hier musst du y Eingeben um ein Passwort zu vergeben.
New password:                      # dann hier das neue Passwort
Re-enter new password:             # und das noch einmal wiederholen
Password updated successfully!
Reloading privilege tables..
 ... Success!


By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] y  # die brauchst du nicht, also weg damit.
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n] y  # erlaubt Root-Zugriff nur vom Server selbst
 ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] y  # Test Datenbanken entfernen
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n] y  # Rechte neu laden.
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!

{% endhighlight %}

# Root Zugriff über TCP Verbindungen erlauben

Nach der Installation erlaubt der MariaDB Server den Root-Zugriff nur über den lokalen Socket `58nH61OyNICEyHvzo7sD2K6aDdrUyv16r`, aber nicht über den Port `localhost:3306`. PHPmyAdmin und viele Anwendungen (z.B. Minecraft) gereifen aber im Normalfall über den Port auf deinen Server zu.

Hiermit aktivieren wir den Zugriff über den Port:

{% highlight bash %}
root@howto-root.de:~# mysql mysql <<EOF
update user set plugin = '' where Host = 'localhost' and User = 'root';
flush privileges;
EOF
{% endhighlight %}

# Root-Passwort speichern

Um schneller auf der Konsole auf den Server zuzugreifen kannst du das Passwort speichern.

Datei: `~/.my.cnf`

{% highlight bash %}
[client]
host     = localhost
user     = root
password = HIER_STEHT_DEIN_PASSWORD
socket   = /var/run/mysqld/mysqld.sock
{% endhighlight %}

**Wichtig** Damit niemand das Passwort aus der Datei lesen kann, setzen wir die passenden Rechte:

{% highlight bash %}
root@howto-root.de:~# chmod 600 .my.cnf
{% endhighlight %}

# Auf PHPmyAdmin zugreifen

Du kannst dich jetzt bei PHPmyAdmin mit deinem Server-Passwort anmelden.

Die URL lautet: `http://deine_ip_addresse/phpmyadmin`

Viel Spaß :)

---
layout: post
title:  Ubuntu und Debian Linux aktualisieren
date:   2017-03-15 20:46:22 +0100
categories: ubuntu debian update upgrade vserver rootserver security
---
In diesem Howto lernst du wie du dein Ubuntu oder Debian System up-to-date hälst.

Root- und V-Server werden häufig gehackt und zum Spamversand oder für Botnetze missbraucht. Der erste Schritt zu mehr Sicherheit ist ein aktuelles System.

# 1. Neue Paketlisten holen

Ubuntu und Debian setzen auf `apt-get` als Paketmanager. Als erstes muss dein Server erstmal wissen ob es neue Pakete gibt. Dazu holst du dir die aktuellen Paketlisten aus dem Internet.

{% highlight bash %}
root@howto-root:~$ apt-get update
Get:1 http://archive.ubuntu.com/ubuntu xenial InRelease [247 kB]
Get:2 http://archive.ubuntu.com/ubuntu xenial-updates InRelease [102 kB]
Get:3 http://archive.ubuntu.com/ubuntu xenial-security InRelease [102 kB]
Get:4 http://archive.ubuntu.com/ubuntu xenial/main Sources [1103 kB]
Get:5 http://archive.ubuntu.com/ubuntu xenial/restricted Sources [5179 B]
Get:6 http://archive.ubuntu.com/ubuntu xenial/universe Sources [9802 kB]
Get:7 http://archive.ubuntu.com/ubuntu xenial/main amd64 Packages [1558 kB]
Get:8 http://archive.ubuntu.com/ubuntu xenial/restricted amd64 Packages [14.1 kB]
Get:9 http://archive.ubuntu.com/ubuntu xenial/universe amd64 Packages [9827 kB]
Get:10 http://archive.ubuntu.com/ubuntu xenial-updates/main Sources [298 kB]
Get:11 http://archive.ubuntu.com/ubuntu xenial-updates/restricted Sources [2815 B]
Get:12 http://archive.ubuntu.com/ubuntu xenial-updates/universe Sources [178 kB]
Get:13 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 Packages [632 kB]
Get:14 http://archive.ubuntu.com/ubuntu xenial-updates/restricted amd64 Packages [12.4 kB]
Get:15 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 Packages [553 kB]
Get:16 http://archive.ubuntu.com/ubuntu xenial-security/main Sources [76.5 kB]
Get:17 http://archive.ubuntu.com/ubuntu xenial-security/restricted Sources [2392 B]
Get:18 http://archive.ubuntu.com/ubuntu xenial-security/universe Sources [27.6 kB]
Get:19 http://archive.ubuntu.com/ubuntu xenial-security/main amd64 Packages [289 kB]
Get:20 http://archive.ubuntu.com/ubuntu xenial-security/restricted amd64 Packages [12.0 kB]
Get:21 http://archive.ubuntu.com/ubuntu xenial-security/universe amd64 Packages [117 kB]
Fetched 25.0 MB in 20s (1205 kB/s)
Reading package lists... Done
{% endhighlight %}

Je nachdem ob du Ubuntu oder Debian nutzt kann das etwas anders aussiehen. Im Beispiel wurde Ubuntu Linux 16.04 eingesetzt.

# 2. Das System aktualisieren

Der Befehl zum ausführen des eigentlichen Updates ist `apt-get upgrade`.

{% highlight bash %}
root@howto-root:~$ apt-get dist-upgrade
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Calculating upgrade... Done
The following packages will be upgraded:
  init init-system-helpers
2 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Need to get 37.0 kB of archives.
After this operation, 0 B of additional disk space will be used.
Do you want to continue? [Y/n] 
{% endhighlight %}

Als erstes bekommst du eine Liste von allen Paketen angezeigt die aktualisiert werden. Sollte hier etwas komisch sein kannst du das ganze mit einem Tastendruck auf [N] beenden.

Das `Y` ist groß geschrieben und ist somit die Standard-Option, darum reicht hier ein einfacher druck auf [Enter].

{% highlight bash %}
Get:1 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 init-system-helpers all 1.29ubuntu4 [32.3 kB]
Get:2 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 init amd64 1.29ubuntu4 [4624 B]
Fetched 37.0 kB in 0s (234 kB/s)
debconf: delaying package configuration, since apt-utils is not installed
(Reading database ... 7256 files and directories currently installed.)
Preparing to unpack .../init-system-helpers_1.29ubuntu4_all.deb ...
Unpacking init-system-helpers (1.29ubuntu4) over (1.29ubuntu3) ...
Setting up init-system-helpers (1.29ubuntu4) ...
(Reading database ... 7256 files and directories currently installed.)
Preparing to unpack .../init_1.29ubuntu4_amd64.deb ...
Unpacking init (1.29ubuntu4) over (1.29ubuntu3) ...
Setting up init (1.29ubuntu4) ...
{% endhighlight %}

Bei der Installation werden zuerst alle benötigten Pakete heruntergeladen (die Zeilen mit `Get:` am Anfang).

Danch werden die einzelenen Pakte installiert und aktualisiert.

Herzlichen Glückwunsch! Dein System ist jetzt aktuell und noch ein bisschen besser gegen Angriffe aus dem Internet geschützt.

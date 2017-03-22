---
layout: post
title:  Teamspeak3 Server auf Ubuntu und Debian installieren
date:   2017-03-12 22:40:38 +0100
categories: teamspeak software ubuntu debian systemd rootserver vserver
---
In diesem Howto zeigen wir dir wie du einen Teamspeak3 Server auf deinem Rootserver installieren kannst und er beim Neustart auch automatisch startet.

# 1. Benutzer anlegen

Fast immer wenn du ein bestimmtes Programm unter Linux installierst lohnt es sich einen eigenen Benutzer dafür anzulegen. Dadurch erhöst du die Sicherheit falls doch mal ein Bug in der Software ist.

In diesem Fall legen wir das `home`-Verzeichnis direkt in `/opt` an:

{% highlight bash %}
useradd -m -d /opt/teamspeak3 teamspeak3
{% endhighlight %}

Erklärung der Optionen:

* `-m` erstellt automatisch das Homeverzeichnis mit den passenden rechten.
* `-d /opt/teamspeak3` sorgt dafür das das Home-Verzeichnis nicht in `/home` angelegt wird.

# 2. Teamspeak3 herunterladen und entpacken

Teamspeak installieren wir direkt mit dem dafür angelegten Benutzer, damit ist sichergestellt das der Prozess dann auch auf alle Dateien zugriff und schreibrechte hat.

{% highlight bash %}
su - teamspeak3
{% endhighlight %}

Die aktuellste Version findest du immer auf [http://www.teamspeak.com/downloads.html]. Im Normalfall brauchst du die Linux Server 64-bit Version. Hinter dem Download Button kannst du dir direkt die URL zur Datei kopieren:

![Teamspeak Link kopieren](/images/2017-03-12-teamspeak3_installieren/download.png)

Mit dem `wget`-Tool kannst du Teamspeak dann direkt auf deinen Server herunterladen. Bitte achte darauf das du die Dateinamen entsprechend der aktuellen Teamspeak3 Version anpasst.

{% highlight bash %}
wget http://teamspeak.gameserver.gamed.de/ts3/releases/3.0.13.6/teamspeak3-server_linux_amd64-3.0.13.6.tar.bz2
tar --strip-components=1 -xvpf teamspeak3-server_linux_amd64-3.0.13.6.tar.bz2
{% endhighlight %}

Erklärung der tar Optionen:

* `--strip-components=1`: sorgt dafür das der `teamspeak3-server_linux_amd64` Ordner im Archiv in das aktuelle Verzeichnis entpackt wird.
* `x`: e**x**tract, also entpacken
* `v`: **v**erbose, dadurch zeigt das Tool direkt alle Dateien anpasst
* `p`: **p**ermissions, sorft dafür das alle Rechte erhalten bleiben
* `f`: **f**ile, muss immer als letzes vor der Datei stehen

Nach dem Entpacken kannst du das heruntergeladene Archiv löschen:

{% highlight bash %}
rm teamspeak3-server_linux_amd64-3.0.13.6.tar.bz2
{% endhighlight %}

Jetzt beenden wir unsere `teamspeak3`-Benutzer Sitzung:

{% highlight bash %}
exit
{% endhighlight %}

# 3. Teamspeak3 automatisch starten

Bei allen aktuellen Distributionen kannst du Systemd für das automatische Starten von Diensten nutzen. Dazu musst du zuerst eine `.service`-Datei für den Dienst anlegen.

Datei: `/etc/systemd/system/teamspeak3.service`

{% highlight bash %}
[Unit]
Description=TeamSpeak 3 Server
After=network.target

[Service]
Type=simple
Environment=LD_LIBRARY_PATH=/home/teamspeak3/
WorkingDirectory=/home/teamspeak3/
ExecStart=/home/teamspeak3/ts3server
ExecStop=/bin/kill -TERM $MAINPID
StandardOutput=syslog
StandardError=syslog

User=teamspeak3
Group=teamspeak3
Restart=always

[Install]
WantedBy=multi-user.target
{% endhighlight %}

Als nächstes musst du den Autostart für den Service aktivieren.

{% highlight bash %}
systemctl enable teamspeak3
{% endhighlight %}

Um Teamspeak zu starten kannst du jetzt entweder deinen Server neustarten oder direkt den Dienst starten.

{% highlight bash %}
systemctl start teamspeak3
{% endhighlight %}

# Fertig

Die Installation von Teamspeak 3 ist jetzt abgeschlossen. Viel Spaß :)

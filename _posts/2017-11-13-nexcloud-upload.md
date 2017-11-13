---
layout: post
title:  Dateiupload in Nextcloud aus der Konsole
date:   2017-11-12 19:57:38 +0100
categories: owncloud nextcloud share password bash console cli
---
Mit diesem Bash-Script kannst du Dateien mit einem einzigen Befehl in Nextcloud hochladen und Passwortgeschützt freigeben.

# Das Script

{% highlight bash %}
function upload() {
  # TODO: hier musst du deine Nextcloud Zugansdaten eintragen
  nc_user="benutzername"
  nc_password="supergeheimespasswort"
  nc_url="mein.nextcloud.example.com"

  file="$1"
  file_save=$(echo -n $file | tr -c '[A-z0-9_\-\.]' '_')

  # Upload nach nextcloud
  echo Uploading "$file" to "$file_save" ...
  curl -X PUT -u "$nc_user:$nc_password" https://$nc_url/remote.php/webdav/Kundendaten/${file_save} --data-binary "@$file"
 
  password=$(dd if=/dev/urandom bs=1M count=1 2> /dev/null | tr -dc "A-Za-z0-9" | head -c 8)
  curl -X POST -H "OCS-APIRequest: true" -d "true" -u "$nc_user:$nc_password" \
      --data "path=/Kundendaten/${file_save}&shareType=3&password=${password}" \
      https://$nc_url/ocs/v1.php/apps/files_sharing/api/v1/shares \
      | grep url | sed 's/\s*<\/*url>//g' | sed 's/^/URL: /'
  echo Passwort: $password

}
{% endhighlight %}

# Beispiel

{% highlight bash %}
upload /tmp/testdatei 
# Uploading /tmp/testdatei to _tmp_testdatei ...
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  1241  100  1174  100    67   1174     67  0:00:01  0:00:01 --:--:--  1064
# URL: https://owncloud.united-gameserver.de/index.php/s/D2mXHBZ2heEKaXR
# Passwort: ycjGVNm4
{% endhighlight %}

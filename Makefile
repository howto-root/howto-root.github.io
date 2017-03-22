live:
	jekyll build
	rsync -av /home/stefan/git/howto-root/_site/ root@www.howto-root.de:/var/www/html/

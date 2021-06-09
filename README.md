Back story <https://www.reddit.com/r/mikrotik/comments/kglhs0/backup_or_rsc/>

# Issues

* Users not exported
* RSC is not backwards compatible
* Needs to be edited before /import
* Passwords missing, not exactly sure what happens come restore

# What not Mikrotik cloud backup ?

https://wiki.mikrotik.com/wiki/Manual:IP/Cloud#Backup does not help you on a
machine with no config and no Internet connection.

There doesn't seem to be a straightforward way to **download-file** from your
working machine even if you know the **secret-download-key**.

# Why not .backup file?

.backup file has all the details like certificates, however [the backup file
cannot be easily
read](https://github.com/BigNerd95/RouterOS-Backup-Tools/issues).

It also does not restore well unless it's exactly the same model of hardware it
was created from.

# Importing

<img src="https://s.natalian.org/2021-06-08/no-defaults.png">

Winbox to your new router, setup your admin user / ssh key

	/system reset-configuration keep-users=yes no-defaults=yes

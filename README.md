# Blackarch
I like blackarch operating system very much, but it has a lot of problems. I wrote a script in the materials, and wrote the missing software package and tools into shell.

My shell doesn't write very well. It's not fully automated.


Finally, blackarch is installed in VMware through live, which requires at least 90g space. After the installation, use script. When the script is used, please remember!!!!!!!
********************************************************************
In blackarch (2020-12-01), there is no problem that the password cannot be found by locking. The following operation is applicable to Version (2020-12-06).

######Find system file /etc/pam.d/system-login   find the "pam_tally.so" This line of file has been commented out, Do not delete, Please “//” this line file!! ######

The function of this file is to enable authentication. After restart, the user name and password will not be found. Be sure to create a snapshot!!
********************************************************************
USE:
chmod +x Blackarch.sh
./Blackarch.sh

！！Chinese characters are used in the font setting part of the current script！！

Good luck！！！！！！！！！！！！

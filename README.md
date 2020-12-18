# Blackarch
I like blackarch operating system very much, but it has a lot of problems. I wrote a script in the materials, and wrote the missing software package and tools into shell.

My shell doesn't write very well. It's not fully automated.

In line 82 of the code, three packages of "neofetch htop mate terminal" are written, which can be installed or not, and the lowest test network speed!

There are still many problems to be solved. I am still contacting the developer to optimize the system.

Finally, blackarch is installed in VMware through live, which requires at least 90g space. After the installation, use script. When the script is used, please remember!!!!!!!

######Find system file /etc/pam.d/system-login   find the "pam_tally.so" This line of file has been commented out, Do not delete, Please “//” this line file!! ######

The function of this file is to enable authentication. After restart, the user name and password will not be found. Be sure to create a snapshot!!


USE:
chmod +x Blackarch.sh
./Blackarch.sh



Good luck！！！！！！！！！！！！

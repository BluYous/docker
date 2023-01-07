set -ex;
curl -L https://wdm.itsu.eu.org/d/auto/Mathematica/$1.0/Main/Mathematica_$1_BNDL_Chinese_LINUX_CN.sh -o /tmp/Mathematica.sh;
chmod +x /tmp/Mathematica.sh;
/tmp/Mathematica.sh -- -silent -verbose
rm -rf /tmp/Mathematica.sh

set -ex;
curl -L https://wdm.itsu.eu.org/d/auto/Mathematica/${version}.0/Main/Mathematica_${version}_BNDL_Chinese_LINUX_CN.sh -o /tmp/Mathematica.sh;
chmod +x /tmp/Mathematica.sh;
/tmp/Mathematica.sh -- -silent -verbose
rm -rf /tmp/Mathematica.sh

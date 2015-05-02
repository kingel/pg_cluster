set -e -u

echo "Installing postgres..."

DIR="bdr-pg"
DIR1="bdr-extension"

echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" >  /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y git build-essential flex bison libreadline6 libreadline6-dev zlibc zlib1g zlib1g-dev openssl libssl-dev
sudo apt-get install -y postgresql-9.4 postgresql-client-common postgresql-client-9.4 postgresql-contrib-9.4 postgresql-common
HOME=/var/lib/postgresql sudo -u postgres bash -c "$(curl -s 'http://git.postgresql.org/gitweb/?p=2ndquadrant_bdr.git;a=blob_plain;f=scripts/bdr_quickstart.sh;hb=bdr-plugin/next')"
export PATH=/var/lib/postgresql/2ndquadrant_bdr/bdr/bin:$PATH

echo "export PATH=$HOME/2ndquadrant_bdr/bdr/bin:$PATH" >> /etc/bashrc

echo "Init db ..."
sudo -u postgres /var/lib/postgresql/2ndquadrant_bdr/bdr/bin/initdb -D /var/lib/postgresql/data -A trust --auth-host=md5 --auth-local=peer -U postgres

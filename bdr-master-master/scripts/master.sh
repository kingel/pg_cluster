set -e -u

PG_DATABASE_NAME=${1:-bdr_database}

source /vagrant/scripts/postgres_94_bdr.sh

rm -f /var/lib/postgresql/data/pg_hba.conf
rm -f /var/lib/postgresql/data/postgresql.conf

cp /vagrant/master/pg_hba.conf /var/lib/postgresql/data/pg_hba.conf
cp /vagrant/master/postgresql.conf /var/lib/postgresql/data/postgresql.conf

sed -i "s/\$PG_DATABASE_NAME/${PG_DATABASE_NAME}/g" /var/lib/postgresql/data/postgresql.conf

chown postgres:postgres /var/lib/postgresql/data/pg_hba.conf
chown postgres:postgres /var/lib/postgresql/data/postgresql.conf

ln -s /var/lib/postgresql/data /database
cd /database


echo "Starting postgres ... "
sudo -u postgres -H sh -c "/var/lib/postgresql/2ndquadrant_bdr/bdr/bin/pg_ctl -D /var/lib/postgresql/data -l /database/logfile -w start"
sleep 2
sudo -u postgres -H sh -c "/var/lib/postgresql/2ndquadrant_bdr/bdr/bin/createdb $PG_DATABASE_NAME"

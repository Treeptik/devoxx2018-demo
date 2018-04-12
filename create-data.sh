cd ~/devoxx2018-demo

mkdir /btrfs/pg-data

docker run --name postgres-srv \
			-e POSTGRES_PASSWORD=mysecretpassword \
			-v /btrfs/pg-data:/var/lib/postgresql/data \
			-v `pwd`/scripts/users.sql:/opt/scripts/users.sql \
			-d postgres

docker exec -it postgres-srv "psql -U postgres -f /opt/scripts/users.sql"

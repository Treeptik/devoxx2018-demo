# Create the data volume

```
mkdir /btrfs/pg-data
```

# Run a container to load data

```
docker run --name postgres-srv \
			-e POSTGRES_PASSWORD=mysecretpassword \
			-v /btrfs/pg-data:/var/lib/postgresql/data \
			-v `pwd`/scripts/users.sql:/opt/scripts/users.sql \
			-d postgres

docker exec -it postgres-srv bash

container> psql -U postgres
 postgres> \timing
 postgres> \i /opt/scripts/users.sql
```

# Create a BtrFS volume

```
btrfs subvolume create /btrfs/pg-data-ref
chown -R jenkins:jenkins /btrfs/pg-data-ref/
```


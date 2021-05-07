# SQLite
SQLite is really easy to install and running it on a container is probably an overkill,
however I did it anyway :)
## Build the docker container (optional)
Go to the docker folder and build the container
with the following command
Run 
```bash
docker build -t dovidio/sqlite3-ubuntu
```

## Run the container
Run the following command
```bash
docker-compose up
```

### Import data
If you want generate the schema and data used as examples in the book
[Database System Concepts](https://www.db-book.com/db7/university-lab-dir/db-tips.html),
run **import-db-book-data.sh**
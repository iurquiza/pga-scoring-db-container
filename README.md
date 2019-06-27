## Requirements
Docker  
Docker Compose  
scoring-dev20190614.bak  

## Set up MSSQL Docker container
* Place `scoring-dev20190614.bak` in the same directory after cloning the repository.
* Run `docker-compose up`
* Make the `.bat` or `.sh` executable `chmod +x init_db.sh`
* Run the `init_db.sh` file, or run the commands within the file manually one by one in order.

## Running queries inside the container
* Install sql-cli `npm install -g sql-cli`
* To access the MSSQL server run `mssql -u SA -p Pass@word1`
* Run your query: `SELECT name, database_id, create_date FROM sys.databases`

## Using a different `.bak` file
* Run the folliwing command:  
```shell
docker exec -it mssql-container /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'Pass@word1' -Q 'RESTORE FILELISTONLY FROM DISK = "/var/opt/mssql/backup/scoring-dev20190614.bak"' | tr -s ' ' | cut -d ' ' -f 1-2
```
* Update the filenames (10Scoring) in the `TO` locations in the follow command of the `init_db` files with the output of the command listed above. Add other mappings as necessary:  
```shell
docker exec -it mssql-container /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'Pass@word1' -Q 'RESTORE DATABASE scoring_dev FROM DISK = "/var/opt/mssql/backup/scoring-dev20190614.bak" WITH MOVE "scoring_dev" TO "/var/opt/mssql/data/10Scoring.mdf", MOVE "scoring_dev_log" TO "/var/opt/mssql/data/10Scoring.ldf"'
```
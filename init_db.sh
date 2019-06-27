#!/bin/bash
docker exec -it mssql-container mkdir /var/opt/mssql/backup && \
docker cp scoring-dev20190614.bak mssql-container:/var/opt/mssql/backup && \
docker exec -it mssql-container /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'Pass@word1' -Q 'RESTORE DATABASE scoring_dev FROM DISK = "/var/opt/mssql/backup/scoring-dev20190614.bak" WITH MOVE "scoring_dev" TO "/var/opt/mssql/data/10Scoring.mdf", MOVE "scoring_dev_log" TO "/var/opt/mssql/data/10Scoring.ldf"'

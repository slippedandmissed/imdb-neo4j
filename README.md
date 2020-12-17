# IMDb Neo4j Database

This is a guide to setting up the IMDb Graph database using Neo4j which is required for the **Databases** module of part IA of the UoC Computer Science course.

Neo4j 4.1.3 is a pain to install because it requires Java 11.

Instead I think it's easier and more reliable to just run it in a docker container.

You do need docker installed though.

1. Install docker using these instructions [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)

2. To start the neo4j instance, run the following command from your command terminal:
```bash
docker run --name neo4j -it -d --network="host" --mount source=neo4jvol,target=/var/lib/neo4j/data slippedandmissed/imdb-neo4j /bin/bash -c "./neo4j start && /bin/bash"
```
Note that this takes longer the first time you run it.

3. Now hopefully you should be able to access neo4j on [http://localhost:7474/](http://localhost:7474/)

4. Log in with default username **neo4j** and password **neo4j**

5. It'll ask you to change your password. Go ahead and do that.

6. Run a test command from within the browser. For example:
```cypher
match (n)
return labels(n) as labels, keys(n) as properties, count(*) as total
order by total desc;
```
Hopefully you'll see some output like

| labels     | properties                                                                    | total |
|------------|-------------------------------------------------------------------------------|-------|
| ["Person"] | ["person_id", "name", "birthYear"]                                            | 3865  |
| ["Person"] | ["person_id", "name"]                                                         | 2479  |
| ["Movie"]  | ["movie_id", "title", "year", "type", "minutes", "rating", "votes", "genres"] | 1323  |
| ["Person"] | ["person_id", "name", "birthYear", "deathYear"]                               | 392   |
| ["Person"] | ["person_id", "name", "deathYear"]                                            | 9     |
| ["Movie"]  | ["movie_id", "title", "year", "type", "rating", "votes", "genres"]            | 1     |

7. Do all the exercises or ticks or whatever [here](https://www.cl.cam.ac.uk/teaching/2021/Databases/graph-tutorial.html#cypher-by-example) idk I haven't read it yet

8. To stop the neo4j instance running, run the following command from your command terminal:
```bash
docker rm --force neo4j
```
You can then start it again whenever you want using the command from step 2

## Uninstalling

The use of a docker volume means that the data is persistent, even if you stop and restart the neo4j instance.
If for example you accidentally delete all the data and you need to restart from scratch, run the following command from your command terminal:
```bash
docker rm --force neo4j && docker volume rm neo4jvol
```
You can then restart the neo4j instance using the command from step 2, and all the data will have been reset to the default. Your password will get reset back to **neo4j** too and you'll need to change it again when you log in for the first time.
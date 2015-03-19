This is a Dockerfile setup for couchpotato - https://couchpota.to/

It's based on needo/couchpotato, with the only adjustment being running the 
couchpotato user as UID 4242 "htpc". I built it because I wanted a consistent
way to give my containerized HTPC apps access to my media library

By default this Docker installs the latest stable version of CouchPotato:

```
docker run -d --net="host" --name="couchpotato" -v /path/to/couchpotato/data:/config -v /path/to/downloads:/downloads -v /path/to/movies:/movies -v /etc/localtime:/etc/localtime:ro -p 5050:5050 funkypenguin/couchpotato
```

Edge
----
If you would like to run the latest updates from the master branch as well as enable in-app updates run:

```
docker run -d --net="host" --name="couchpotato" -v /path/to/couchpotato/data:/config -v /path/to/downloads:/downloads -v /path/to/movies:/movies -v /etc/localtime:/etc/localtime:ro -e EDGE=1 -p 5050:5050 funkypenguin/couchpotato
```

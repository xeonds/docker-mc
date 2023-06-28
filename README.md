# MC-Server - Docker Deployment

## Deploy

When first deploy, build image first:

```bash
./mc.sh build
```

Then config the `server.properties` file. Finally, start server using `./mc.sh run`

## Usage

1. start/stop

Use `./mc.sh start/stop/restart` to start/stop/restart the server.

2. backup

Use `./mc.sh backup` to backup full server.

## Full Setting

Run `docker exec -it mc sh` to enter fs to configure.


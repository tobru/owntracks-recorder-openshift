# Dockerfile for running OwnTracks Recorder on OpenShift

http://owntracks.org/

## Running with Docker

```
docker build -t local/ot-recorder .
docker run --rm -ti -p 8083:8083 \
  -e OTR_HOST=myhostname \
  -e OTR_PORT=8883 \
  -e OTR_USER=recorder \
  -e OTR_PASS=PASSWORD \
  local/ot-recorderdocker
```

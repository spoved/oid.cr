docker run --rm -ti -v /Users/homans/code/github.com/spoved/oid.cr:/oid \
  -w /oid \
  docker.io/kalinon/bindgen:0.6.2 \
  /opt/bindgen/tool.sh ./ext/raylib.yml

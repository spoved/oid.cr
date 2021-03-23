#!/bin/bash
cd lib

rm spoved entitas entitas-web bindgen

ln -s ../../../spoved/spoved.cr spoved
ln -s ../../../spoved/entitas.cr entitas
ln -s ../../../kalinon/entitas-web entitas-web
ln -s ../../../kalinon/bindgen bindgen
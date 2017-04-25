#!/usr/bin/env python
#
# docker rmi unused images (not being used by any container)
# 'Used' means a container based on this image exists, and may
# be running, or stopped, or paused. If used, the underlying
# image will not be removed.
#

import docker

client = docker.from_env()

images = {}
for image in client.images():
  images[image['Id']] = image

for container in client.containers():
  imageId = container['ImageID']
  if images.get(imageId):
    images.pop(imageId)

if len(images) == 0:
  print 'No images need cleanup'
  exit(0)

for id in images:
  print 'Removing unused image', images[id]['RepoTags'], images[id]['Id']
  client.remove_image(images[id])

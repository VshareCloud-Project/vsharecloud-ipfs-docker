# IPFS Container for vShareCloud

### How to deploy

#### Pre-requisites
- Docker

#### Build
This repository will be automatically built and pushed to the GitHub Container Registry. You can pull the image from the following location:
```bash
docker pull ghcr.io/vsharecloud-project/vsharecloud-ipfs-docker
```

### How to run

#### Steps
1. Run the following command to start the IPFS container
```bash
docker run -d --name ipfs -p 4001:4001/tcp -p 4001:4001/udp -p 5001:5001 -p 8080:8080 -v ${LOCAL_IPFS_PATH}:/data/ipfs ghcr.io/vsharecloud-project/vsharecloud-ipfs-docker
```
The Local IPFS path should be a directory on your local machine where the IPFS data will be stored.

### TODO List

- Add support for upgrading the IPFS container
- Multi platform support
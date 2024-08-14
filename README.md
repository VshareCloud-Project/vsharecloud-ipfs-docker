# IPFS Container for vShareCloud

### How to deploy

#### Pre-requisites
- Docker

#### Steps
1. Clone the repository
2. Run the following command to build the docker image
```bash
docker build -t vsharecloud/ipfs .
```

### How to run

#### Steps
1. Run the following command to start the IPFS container
```bash
docker run -d --name ipfs -p 4001:4001/tcp -p 4001:4001/udp -p 5001:5001 -p 8080:8080 -v ${LOCAL_IPFS_PATH}:/data/ipfs vsharecloud/ipfs
```
The Local IPFS path should be a directory on your local machine where the IPFS data will be stored.

### TODO List

- Add support for upgrading the IPFS container
- Multi platform support
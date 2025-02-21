# Postgres Docker Container Image

A lightweight Postgres container image based on Alpine Linux, building with the Clang and LLVM.

## Quick reference
- **Image based on**: [alpine](https://hub.docker.com/_/alpine)
- **Supported architectures**: `linux/amd64`, `linux/arm64`
- **Maintained by**: [grmvoid](https://github.com/grmvoid)
- **Issues**: [https://github.com/grmvoid/docker-postgres/issues](https://github.com/grmvoid/docker-postgres/issues?q=)

## Usage
### Pull the Image
To get started, pull the specify a version Postgres image:
```bash
  docker pull grmvoid/postgres:17.2
```

### Running a Container
You can run the Postgres container using the following command:
```bash
  docker run --name postgres grmvoid/postgres:17.2
```

### Running via [`docker-compose`](https://github.com/docker/compose)
Example `docker-compose.yml` for `postgres`:
```yaml
services:
  postgres:
    image: grmvoid/postgres:17.2
    restart: always
    ports:
      - "5432:5432"
```

## Environment Variables
The postgres image uses several environment variables which are easy to miss.

| Variable | Default Value | Description |
|----------|---------------|-------------|
| `PGDATA` |               |             |

## LICENSE
View [Postgres License](https://www.postgresql.org/about/licence/)  information for the software contained in this image. Individual dependencies may have their own licensing terms.

Additionally, the contents of this repository are licensed under the [MIT License](LICENSE).
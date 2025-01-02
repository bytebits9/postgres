## Quick reference
- **Image based on**:   
  [alpine](https://hub.docker.com/_/alpine)

- **Supported architectures**:    
  `linux/amd64`, `linux/arm64`

- **Maintained by**:  
  [grmvoid](https://github.com/grmvoid)

- **Where to file issues**:    
  [https://github.com/grmvoid/docker-postgres/issues](https://github.com/grmvoid/docker-postgres/issues?q=)

## Supported tags and respective `Dockerfile` links

- `17.2`, `17`

## How to use this image

### start a postgres instance

```bash
$ docker run --name postgres -d grmvoid/postgres:17.2
```

### ... via [`docker-compose`](https://github.com/docker/compose)
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

View [license](https://www.postgresql.org/about/licence/) information for the software contained in this image.

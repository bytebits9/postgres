# postgres

## Quick reference
- **Image based on**:   
  [alpine](https://hub.docker.com/_/alpine)

- **Supported architectures**:    
  `linux/amd64`, `linux/arm64`

- **Maintained by**:  
  [sxbrsky](https://github.com/sxbrsky)

- **Where to file issues**:    
  [https://github.com/sxbrsky/docker-postgres/issues](https://github.com/sxbrsky/docker-postgres/issues?q=)

## Supported tags and respective Dockerfile links

[`All supported tags see here`](https://hub.docker.com/r/sxbrsky/postgres/tags)

## How to use this image

### start a postgres instance

```console
$ docker run --name postgres -d sxbrsky/postgres
```

### ... via [`docker-compose`](https://github.com/docker/compose)
Example `docker-compose.yml` for `postgres`:

```yaml
version: '3.1'

services:
    postgres:
        image: sxbrsky/postgres:latest
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

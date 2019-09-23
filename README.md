# HelloWorldAPI

## Build image
```
docker build . --tag helloworldapi:latest
```

## Run image
```
docker run --rm -p 8080:80 --name HelloWorldAPI helloworldapi
```

## Stop image
```
docker stop HelloWorldAPI
```

## Test
```
curl http://localhost:8080/api/values/11
```

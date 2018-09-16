# docker-cronicle

Docker image for [Cronicle](https://github.com/jhuckaby/Cronicle) running on alpine.


## Usage

You can pass in the `ADMIN_USERNAME` and `ADMIN_PASSWORD` environment variable to set the admin username and password. You can also pass in the `--master` flag to force an instance as master. Otherwise, Cronicle will take about [60 seconds][1] to elect a master and start up.

```
docker run --rm -it -p 127.0.0.1:3012:3012 -e ADMIN_USERNAME=admin -e ADMIN_PASSWORD=admin -e cronicle --master
```

[1]: https://github.com/jhuckaby/Cronicle#starting-in-debug-mode

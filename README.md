# consul-atomic

![Danger](http://farm2.static.flickr.com/1083/531670330_104df47a65.jpg)

photo by [Pulpolux !!!] "http://www.flickr.com/photos/pulpolux/531670330/"

**This is not ready for use, it will not work, so please do not use it**

Building consul server container for an atomic host:

```
# git clone https://github.com/themurph/consul-atomic
# cd consul-atomic
# docker build --rm -t consul .
```

Installing consul container on atomic host:

```
# atomic install --name consul01 consul
```

Running consul container on atomic host:

```
# atomic run --name consul01 consul
```

Stopping consul container on atomic host:

```
# atomic stop --name consul01 consul
```

Uninstalling consul container on atomic host:

```
# atomic uninstall --name consul01 consul
```



This is a test suite for netlocal, a command line tool to mock network services.  It requires ruby and bundler.  You will also need an implementation of netlocal to test (currently, only [avh4/netlocal-js](http://github.com/avh4/netlocal-js)).

```bash
bundle
# Start the netlocal implementation that you want to test on port 9999
rspec
```

## Development commands

 - Bootstrap: `bundle`
 - Build: `rbeautify -O spec/*.rb`
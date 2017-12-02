# weatherkun

It returns whether we should bring an umbrella today.

## setup

### install cpanm and carton (for all users)

```
$ sudo curl -L http://cpanmin.us | perl - --sudo App::cpanminus
$ sudo cpanm Carton
```

### install plugins

```
$ carton install
```

Please run the following command if cpanm fails:

```
$ sudo apt-get install libssl-dev
```

## exec

```
$ carton exec ./weatherkun.pl
```


# What is this?

This is a Dockerfile that _should_ create an image running the latest
[Dokuwiki](https://www.dokuwiki.org/dokuwiki) on Ubuntu 16.04.

## Why Dokuwiki?

I needed a wiki, wanted something easy to manage, and really didn't like
maintaining MediaWiki.  Furthermore, I figured this would be something easy to
start with on Docker.

Dokuwiki is small, does not need any kind of datastore, and has a "good enough"
text editor out of the box (have you ever seen the stock MediaWiki text
editor?).

## Why Ubuntu (instead of Alpine...)

I wanted to learn one thing at a time, and figured learning Docker was hard
enough without learning another whole packaging system.

I managed to get the final image down to 250MB or thereabouts, but I'm going to
investigate using Alpine going forward.

# Building

In the repo directory:

```
docker build -t dokuwiki .
```

# Running

Obviously change these!

```
LOCALCONF=/host/path/to/dokuwiki/conf
LOCALDATA=/host/path/to/dokuwiki/data
PORT=31337
docker run -d -v $LOCALCONF:/var/www/dokuwiki/conf \
              -v $LOCALDATA:/var/www/dokuwiki/data \
              -p $PORT:80 --name mydokuwiki dokuwiki
```

You will then need to do the [usual Dokuwiki setup
stuff](https://www.dokuwiki.org/install) starting at about step 4.

A word of warning -- I haven't actually tested these yet on a clean
installation, only to upgrade my existing install using a previous version of
this setup.

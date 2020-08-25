git-gsub
========

Evaluate ruby gsub script on git.

### Usage.
```sh
git gsub hoge piyo
git gsub '/hoge([0-9]+)/' 'piyo\#{$1.to_i + 1}'
git gsub '"piyo\#{4 + 1}"' 'piyo\#{$1.to_i + 1}'
```

### Getting started.

``` sh
curl https://raw.githubusercontent.com/katsusuke/git-gsub-ruby/master/git-gsub.rb > /usr/local/chmod +x /usr/local/bin/git-gsu
```

Edit your .gitconfig file
```
[alias]
  # add new line
	gsub = !/usr/local/bin/git-gsub
```

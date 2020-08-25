git-gsub
========

Evaluate ruby gsub script on git.

### Usage.
```sh
git gsub hoge piyo
git gsub -e '/hoge([0-9]+)/' 'piyo\#{$1.to_i + 1}'
git gsub -e '/belongs_to :(\w+)([^#\n]*)(#.*)?$/' '"belongs_to :#{$1}#{$2.include?("optional: false") ? $2 : $2.strip + ", optional: true"}#{$3 != nil ? " " + $3 : ""}"' 'app/models/**/*.rb'
```

### Getting started.

``` sh
curl https://raw.githubusercontent.com/katsusuke/git-gsub-ruby/master/git-gsub.rb > /usr/local/bin
chmod +x /usr/local/bin/git-gsu
```

Edit your .gitconfig file
```
[alias]
  # add new line
	gsub = !/usr/local/bin/git-gsub
```

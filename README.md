git-gsub-ruby
========

Replace text for all git controlled files by ruby gsub.

You can control the gsub replacement with the ruby script.

Inspired by [git-gsub](https://github.com/fujimura/git-gsub)


### Usage

```sh
git gsub hoge piyo
git gsub -e '/hoge([0-9]+)/' 'piyo\#{$1.to_i + 1}'
git gsub -e '/belongs_to :(\w+)([^#\n]*)(#.*)?$/' '"belongs_to :#{$1}#{$2.include?("optional: false") ? $2 : $2.strip + ", optional: true"}#{$3 != nil ? " " + $3 : ""}"' 'app/models/**/*.rb'
```

## Installation

    $ gem install git-gsub-ruby


Edit your .gitconfig file
```
[alias]
  # add new line
	gsub = !git-gsub-ruby
```
Or use `git config`

    $ git config --global alias.gsub '!git-gsub-ruby'


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/katsusuke/git-gsub-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/katsusuke/git-gsub-ruby/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Git::Gsub::Ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/katsusuke/git-gsub-ruby/blob/master/CODE_OF_CONDUCT.md).

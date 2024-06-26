## About

nanoc-tidy.rb is a
[nanoc](https://nanoc.app)
filter that adds
[tidy-html5](https://github.com/htacg/tidy-html5)
support to nanoc. <br>
The filter can format and validate HTML produced
during the
[nanoc](https://nanoc.app)
build process.

## Examples

__Defaults__

The following example executes tidy with the default settings. <br>
See [Nanoc::Tidy.default_argv](https://0x1eef.github.io/x/nanoc-tidy.rb/Nanoc/Tidy/Filter#default_argv-class_method)
for more details:

``` ruby
# Rules
require "nanoc-tidy"
compile "/index.html.erb" do
  layout("/default.*")
  filter(:erb)
  filter(:tidy)
  write("/index.html")
end
```

__Option: argv__

The argv option forwards command line arguments directly to
the tidy-html5 executable. <br>
[Nanoc::Tidy.default_argv](https://0x1eef.github.io/x/nanoc-tidy.rb/Nanoc/Tidy/Filter#default_argv-class_method)
returns the default command line arguments forwarded to
tidy-html5:

```ruby
# Rules
require "nanoc-tidy"
compile "/index.html.erb" do
  layout("/default.*")
  filter(:erb)
  filter(:tidy, argv: ["-upper"])
  write("/index.html")
end
```

__Option: exe__

The "exe" option can be used to change the default executable
from "tidy5" to something else, the most common alternative
might be "tidy":

```ruby
# Rules
require "nanoc-tidy"
compile "/index.html.erb" do
  layout("/default.*")
  filter(:erb)
  filter(:tidy, exe: "tidy")
  write("/index.html")
end
```

## Install

nanoc-tidy.rb can be installed via rubygems.org:

    gem install nanoc-tidy.rb

## Sources

* [GitHub](https://github.com/0x1eef/nanoc-tidy.rb#readme)
* [GitLab](https://gitlab.com/0x1eef/nanoc-tidy.rb#about)

## License

[BSD Zero Clause](https://choosealicense.com/licenses/0bsd/)
<br>
See [LICENSE](./LICENSE)

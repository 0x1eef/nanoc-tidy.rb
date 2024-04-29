## About

nanoc-tidy.rb is a
[nanoc](https://nanoc.app)
filter that integrates
[tidy-html5](https://github.com/htacg/tidy-html5)
into nanoc. <br>
The filter can format and validate HTML produced
during the
[nanoc](https://nanoc.app)
build process.

## Examples

__Defaults__

The following example uses the
[default command line arguments](https://0x1eef.github.io/x/nanoc-tidy.rb/Nanoc/Tidy/Filter#default_argv-class_method):

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

__Options__

The following example forwards a command line argument:

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

## <a id='install'>Install</a>

**Rubygems.org**

nanoc-tidy.rb can be installed via rubygems.org:

    gem install nanoc-tidy.rb

## Sources

* [GitHub](https://github.com/0x1eef/nanoc-tidy.rb#readme)
* [GitLab](https://gitlab.com/0x1eef/nanoc-tidy.rb#about)

## License

[BSD Zero Clause](https://choosealicense.com/licenses/0bsd/).
<br>
See [LICENSE](./LICENSE).

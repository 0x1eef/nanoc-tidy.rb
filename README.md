## About

nanoc-tidy.rb is a nanoc filter that utilizes
[tidy-html5](https://github.com/htacg/tidy-html5)
to nicely format, and detect / correct markup
errors in HTML produced by template languages such as ERB -
where misaligned indentation and other whitespace issues
are often commonplace.

## Examples

#### ERB

The following is an example with the
[default options](https://0x1eef.github.io/x/nanoc-tidy.rb/Nanoc/Tidy/Filter#default_options-class_method)
in effect:

``` ruby
# Rules
require "nanoc-tidy"
compile "/index.html.erb" do
  filter(:erb)
  filter(:tidy)
  write("/index.html")
end
```

#### Options

The following example forwards command-line options to
[tidy-html5](https://github.com/htacg/tidy-html5):

```ruby
# Rules
require "nanoc-tidy"
compile "/index.html.erb" do
  filter(:erb)
  filter(:tidy, "-upper" => true)
  write("/index.html")
end
```

## Sources

* [Source code (GitHub)](https://github.com/0x1eef/nanoc-tidy.rb)
* [Source code (GitLab)](https://gitlab.com/0x1eef/nanoc-tidy.rb)

## <a id='install'>Install</a>

nanoc-tidy.rb is distributed as a RubyGem through its git repositories. <br>
[GitHub](https://github.com/0x1eef/nanoc-tidy.rb),
and
[GitLab](https://gitlab.com/0x1eef/nanoc-tidy.rb)
are available as sources.

**Gemfile**

```ruby
gem "nanoc-tidy.rb", github: "0x1eef/nanoc-tidy.rb", tag: "v0.1.1"
```

## License

[BSD Zero Clause](https://choosealicense.com/licenses/0bsd/).
<br>
See [LICENSE](./LICENSE).

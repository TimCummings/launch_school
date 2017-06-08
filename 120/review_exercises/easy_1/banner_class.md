
[comment]: # (banner_class.md)

# Banner Class - 5/17/2017

#### Behold this incomplete class for constructing boxed banners.

``` ruby
class Banner
  def initialize(message)
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
  end

  def empty_line
  end

  def message_line
    "| #{@message} |"
  end
end
```

#### Complete this class so that the test cases shown below work as intended. You are free to add any methods or instance variables you need. However, do not make the implementation details public.

#### You may assume that the input will always fit in your terminal window.

#### Test Cases

``` ruby
banner = Banner.new('To boldly go where no one has gone before.')
puts banner
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
```
``` ruby
banner = Banner.new('')
puts banner
+--+
|  |
|  |
|  |
+--+
```

---

Solution:

``` ruby
class Banner
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+#{'-' * (message.size + 2)}+"
  end

  def empty_line
    "|#{' ' * (message.size + 2)}|"
  end

  def message_line
    "| #{@message} |"
  end
end

# Test Cases:
banner = Banner.new('To boldly go where no one has gone before.')
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('')
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+
```

---

### Further Exploration

#### Modify this class so `new` will *optionally* let you specify a fixed banner width at the time the `Banner` object is created. The message in the banner should be centered within the banner of that width. Decide for yourself how you want to handle widths that are either too narrow or too wide.

Solution:

``` ruby
class Banner
  MAX_WIDTH = 80
  PADDING = 2
  BORDER = 2
  MIN_WIDTH = PADDING + BORDER + 1

  attr_reader :message, :banner_width, :msg_width

  def initialize(msg, fixed_width = false)
    @message = msg

    @banner_width =
      if fixed_width
        validate_banner_width(fixed_width.to_i)
      else
        [(msg.size + PADDING + BORDER), MAX_WIDTH].min
      end

    @msg_width = @banner_width - BORDER - PADDING
  end

  # rubocop:disable Metrics/LineLength
  def validate_banner_width(fixed_width)
    if fixed_width < MIN_WIDTH
      puts "Specified banner width is less than minimum (#{MIN_WIDTH} characters.) Defaulting to minimum width."
      MIN_WIDTH
    elsif fixed_width > MAX_WIDTH
      puts "Specified banner width is greater than maximum (#{MAX_WIDTH} characters.) Defaulting to maximum width."
      MAX_WIDTH
    else
      fixed_width
    end
  end
  # rubocop:enable Metrics/LineLength

  def to_s
    lines = []
    lines << banner_header
    lines << banner_body
    lines << banner_footer

    lines.join("\n")
  end

  private

  def horizontal_rule
    "+#{'-' * (banner_width - BORDER)}+"
  end

  def empty_line
    "|#{' ' * (banner_width - BORDER)}|"
  end

  def message_line(msg)
    if msg.length < msg_width
      "| #{msg.ljust(msg_width)} |"
    else
      "| #{msg} |"
    end
  end

  def message_lines
    lines = []
    index = 0
    loop do
      lines << message_line(message.slice(index, msg_width))
      index += msg_width
      break if index >= message.length
    end
    lines
  end

  def banner_header
    horizontal_rule + "\n" + empty_line
  end

  def banner_body
    if (message.length + PADDING + BORDER) > banner_width
      message_lines
    else
      message_line(message)
    end
  end

  def banner_footer
    empty_line + "\n" + horizontal_rule
  end
end

# Test Cases:
banner = Banner.new('To boldly go where no one has gone before.')
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('')
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+

banner = Banner.new('To boldly go where no one has gone before.', 0)
puts banner
# Specified banner width is less than minimum (5 characters.) Defaulting to minimum width.
# +---+
# |   |
# | T |
# | o |
# |   |
# | b |
# | o |
# | l |
# | d |
# | l |
# | y |
# |   |
# | g |
# | o |
# |   |
# | w |
# | h |
# | e |
# | r |
# | e |
# |   |
# | n |
# | o |
# |   |
# | o |
# | n |
# | e |
# |   |
# | h |
# | a |
# | s |
# |   |
# | g |
# | o |
# | n |
# | e |
# |   |
# | b |
# | e |
# | f |
# | o |
# | r |
# | e |
# | . |
# |   |
# +---+

banner = Banner.new('To boldly go where no one has gone before.', 15)
puts banner
# +-------------+
# |             |
# | To boldly g |
# | o where no  |
# | one has gon |
# | e before.   |
# |             |
# +-------------+

banner = Banner.new('To boldly go where no one has gone before.', 80)
puts banner
# +------------------------------------------------------------------------------+
# |                                                                              |
# | To boldly go where no one has gone before.                                   |
# |                                                                              |
# +------------------------------------------------------------------------------+

banner = Banner.new('To boldly go where no one has gone before.', 1000)
puts banner
# Specified banner width is greater than maximum (80 characters.) Defaulting to maximum width.
# +------------------------------------------------------------------------------+
# |                                                                              |
# | To boldly go where no one has gone before.                                   |
# |                                                                              |
# +------------------------------------------------------------------------------+

```

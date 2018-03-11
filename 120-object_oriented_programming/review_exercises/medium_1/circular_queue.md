
[comment]: # (circular_queue.md)

### Circular Queue - 5/27/2017

#### A [circular queue](https://en.wikipedia.org/wiki/Circular_buffer) is a collection of objects stored in a buffer that is treated as though it is connected end-to-end in a circle. When an object is added to this circular queue, it is added to the position that immediately follows the most recently added object, while removing an object always removes the object that has been in the queue the longest.

#### This works as long as there are empty spots in the buffer. If the buffer becomes full, adding a new object to the queue requires getting rid of an existing object; with a circular queue, the object that has been in the queue the longest is discarded and replaced by the new object.

#### Assuming we have a circular queue with room for 3 objects, the circular queue looks and acts like this:

|P1|P2|P3|Comments                                        |
|--|--|--|------------------------------------------------|
|  |  |  |All positions are initially empty               |
| 1|	|  |Add 1 to the queue                              |
| 1| 2|  |Add 2 to the queue                              |
|  | 2|  |Remove oldest item from the queue (1)           |
|  | 2| 3|	Add 3 to the queue                            |
| 4| 2| 3|Add 4 to the queue, queue is now full           |
| 4|  | 3|Remove oldest item from the queue (2)           |
| 4| 5| 3|Add 5 to the queue, queue is full again         |
| 4| 5| 6|Add 6 to the queue, replaces oldest element (3) |
| 7| 5| 6|Add 7 to the queue, replaces oldest element (4) |
| 7|  | 6|Remove oldest item from the queue (5)           |
| 7|  |  |Remove oldest item from the queue (6)           |
|  |  |  |Remove oldest item from the queue (7)           |
|  |  |  |Remove non-existent item from the queue (nil)   |

#### Your task is to write a CircularQueue class that implements a circular queue for arbitrary objects. The class should obtain the buffer size with an argument provided to `CircularQueue::new`, and should provide the following methods:

* #### `enqueue` to add an object to the queue
* #### `dequeue` to remove (and return) the oldest object in the queue. It should return `nil` if the queue is empty.

#### You may assume that none of the values stored in the queue are `nil` (however, `nil` may be used to designate empty spots in the buffer).

#### Examples:

``` ruby
queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
```

#### The above code should display `true` 15 times.

---

### Solution:

``` ruby
class CircularQueue
  def initialize(size)
    @array = Array.new(size)
    @first = 0
    @last = 0
  end

  def enqueue(object)
    if empty?
      @array[first] = object
    else
      dequeue if full?
      increment_last
      @array[last] = object
    end
  end

  def dequeue
    if empty?
      nil
    else
      result = @array[first]
      @array[first] = nil
      increment_first
      result
    end
  end

  private

  attr_reader :first, :last

  def empty?
    @array[first].nil?
  end

  def full?
    (first + @array.size - 1 == last) || (first == last + 1)
  end

  def increment_first
    @first =
      if @first + 1 == @array.size
        0
      else
        @first + 1
      end
  end

  def increment_last
    @last =
      if @last + 1 == @array.size
        0
      else
        @last + 1
      end
  end
end
```

---

### Refactor:

``` ruby
class CircularQueue
  def initialize(size)
    @array = Array.new(size)
    @first = 0
    @last = 0
  end

  def enqueue(object)
    if empty?
      @array[first] = object
    else
      dequeue if full?
      @last = increment(last)
      @array[last] = object
    end
  end

  def dequeue
    if empty?
      nil
    else
      result = @array[first]
      @array[first] = nil
      @first = increment(first)
      result
    end
  end

  private

  attr_reader :first, :last

  def empty?
    @array[first].nil?
  end

  def full?
    first == increment(last)
  end

  def increment(index)
    (index + 1) % @array.size
  end
end
```

---

### Further Exploration

#### Phew. That's a lot of work, but it's a perfectly acceptable solution to this exercise. However, there is a simpler solution that uses an `Array`, and the `#push` and `#shift` methods. See if you can find a solution that does this. And no, you're not allowed to monkey-patch the `Array` class, though doing so may help you determine what needs to be done.

``` ruby
class CircularQueue
  def initialize(size)
    @max_size = size
    @array = []
  end

  def enqueue(object)
    dequeue if full?
    @array.push(object)
    # prevent direct access to `@array` via return value
    object
  end

  def dequeue
    @array.shift
  end

  def full?
    @array.size == @max_size
  end
end
```

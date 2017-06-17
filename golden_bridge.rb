class Array
  def convert_to_integer
    return [] if empty?

    map(&:to_i)
  end

  def quicksort
    return [] if empty?

    pivot = delete_at(rand(size))
    left, right = partition(&pivot.method(:>))

    return *left.quicksort, pivot, *right.quicksort
  end
end

class GoldenBridge
  attr_accessor :received_array

  def initialize(received_array)
    @received_array = prepare_data(received_array)
  end

  def prepare_data(received_array)
    received_array.convert_to_integer.quicksort
  end

  def parent_array
    @parent_array ||= [Array.new, Array.new]
  end

  def sort_numbers_by_y_axis
    prepare_arrays_for_heels
    parent_array.flatten!
  end

  def prepare_arrays_for_heels
    insert_side = 'front'

    while received_array.count > 0 do
      parent_array.each do |child|
        if insert_side == 'front'
          child.insert(0, received_array.pop)
        else
          child << received_array.pop
        end
        child.compact!
      end
      insert_side = detect_next(insert_side)
    end
  end

  def detect_next(side)
    side == 'front' ? 'back' : 'front'
  end
end
array = %w(1 2 2 1 26 37 1 45 72 72 72 72 43 22 1 33 21 2 15 16 1 48 26 1 28)
# array = (0..26).map{rand(0..300)}
golden_bridge = GoldenBridge.new(array)
p golden_bridge.sort_numbers_by_y_axis

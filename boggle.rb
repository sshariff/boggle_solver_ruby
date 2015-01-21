require 'ruby-dictionary'

$dictionary = Dictionary.new(%w( cab cabbage cad bad dab back backpack))

puts $dictionary.exists?('cabb')

puts $dictionary.starting_with('cabb')

#$size = 3
$size = 2
$depth = 0
$words = Array.new

true3 = Array.new(3,true)

#untried = [true3,true3,true3]
untried = Array.new($size*$size, true)


#grid = [['a','f','t'],['b','a','g'],['c','a','t']]
#grid = ['a','b','c','d','e','f','g','h','i']
grid = ['a','b','c','d']
#subgrid = grid[1]
#puts "subgrid is #{subgrid}"
#subgrid[2]='z'
#grid[1] = subgrid


#puts grid[0..2].join
#puts grid[3..5].join
#puts grid[6..8].join
puts grid[0..1].join
puts grid[2..3].join

gets

class Point
  attr_reader :x, :y
  
  def initialize(x=0,y=0)
    @x, @y = x, y
  end
  
  def +(other)
    Point.new(@x + other.x, @y + other.y)
  end
  
  def to_s
    "(#@x,#@y)"
  end
end

zero  = Point.new(-1,-1)
one   = Point.new( 0,-1)
two   = Point.new( 1,-1)
three = Point.new( 1, 0)
four  = Point.new( 1, 1)
five  = Point.new( 0, 1)
six   = Point.new(-1, 1)
seven = Point.new(-1, 0)

$stencil = {0=>zero, 1=>one, 2=>two, 3=>three, 4=>four,
            5=>five, 6=>six, 7=>seven}

sum = zero+one

#neighbor = Point.new(0,0)

$val = lambda { |a,i,j| a[$size*j + i]  }
$elem = lambda { |i,j| $size*j + i }

def traverse(index,untried,grid,string)

  last=Point.new
    puts "\n\nentering traverse"
    puts "untried(0,1) is #{untried[0..1]}"
    puts "untried(2,3) is #{untried[2..3]}"

    puts "depth = #{$depth}, index is #{index}"
 
 
  (0..7).each {|s|
       puts "s = #{s}"
    neighbor = index + $stencil[s]
#      offset = Point.new(x,y)
#      puts "i=#{i}, j=#{j}, s=#{s}, #{blah.class}"
    x = neighbor.x
    y = neighbor.y
    if (x.between?(0,$size-1) && y.between?(0,$size-1) &&
        $val.call(untried,x,y) )
      puts "neighbor is #{neighbor}"
      letter = $val.call(grid,x,y)
      puts "letter is #{letter}"
      string += letter
      if (string.length > 2 && $dictionary.exists?(string) )
 #     if (string.length > 2 )
 
     
        $words.push(string)
        puts "words is now #{$words}"
      end
      puts "string is #{string}"
      last = index
      index = neighbor
      untried[$elem.call(x,y)] = false
      puts "calling traverse, index is #{index}"
      $depth += 1
      traverse(index,untried,grid,string)
      puts "string was #{string}"
      string = string[0..-2]
      puts "string is #{string}"
      index = last
    elsif ( !x.between?(0,$size-1) || !y.between?(0,$size-1) )
      puts "out of bounds, #{x},#{y}"
    else
      puts "unused #{x},#{y} is used"
      puts "string is #{string}"
      puts "returning"
    end
        
      
  }
  puts "\n\ndropping out one level of recursion, depth=#{$depth}"
  untried[$elem.call(index.x,index.y)] = true
  puts "string was #{string}, index is #{index}"
  puts "untried(0,1) is #{untried[0..1]}"
  puts "untried(2,3) is #{untried[2..3]}"
  $depth -= 1  
end

puts "#{sum.x}, #{sum.y}"
puts "\n Here we go\n\n"

(0...$size).each {|j|
  (0...$size).each {|i|
#    i=0; j=1
    
#    unused = [[true,true,true],[true,true,true],[true,true,true]]
     untried = Array.new($size*$size,true)
#    string = grid [i][j]
    string = $val.call(grid,i,j)
    puts "string is #{string}\n\n"
    
#    subused = unused[j]
#    subused[i] = false
 
    untried[$elem.call(i,j)] = false
    
    puts "untried[0] is #{untried[0..2]}"
    puts "untried[1] is #{untried[3..5]}"
    puts "untried[2] is #{untried[6..8]}"
    
  
    index = Point.new(i,j)
    puts "index is #{index}"
    
    puts "calling traverse"
    traverse(index,untried,grid,string)
    }
  }

puts "+++++++++++++++++++++++++++++++"
puts "The list of words is #{$words}"
puts "+++++++++++++++++++++++++++++++"

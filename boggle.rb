$size = 3


true3 = Array.new(3,true)

#untried = [true3,true3,true3]
untried = Array.new($size*$size, true)


#grid = [['a','f','t'],['b','a','g'],['c','a','t']]
grid = ['a','f','t','b','a','g','c','a','t']
#subgrid = grid[1]
#puts "subgrid is #{subgrid}"
#subgrid[2]='z'
#grid[1] = subgrid


puts grid[0..2].join
puts grid[3..5].join
puts grid[6..8].join

stencil = {0=>[-1,-1], 1=>[0,-1], 2=>[1,1], 3=>[1,0], 4=>[1,1], 5=>[0,1],
     6=>[-1,1], 7=>[-1,0]}

tx = stencil[4][0] + stencil[7][0]
ty = stencil[4][1] + stencil[7][1]
puts tx, ty

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

def traverse(index,untried)
  (0..7).each {|s|
    neighbor = index + $stencil[s]
#      offset = Point.new(x,y)
#      puts "i=#{i}, j=#{j}, s=#{s}, #{blah.class}"
    x = neighbor.x
    y = neighbor.y
    if (x.between?(0,$size-1) && y.between?(0,$size-1) &&
        $val.call(untried,x,y) )
      puts "neighbor is #{neighbor}"
    elsif !$val.call(untried,x,y)
      puts "unused #{x},#{y} is used"
    end
        
  }
end

puts "#{sum.x}, #{sum.y}"
puts "\n Here we go\n\n"

#(0...$size).each {|j|
#  (0...$size).each {|i|
    i=1; j=1
    
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
    traverse(index,untried)
 #   }
#  }   

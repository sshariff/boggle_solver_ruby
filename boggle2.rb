require 'ruby-dictionary'

$dictionary = Dictionary.from_file('good_words2')

#$traverse_count = 0

$size = 4
$words = Array.new

puts "\n\nYou can enter the grid or use the hardcoded one"
puts "Enter grid?  (y/n)"
answer=gets.chomp

if answer=='y'
  puts "Enter first row as four characters (for example: btro)"
  grid=[]
  line = gets.chomp.downcase
     
  (0..$size-1).each { |i|
    if line.size != $size
      puts "That wasn't 4 characters.  Sorry, better luck next time."
      return
    else
      grid += line.split('')
      if i<$size-1
        puts "Enter next line"
        line = gets.chomp.downcase
      end         
    end
  }
else
  grid = ['b','a','d','n',\
          'a','l','d','k',\
          'c','k','p','a',\
          'd','o','k','c']
     
end

puts
puts grid[0..3].join
puts grid[4..7].join
puts grid[8..11].join
puts grid[12..15].join


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

#  this is a set of offsets to get to adjacent letters
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

$val = lambda { |a,i,j| a[$size*j + i]  }
$elem = lambda { |i,j| $size*j + i }

def traverse(index,untried,grid,string)

#  $traverse_count += 1
  last=Point.new
 
  (0..7).each {|s|
    neighbor = index + $stencil[s]
    x = neighbor.x
    y = neighbor.y
#  is this location in the grid and have we used it yet?    
    if (x.between?(0,$size-1) && y.between?(0,$size-1) && \
        $val.call(untried,x,y) )
         
      letter = $val.call(grid,x,y)
      string += letter

#  see if any words start with these letters      
      if $dictionary.starting_with(string).size == 0
        string = string[0..-2]
        next
      end

#  is this a word we should add to the list?      
      if (string.length > 2 && $dictionary.exists?(string) \
           && !$words.include?(string) )
     
        $words.push(string)
        
      end

      last = index
      index = neighbor
      untried[$elem.call(x,y)] = false
#  keep going      
      traverse(index,untried,grid,string)
#  back out one letter
      string = string[0..-2]
      index = last
     end
        
      
  }

  untried[$elem.call(index.x,index.y)] = true

end

puts "\n Here we go\n\n"

(0...$size).each {|j|
  (0...$size).each {|i|

#  new starting letter       
    untried = Array.new($size*$size,true)
    
    string = $val.call(grid,i,j)
    untried[$elem.call(i,j)] = false      
    index = Point.new(i,j)
    
    traverse(index,untried,grid,string)
    }
  }

puts "Would you like the words sorted alphabetically or by size? (a/s)"
answer = gets.chomp
if answer=='a'
  $words.sort!
elsif answer=='s'
  $words = ($words.sort_by {|x| x.size }).reverse
else
  puts "that wasn't a or s, bye!"
end

#puts "traverse count is #{$traverse_count}"
puts "+++++++++++++++++++++++++++++++"
puts "The list of words is #{$words}"
puts "+++++++++++++++++++++++++++++++"

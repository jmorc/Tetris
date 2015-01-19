class Tetronimo
  attr_accessor :pos, :shape, :orientation
  
  def initialize(shape)
    @shape = shape
    @pos = [19, 3]
    @orientation = 1
  end   
  
  O_TETRONIMO = []
  J_TETRONIMO = []
  
  # can add T_TETRONIMO, L_TETRONIMO, etc...
  # each subarray is a rotation of the tetronimo
  
  O_TETRONIMO[0] = [[0, 0, 0, 0],
                    [0, 0, 0, 0],
                    [0, 1, 1, 0], 
                    [0, 1, 1, 0]]
                  
  O_TETRONIMO[1] = O_TETRONIMO[0]
  O_TETRONIMO[2] = O_TETRONIMO[0]
  O_TETRONIMO[3] = O_TETRONIMO[0]

        
  J_TETRONIMO[0] = [[0, 0, 0, 0],
                    [1, 1, 1, 0],
                    [0, 0, 1, 0], 
                    [0, 0, 0, 0]] 

  J_TETRONIMO[1] = [[0, 0, 1, 0],
                    [0, 0, 1, 0],
                    [0, 1, 1, 0], 
                    [0, 0, 0, 0]] 
          
  J_TETRONIMO[2] = [[0, 0, 0, 0],
                    [0, 1, 0, 0],
                    [0, 1, 1, 1], 
                    [0, 0, 0, 0]] 

  J_TETRONIMO[3] = [[0, 0, 0, 0],
                    [0, 1, 1, 0],
                    [0, 1, 0, 0], 
                    [0, 1, 0, 0]]
                    
  def dup_tetronimo
    dup_shape = []
    @shape.each { |row| dup_shape << row }
    dup_pos = []
    @pos.each { |el| dup_pos << el }

    dup_tetronimo = Tetronimo.new(dup_shape)
    dup_tetronimo.pos = dup_pos
    dup_tetronimo.orientation = @orientation
    
    dup_tetronimo
  end
end
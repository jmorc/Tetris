class Tetromino
  attr_accessor :pos, :shape, :orientation
  
  def initialize(shape)
    @shape = shape
    @pos = [19, 3]
    @orientation = 1
  end   
  
  O_TETROMINO = []
  J_TETROMINO = []
  
  # only O and J tetrominos are defined below
  # can add T_TETROMINO, L_TETROMINO, etc...
  # each subarray is a rotation of the tetronimo
  
  O_TETROMINO[0] = [[0, 0, 0, 0],
                    [0, 0, 0, 0],
                    [0, 1, 1, 0], 
                    [0, 1, 1, 0]]
                  
  O_TETROMINO[1] = O_TETROMINO[0]
  O_TETROMINO[2] = O_TETROMINO[0]
  O_TETROMINO[3] = O_TETROMINO[0]

        
  J_TETROMINO[0] = [[0, 0, 0, 0],
                    [1, 1, 1, 0],
                    [0, 0, 1, 0], 
                    [0, 0, 0, 0]] 

  J_TETROMINO[1] = [[0, 0, 1, 0],
                    [0, 0, 1, 0],
                    [0, 1, 1, 0], 
                    [0, 0, 0, 0]] 
          
  J_TETROMINO[2] = [[0, 0, 0, 0],
                    [0, 1, 0, 0],
                    [0, 1, 1, 1], 
                    [0, 0, 0, 0]] 

  J_TETROMINO[3] = [[0, 0, 0, 0],
                    [0, 1, 1, 0],
                    [0, 1, 0, 0], 
                    [0, 1, 0, 0]]
                    
  def dup_tetromino
    dup_shape = []
    @shape.each { |row| dup_shape << row }
    dup_pos = []
    @pos.each { |el| dup_pos << el }

    dup_tetromino = Tetromino.new(dup_shape)
    dup_tetromino.pos = dup_pos
    dup_tetromino.orientation = @orientation
    
    dup_tetromino
  end
end
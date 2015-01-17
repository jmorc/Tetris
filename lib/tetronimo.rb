
class Tetronimo
  attr_accessor :pos, :shape
  
  def initialize(shape)
    @shape = shape
    @pos = [19, 3]
    @orientation = 1
  end   
  
  O_TETRONIMO = []
  J_TETRONIMO = []
  
  
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
                   
end




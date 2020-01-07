' Roku Pappu Pakia
' Developed by Artyom Isayev (Artem Isaiev) https://github.com/aisayev

sub initPappu()

	m.Pappu = {

    	x: 50,
    	y: 10,
    	w: 60,
    	h: 60,

    	invincible: false,
    	invincibility_start: 0,
    	invincibility_time: 0,
    	clones: [],
      sprites: [],
    	rotate_angle: 0,
    	change_per_frame: 10,
    	fly_frame_count: 0,
    	max_fly_frame_count: 10,

    	init: function()
      	
          mit = GetGlobalAA()
     		  
          for i = 0 to 7
            m.sprites[i] = clipImage(mit.image.pappu, 0, i*m.h, m.w, m.h)
          end for

          m.falling_img = mit.image.falling
      		m.max_fly_frame_count = 7
      		m.change_per_frame = 1.6
      		m.x = 50
          m.screen_w = mit.w
          m.screen_h = mit.h
    	
    	end function,

		  createClones: function(count)

          mit = GetGlobalAA()
          clones = []
      		for i = 0 to (count - 1)
      		  pappu_clone = {}
				    pappu_clone.append(mit.pappu)
        		pappu_clone.invincible = false
		       	clones.push(pappu_clone)
      		end for
      		m.clones = clones

		  end function,

    	drawStatic: function() 

            mit = GetGlobalAA()
            m.y = mit.Backgrounds.log_y-42

            frame = int(m.fly_frame_count / m.change_per_frame)
    	      drawImage(m.sprites[frame], m.x, m.y)

    	end function,


      draw: function() 

            mit = GetGlobalAA()
   
            if (mit.game_over) then
              drawImage(m.falling_img, m.x, m.y)
            else
              frame = int(m.fly_frame_count / m.change_per_frame)
              drawImage(m.sprites[frame], m.x, m.y)
            end if

      end function


      hasReachedBoundary: function() 
        return ((m.y < 10) or (m.y > (m.screen_h - 100)) or (m.x < 0) or (m.x > m.screen_w - 50))
      end function,


      getBounds: function()
          
          b = {}
          b.start_x = m.x + 5
          b.start_y = m.y + 5
          b.end_x   = m.x + m.w - 5
          b.end_y   = m.y + m.h - 5
          return b

      end function,

	    updateFlyFrameCount: function(count=invalid)
      	
      		if (count = invalid) then
        		m.fly_frame_count++

        		if (cint(m.fly_frame_count/m.change_per_frame) > m.max_fly_frame_count) then
          			m.fly_frame_count = 0
        		end if

      		else
      	    	m.fly_frame_count = count
      		end if

      	end function	

	}

	m.Pappu.init()

end sub
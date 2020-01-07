' Roku Pappu Pakia
' Developed by Artyom Isayev (Artem Isaiev) https://github.com/aisayev

sub initForks()

	m.Fork = {

    	x:	0,
    	y:	0,
    	w:	28,
    	h:	400,

    	head_x: 0,
    	head_y: 0,
    	head_w: 0,
    	head_h: 0,

    	edge: 1,

    	getHandleBounds: function()

    	    b = {}
      		b.start_x = m.x + 5
      		b.start_y = m.y + 5
      		b.end_x   = m.x + m.w - 5
      		b.end_y   = m.y + m.h - 5
      		return b

    	end function
	}

	m.ForkUtils = {	

			forks:	[],
			count: 6,

			init: function()

            mit = GetGlobalAA()
      			m.fork_top_img = mit.image.fork_top
            m.fork_bottom_img = mit.image.fork_bottom

			end function,

			getRandomForkPos: function()

      			mit = GetGlobalAA()
      			p = {}
      			if (m.forks[m.forks.count()-1] <> invalid) then
        			p.x = m.forks[m.forks.count()-1].x

        			if (mit.score > 2500) then
          				p.x += Random(300, 600)
        			else
          				p.x += Random(300, 600)
          		end if	
      			else
        			p.x = mit.W + 50
      			end if

      			return p

    	end function,

      checkCollision: function() 

          mit = GetGlobalAA()

          first_fork = m.forks[0]

          if (first_fork.x > 200) then
              return true
          end if

          pappu_bounds = mit.Pappu.getBounds()
          fork_bounds = first_fork.getHandleBounds()

          if (Intersect(pappu_bounds, fork_bounds)) then
            gameOver()
          end if

      end function,

			create: function()

       			mit = GetGlobalAA()
       			forks = m.forks
       			count = m.count

      			if (forks.count() < count) then
        
        			for i = 0 to (count - forks.count() - 1)
          				fork = {}
          				fork.append(mit.Fork)
          				fork.edge = Random(0,1)

          				if (fork.edge = 1) then
            				fork.y = 320 + Random(0,150)
            			else
            				fork.y =  0 - Random(0,150)
            			end if

          				p = m.getRandomForkPos()
          				fork.x = p.x

          				forks.push(fork)
        			end for
        		end if

			end function,

			draw: function()

            	mit = GetGlobalAA()

          		dead_forks = 0

          		m.create()

          		for index = 0 to (m.forks.count() - 1)
          			
          			fork = m.forks[index]
          			
          			fork.x -= mit.Backgrounds.ground_bg_move_speed
					
                if (fork.x + fork.w < 0) then
                  dead_forks++
					    
                else if (fork.x < mit.W) then
        
					        if (fork.edge = 0) then 
                    drawImage(m.fork_top_img, fork.x, fork.y)
                  else
                    drawImage(m.fork_bottom_img, fork.x, fork.y)
                  end if
                end if
          		
              end for

            if (dead_forks > 0) then
              
              for i = 1 to dead_forks
                 m.forks.shift()
              end for

            end if

			end function
	}

	m.ForkUtils.init() 

end sub
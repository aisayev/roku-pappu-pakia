' Roku Pappu Pakia
' Developed by Artyom Isayev (Artem Isaiev) https://github.com/aisayev

sub initBranches()

	m.Branch = {
    	x: 0, 
    	y: 0,
    	w: 0,
    	h: 0,
    	escape_x: 0,
    	escape_y: 0,
    	escape_w: 0,
    	escape_h: 0,

    	getBounds: function()
      		
      		b = {}
      		b.start_x = m.x
      		b.start_y = m.y
      		b.end_x   = m.x + m.w
      		b.end_y   = m.y + m.h
      		return b
    	
    	end function,

    	getEscapeBounds: function()
      		
      		b = {}
      		b.start_x = m.escape_x
      		b.start_y = m.escape_y
      		b.end_x   = m.escape_x + m.escape_w
      		b.end_y   = m.escape_y + m.escape_h
      		return b
    	end function
  
  	}

  	m.BranchUtils = {

    	branches: [],
    	count: 4,

    	init: function()

          mit = GetGlobalAA()
      		m.branch_img = mit.image.branch
      		m.branch_img_width = m.branch_img.GetWidth()
      		m.branch_img_height = m.branch_img.GetHeight()
   
      	end function, 

    	getRandomBranchPos: function() 
      
      		mit = GetGlobalAA()
      		p = {}

      		if (m.branches[m.branches.count()-1] <> invalid) then
        		p.x = m.branches[m.branches.count()-1].x
        		p.x += Random(500, 2000)
      		else 
        		p.x = Random(1500, 2000)
      		end if

      		forks = mit.ForkUtils.forks
      		count = forks.count()
      
      		if (count > 0) then
      			for i = 0 to (count - 1)
        			if (abs(p.x - forks[i].x) < 500) then
        				p.x = forks[i].x + 500
        			end if
        		end for
      		end if 
      		return p
    	
    	end function,


    	create: function() 

      		mit = GetGlobalAA()
      		if (m.branches.count() < m.count) then
      			for i = 0 to (m.count - m.branches.count() - 1) 
          			branch = {}
          			branch.append(mit.Branch)

          			p = m.getRandomBranchPos()
          			branch.x = p.x
          			branch.y = 0

          			branch.w = m.branch_img_width
          			branch.h = m.branch_img_height

          			branch.escape_x = branch.x
          			branch.escape_y = branch.y + Random(0, branch.h-150)

          			branch.escape_w = m.branch_img_width
          			branch.escape_h = 150

          			m.branches.push(branch)
        		end for
      		end if
    	end function,

    	draw: function()
			mit = GetGlobalAA()
      		dead_branch = 0
	  		m.create()

	  		for index = 0 to (m.branches.count() - 1)
       			branch = m.branches[index]
		        branch.x -= mit.Backgrounds.ground_bg_move_speed

                if (branch.x + branch.w < 0) then
          			dead_branch++
          		else if (branch.x < mit.W)

          			branch.escape_x = branch.x
   			        drawImage(m.branch_img, branch.x, branch.y)
					fillRect(branch.escape_x, branch.escape_y, branch.escape_w, branch.escape_h, &hFFFFFFFF)

          		end if

	  		end for

            if (dead_branch > 0) then
              
              for i = 1 to dead_branch
                 m.branches.shift()
              end for

            end if

    	end function
    }

	m.BranchUtils.init()

end sub
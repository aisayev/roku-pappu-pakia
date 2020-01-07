' Roku Pappu Pakia
' Developed by Artyom Isayev (Artem Isaiev) https://github.com/aisayev

sub initBackgrounds()

    m.Backgrounds = {
	    common_bg_speed: 1,

    	cloud_bg_move_speed: 0,
    	cloud_bg_vx: 0,

    	backtree_bg_move_speed: 0,
    	backtree_bg_vx: 0,

    	fronttree_bg_move_speed: 0,
    	fronttree_bg_vx: 0,

    	ground_bg_move_speed: 0,
    	ground_bg_vx: 0,

    	combined_bg_move_speed: 0,
    	combined_bg_vx: 0,

    	log_x: 60,
    	log_y: 0,
        log_height: 0,
        log_width: 0,

        w: 0,
        h: 0,
        game_started: false,
        speed: 0,
        score: 0,

    	init: function() 
            
            mit = GetGlobalAA()

    		m.sky_gradient = mit.image.sky_gradient
            m.cloud_img = mit.image.clouds
            m.backtree_img = mit.image.backtrees
            m.fronttree_img = mit.image.fronttrees
            m.ground_img = mit.image.ground
            m.grass_img = mit.image.grass
            m.log_img = mit.image.log
            m.combined_bg_img = mit.image.bg_combined
            m.title_img = mit.image.title
            m.top_img = mit.image.top

            m.W = mit.W 
            m.H = mit.H 
            
            m.log_height = m.log_img.GetHeight()
            m.log_width = m.log_img.GetWidth()
            m.log_y = m.H-(m.log_height+45)

            m.resetAllSpeed()

       	end function,

        resetAllSpeed: function() 

            m.cloud_bg_move_speed = 2
            m.backtree_bg_move_speed = 3
            m.fronttree_bg_move_speed = 5
            m.ground_bg_move_speed = 7
            m.combined_bg_move_speed = 3
            m.log_x = 60
            
        end function,

        drawGradient: function()
            clearImage(&h86DEF7FF)
            
        end function,

        drawClouds: function()

            drawImage(m.cloud_img, m.cloud_bg_vx, 0)
            drawImage(m.cloud_img, m.cloud_bg_vx + m.W, 0)
            
            m.cloud_bg_vx -= m.cloud_bg_move_speed
            if (-m.cloud_bg_vx >= m.W) then
                m.cloud_bg_vx = 0
            end if

        end function,

        drawBackTrees: function() 

            drawImage(m.backtree_img, m.backtree_bg_vx, 450)
            drawImage(m.backtree_img, m.backtree_bg_vx + m.W, 450)

            if (m.game_started) then
                m.backtree_bg_vx -= m.backtree_bg_move_speed * m.common_bg_speed
            end if
            if (-m.backtree_bg_vx >= m.W) then
                m.backtree_bg_vx = 0
            end if

        end function,

        drawFrontTrees: function() 

            drawImage(m.fronttree_img, m.fronttree_bg_vx, 330)
            drawImage(m.fronttree_img, m.fronttree_bg_vx + m.W, 330)
      
            if (m.game_started) then
                m.fronttree_bg_vx -= m.fronttree_bg_move_speed * m.common_bg_speed
            end if
            if (-m.fronttree_bg_vx >= m.W) then
                m.fronttree_bg_vx = 0
            end if

        end function,

        drawGround: function() 

            drawImage(m.ground_img, m.ground_bg_vx, 570)
            drawImage(m.ground_img, m.ground_bg_vx + m.W, 570)

            drawImage(m.top_img, m.ground_bg_vx, 0)
            drawImage(m.top_img, m.ground_bg_vx + m.W, 0)

            if (m.game_started) then
                m.ground_bg_vx -= m.ground_bg_move_speed * m.common_bg_speed
            end if
            if (-m.ground_bg_vx >= m.W) then
                m.ground_bg_vx = 0
            end if

        end function,

        drawInitLog: function()

            if ( (m.log_x + m.log_width) > 0 ) then
                drawImage(m.log_img, m.log_x, m.log_y)
                if (m.game_started) then
                    m.log_x -= m.ground_bg_move_speed * m.common_bg_speed
                end if
            end if
        
        end function,

        drawScore: function(score)
            typeText(score.tostr(), 40, 20)
        end function,

        drawTitle: function(high, score)
            drawImage(m.title_img, 390, 40)
            if (high > 0) then 
                centerText("High Score: " + high.tostr(), 176)
            end if
            if (score > 0) then 
                centerText("Last Score: " + score.tostr(), 216)
            end if
        end function,

        draw: function()
            
            mit = GetGlobalAA()
            m.game_started = mit.game_started
            m.start_btn_clicked = mit.start_btn_clicked
            score = int(mit.score)

            m.drawGradient()
            m.drawClouds()
            m.drawBackTrees()
            m.drawFrontTrees()
            
            if (m.start_btn_clicked) then 
                m.drawInitLog()
            else
                m.drawTitle(mit.high, score)
            end if

        end function

    }

    m.Backgrounds.init()

end sub
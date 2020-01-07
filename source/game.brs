' Roku Pappu Pakia
' Developed by Artyom Isayev (Artem Isaiev) https://github.com/aisayev

sub renderGame()

    m.timer.Mark()

    m.Backgrounds.draw()
    
    if (m.start_btn_clicked) then

        if (m.game_started and not m.game_over) then
            m.score += 0.1
        end if

        if (m.flying_up or not m.game_started) then
            m.Pappu.updateFlyFrameCount()
        else
            m.Pappu.updateFlyFrameCount(0)
        end if

        if (m.Pappu.hasReachedBoundary()) then
            if (not m.game_over) gameOver()
        end if

	    if (m.game_started) then
 		    m.ForkUtils.draw()

            if (not m.Pappu.invincible) then
                m.ForkUtils.checkCollision()
                m.PakiaUtils.checkCollision()
            end if
      
            if (m.score > 100) then
                m.PakiaUtils.render()
            end if

            if (not m.game_over) then
                if ((m.vy < m.v_cap and m.ay+m.gravity > 0) or (m.vy > -m.v_cap and m.ay+m.gravity < 0)) then
                    m.vy += m.ay
                    m.vy += m.gravity
                end if

                m.Pappu.x += m.vx
                m.Pappu.y += m.vy

                if (m.vy > m.v_cap) then
                    m.vy = m.v_cap
                end if
            else 
                m.vy += m.gravity
                m.Pappu.y += m.vy
            end if
            
            m.Backgrounds.drawGround()
            
            m.Pappu.draw()

            drawScore(int(m.score))

            if (m.Pappu.y > m.H and m.start_btn_clicked) then
                gameStop()
            end if

	    else
          m.Backgrounds.drawGround()
		  m.Pappu.drawStatic()
	    end if
    else
        m.Backgrounds.drawGround()
    end if

    requestAnimationFrame()
	
end sub

sub gameOver()
    score = int(m.score)
    if (score > m.high) then
        m.high = score
        m.storage.Write("high", score.tostr())
        m.storage.Flush()
    end if
    m.game_over = true
    descend()
    reportEvent("end", "score", score.tostr())
end sub

sub gameStop()
    m.game_started = false
    m.start_btn_clicked = false
end sub

sub startGame()
    reportEvent("start")
    m.start_btn_clicked = true
    m.game_started = false
    m.Backgrounds.common_bg_speed = 1
    m.Backgrounds.resetAllSpeed()
    m.Pappu.drawStatic()
    m.ax = 0 
    m.ay = 0
    m.vx = 0
    m.vy = 0
    m.Pappu.rotate_angle = 0
    m.score = 0
    m.ForkUtils.forks = []
    m.PakiaUtils.pakias = []
    m.PakiaUtils.cur_pakia = invalid
end sub

sub ascend() 
    if (m.start_btn_clicked) then
        if (not m.game_started) then
            m.game_started = true
            m.game_over = false
        end if
        m.ay = -1.5
        m.flying_up = true
    end if
end sub

sub descend()
    if (m.start_btn_clicked) then
        m.ay = 0
        m.flying_up = false
    end if
end sub

sub togglePause()
    m.game_paused = not m.game_paused
end sub

sub drawScore(score)
    typeText(score.tostr(), 40, 20)
end sub

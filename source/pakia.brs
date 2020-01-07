' Roku Pappu Pakia
' Developed by Artyom Isayev (Artem Isaiev) https://github.com/aisayev

sub initPakia()

  m.Pakia = {

    type: "angry",
    gravity: 0.25,
    has_stuck: false,

    x: 0,
    y: 0,
    w: 52,
    h: 51,
    pakia_img: {},

    init: function()

      mit = GetGlobalAA()
      m.screen_w = mit.W
      m.screen_h = mit.H
      m.pakia_img.sad = mit.image.sad_pakia
      m.pakia_img.happy = mit.image.happy_pakia
      m.pakia_img.angry = mit.image.angry_pakia

    end function,

    draw: function() 
      drawImage(m.pakia_img[m.type], m.x, m.y)
    end function,

    generateRandomPos: function()
      m.x = m.screen_w/2 + 200
      m.y = m.screen_h
    end function, 

    generateRandomVelocity: function()
      m.vx = -12
      m.vy = Random(-18,-10)
    end function,

    getBounds: function()
      
      bounds = {}

      bounds.start_x = m.x
      bounds.start_y = m.y
      bounds.end_x = m.x + m.w
      bounds.end_y = m.y + m.h

      return bounds
    end function
  }


  m.PakiaUtils = {

    pakias: [],
    cur_pakia: invalid,

    types: ["sad", "happy", "angry"],

    createPakias: function() 

      mit = GetGlobalAA()

      for i = 0 to 2 
        pakia = {} 
        pakia.append(mit.Pakia)
        pakia.generateRandomPos()
        pakia.generateRandomVelocity()

        pakia.type = m.types[i]
        m.pakias.push(pakia)
      end for

    end function,

    reflow: function()

      if (m.cur_pakia = invalid)
        m.cur_pakia = m.pakias[Random(0,2)]
        m.cur_pakia.generateRandomPos()
        m.cur_pakia.generateRandomVelocity()
      end if

      m.cur_pakia.vy += m.cur_pakia.gravity

      m.cur_pakia.x += m.cur_pakia.vx
      m.cur_pakia.y += m.cur_pakia.vy

      if ((m.cur_pakia.x + m.cur_pakia.w < 0) or (m.cur_pakia.y > m.cur_pakia.screen_h))
      m.cur_pakia = invalid
      end if

    end function,

    repaint: function() 
      if (m.cur_pakia <> invalid) then
        m.cur_pakia.draw()
      end if
    end function,

    render: function()
      if (m.pakias.count() = 0) then
        m.createPakias()
      end if

      m.reflow()
      m.repaint()

    end function,

    checkCollision: function()
      
      if (m.cur_pakia = invalid) then
        return true
      end if

      mit = GetGlobalAA()

      pappu_bounds = mit.Pappu.getBounds()
      pakia_bounds = m.cur_pakia.getBounds()

      if ((pappu_bounds.end_x     >  pakia_bounds.start_x+20) and (pakia_bounds.end_x-20  >  pappu_bounds.start_x) and (pappu_bounds.end_y    >  pakia_bounds.start_y+20) and (pakia_bounds.end_y-20  >  pappu_bounds.start_y)) 
       
        if (m.cur_pakia.type = "angry") then
            gameOver()
        else if (m.cur_pakia.type = "sad") 
            if (not m.cur_pakia.has_stuck) then
              mit.vy += 20
              m.cur_pakia.y += 20
              m.cur_pakia.vx = 0
            end if
            m.cur_pakia.has_stuck = true

		else if (m.cur_pakia.type = "happy") then
            if (m.cur_pakia.vy < 0) then
              mit.vy -= 10
            else
              mit.vy += 10
            end if
        end if

      end if

    end function
    }

  m.Pakia.init()

end sub 
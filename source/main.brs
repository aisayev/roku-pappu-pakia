' Roku Pappu Pakia
' Developed by Artyom Isayev (Artem Isaiev) https://github.com/aisayev

Library "v30/bslDefender.brs"

sub main()
    m.W = 1280
    m.H = 720
    m.score = 0.0
    m.gravity = 0.7
    m.vx = 0
    m.vy = 0
    m.v_cap = 6.5
    m.ax = 0
    m.ay = 0
    m.game_started = false
    m.game_over = false
    m.flying_up = false
    m.game_paused = false
    m.start_btn_clicked = false

    m.code = bslUniversalControlEventCodes()
    m.timer = CreateObject("roTimespan")
    m.storage = CreateObject("roRegistrySection", "Score")

    reportEvent("loaded")

    if (m.storage.Exists("high")) Then
        m.high = val(m.storage.Read("high"), 10)
    else
        m.high = 0
    end if
  
    initGraphics()
    initLoader()
    initBackgrounds()
    initPappu()
    initForks()
    initBranches()
    initPakia()
  
    while (true)
        event = m.port.GetMessage()

        if type(event) = "roUniversalControlEvent" then
            id = event.GetInt()
            if (id = m.code.BUTTON_UP_PRESSED) then
                ascend()
            else if (id = m.code.BUTTON_UP_RELEASED) then
                descend()
            else if (id = m.code.BUTTON_PLAY_PRESSED and m.game_started and not m.game_over) then
                togglePause()
            else if (id = m.code.BUTTON_SELECT_PRESSED and not m.start_btn_clicked) then
                startGame()
            end if
        end if
        if (m.game_paused) then
            sleep(100)
        else
    	   renderGame()
        end if
    end while

end sub

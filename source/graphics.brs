' Roku Pappu Pakia
' Developed by Artyom Isayev (Artem Isaiev) https://github.com/aisayev

sub initGraphics()
	m.port = CreateObject("roMessagePort")
	m.screen = CreateObject("roScreen", true, 1280, 720)
	m.screen.SetMessagePort(m.port)
	m.ctx = CreateObject("roRegion", m.screen, 0, 0, 1280, 720)
	m.ctx.SetAlphaEnable(true)
	clearImage(&h000000FF)
	m.screen.SwapBuffers()
	font_registry = CreateObject("roFontRegistry")
	font_registry.Register("pkg:/fonts/happy_sans-webfont.ttf")
	m.font = font_registry.GetFont("Happy Sans", 40, false, false)
end sub

sub drawImage(img, sx=invalid, sy=invalid, swidth=invalid, sheight=invalid, x=invalid, y=invalid, width=invalid, height=invalid)
	
	if (swidth <> invalid) then
		source = CreateObject("roRegion", img, sx, sy, swidth, sheight)
		m.ctx.DrawObject(x, y, source)
		source = invalid
	else if (sx <> invalid) then
		m.ctx.DrawObject(sx, sy, img)
	else
		m.ctx.DrawObject(0, 0, img)
	end if

end sub

sub fillRect(x, y, w, h, color)
	m.ctx.DrawRect(x, y, w, h, color)
end sub

sub requestAnimationFrame()
    delay = 15 - m.timer.TotalMilliseconds()
    if (delay > 0) then sleep(delay)
   	m.screen.SwapBuffers()
end sub

sub clearImage(color)
	m.ctx.Clear(color)
end sub

function blankImage(w, h)
	return CreateObject("roBitmap", {width:w, height:h, AlphaEnable:true})
end function

function clipImage(src, x, y, w, h)
	dst = CreateObject("roBitmap", {width:w, height:h, AlphaEnable:false})
	source = CreateObject("roRegion", src, x, y, w, h)
	dst.DrawObject(0, 0, source)
	return dst
end function

sub typeText(text, x, y) 
	m.ctx.DrawText(text, x, y, &hFFFFFFFF, m.font)
end sub

sub centerText(text, y) 
	width = m.font.GetOneLineWidth(text, m.W)
	x = int((m.W - width)/2)
	m.ctx.DrawText(text, x, y, &hFFFFFFFF, m.font)
end sub
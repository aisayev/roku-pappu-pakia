' Roku Pappu Pakia
' Developed by Artyom Isayev (Artem Isaiev) https://github.com/aisayev

sub initLoader()
	m.image = {}

	images = ["angry_pakia", "backtrees", "berries", "bg_combined", "branch", "clouds", "coins", "controls", "fork_top", "fork_bottom", "fork_head", "fronttrees", "grass", "ground", "happy_pakia", "log", "pappu", "plank_bot", "plank_mid", "plank_top", "sad_pakia", "stand", "star", "title", "falling", "top" ]

	for i = 0 to (images.count() - 1)
		m.image[images[i]] = CreateObject("roBitmap", "pkg:/images/game/" + images[i] + ".png")
	end for

end sub
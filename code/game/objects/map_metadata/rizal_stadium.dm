/obj/map_metadata/rizal_stadium
	ID = MAP_RIZAL_STADIUM
	title = "Rizal Stadium"
	lobby_icon = "icons/lobby/pacific.png"
	caribbean_blocking_area_types = list(/area/caribbean/no_mans_land/invisible_wall,/area/caribbean/no_mans_land/invisible_wall/one,/area/caribbean/no_mans_land/invisible_wall/two)
	respawn_delay = 1200

	faction_organization = list(
		JAPANESE,
		AMERICAN)

	roundend_condition_sides = list(
		list(AMERICAN) = /area/caribbean/british,
		list(JAPANESE) = /area/caribbean/japanese/land/inside/command,
		)
	age = "1944"
	no_hardcore = TRUE
	ordinal_age = 6
	faction_distribution_coeffs = list(JAPANESE = 0.6, AMERICAN = 0.4)
	battle_name = "Rizal Stadium"
	mission_start_message = "<font size=4>All factions have <b>8 minutes</b> to prepare before the ceasefire ends!<br>The Japanese Army will win if they hold out for <b>20 minutes</b>. The Americans will win if they manage to capture Japanese Command within Rizal Stadium!</font>"
	faction1 = JAPANESE
	faction2 = AMERICAN
	valid_weather_types = list(WEATHER_NONE, WEATHER_WET)
	songs = list(
		"Tokkutai Bushi (Koji Tsuruta):1" = 'sound/music/tokkutai_bushi.ogg',)
	gamemode = "Siege"
	grace_wall_timer = 3600
/obj/map_metadata/rizal_stadium/job_enabled_specialcheck(var/datum/job/J)
	..()
	if (istype(J, /datum/job/american))
		if (J.is_navy == TRUE || (istype(J, /datum/job/american/sailor_ww2)) || (istype(J, /datum/job/american/mp_ww2)) || (istype(J, /datum/job/american/chef_ww2)))
			. = FALSE
		else if (J.is_ww2 == TRUE || J.is_tanker == TRUE || (istype(J, /datum/job/american/soldier_ww2_filipino)))
			. = TRUE
		else
			. = FALSE
	if (istype(J, /datum/job/japanese))
		if (J.is_ww2 == TRUE && J.is_prison == FALSE)
			. = TRUE
		else
			. = FALSE

/obj/map_metadata/rizal_stadium/roundend_condition_def2name(define)
	..()
	switch (define)
		if (JAPANESE)
			return "Japanese"
		if (AMERICAN)
			return "American"
/obj/map_metadata/rizal_stadium/roundend_condition_def2army(define)
	..()
	switch (define)
		if (JAPANESE)
			return "Japanese"
		if (AMERICAN)
			return "Americans"

/obj/map_metadata/rizal_stadium/army2name(army)
	..()
	switch (army)
		if ("Japanese")
			return "Japanese"
		if ("Americans")
			return "American"


/obj/map_metadata/rizal_stadium/cross_message(faction)
	if (faction == AMERICAN)
		return "<font size = 4>The Americans may now cross the invisible wall!</font>"
	else if (faction == JAPANESE)
		return ""
	else
		return ""

/obj/map_metadata/rizal_stadium/reverse_cross_message(faction)
	if (faction == AMERICAN)
		return "<span class = 'userdanger'>The Americans may no longer cross the invisible wall!</span>"
	else if (faction == JAPANESE)
		return ""
	else
		return ""


var/no_loop_riz = FALSE

/obj/map_metadata/rizal_stadium/update_win_condition()

	if (world.time >= 13600)
		if (win_condition_spam_check)
			return FALSE
		ticker.finished = TRUE
		var/message = "The <b>Japanese</b> have successfuly defended the Stadium! The Americans have halted the attack!"
		world << "<font size = 4><span class = 'notice'>[message]</span></font>"
		show_global_battle_report(null)
		win_condition_spam_check = TRUE
		return FALSE
	if ((current_winner && current_loser && world.time > next_win) && no_loop_riz == FALSE)
		ticker.finished = TRUE
		var/message = "The <b>Americans</b> have captured the Japanese Command! The battle for Rizal Stadium is over!"
		world << "<font size = 4><span class = 'notice'>[message]</span></font>"
		show_global_battle_report(null)
		win_condition_spam_check = TRUE
		no_loop_riz = TRUE
		return FALSE
	// German major
	else if (win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[2]]), roundend_condition_sides[1], roundend_condition_sides[2], 1.33, TRUE))
		if (!win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[1]]), roundend_condition_sides[2], roundend_condition_sides[1], 1.33))
			if (last_win_condition != win_condition.hash)
				current_win_condition = "The <b>Americans</b> have captured the Japanese Command! They will win in {time} minutes."
				next_win = world.time + short_win_time(AMERICAN)
				announce_current_win_condition()
				current_winner = roundend_condition_def2army(roundend_condition_sides[1][1])
				current_loser = roundend_condition_def2army(roundend_condition_sides[2][1])
	// German minor
	else if (win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[2]]), roundend_condition_sides[1], roundend_condition_sides[2], 1.01, TRUE))
		if (!win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[1]]), roundend_condition_sides[2], roundend_condition_sides[1], 1.01))
			if (last_win_condition != win_condition.hash)
				current_win_condition = "The <b>Americans</b> have captured the Japanese command! They will win in {time} minutes."
				next_win = world.time + short_win_time(AMERICAN)
				announce_current_win_condition()
				current_winner = roundend_condition_def2army(roundend_condition_sides[1][1])
				current_loser = roundend_condition_def2army(roundend_condition_sides[2][1])
	// Soviet major
	else if (win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[1]]), roundend_condition_sides[2], roundend_condition_sides[1], 1.33, TRUE))
		if (!win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[2]]), roundend_condition_sides[1], roundend_condition_sides[2], 1.33))
			if (last_win_condition != win_condition.hash)
				current_win_condition = "The <b>Americans</b> have captured the Japanese Command! They will win in {time} minutes."
				next_win = world.time + short_win_time(AMERICAN)
				announce_current_win_condition()
				current_winner = roundend_condition_def2army(roundend_condition_sides[2][1])
				current_loser = roundend_condition_def2army(roundend_condition_sides[1][1])
	// Soviet minor
	else if (win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[1]]), roundend_condition_sides[2], roundend_condition_sides[1], 1.01, TRUE))
		if (!win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[2]]), roundend_condition_sides[1], roundend_condition_sides[2], 1.01))
			if (last_win_condition != win_condition.hash)
				current_win_condition = "The <b>Americans</b> have captured the Japanese Command! They will win in {time} minutes."
				next_win = world.time + short_win_time(AMERICAN)
				announce_current_win_condition()
				current_winner = roundend_condition_def2army(roundend_condition_sides[2][1])
				current_loser = roundend_condition_def2army(roundend_condition_sides[1][1])
	else
		if (current_win_condition != no_winner && current_winner && current_loser)
			world << "<font size = 3>The <b>Japanese</b> have recaptured the Stadium!</font>"
			current_winner = null
			current_loser = null
		next_win = -1
		current_win_condition = no_winner
		win_condition.hash = 0
	last_win_condition = win_condition.hash
	return TRUE

/obj/map_metadata/rizal_stadium/check_caribbean_block(var/mob/living/human/H, var/turf/T)
	if (!istype(H) || !istype(T))
		return FALSE
	var/area/A = get_area(T)
	if (istype(A, /area/caribbean/no_mans_land/invisible_wall))
		if (istype(A, /area/caribbean/no_mans_land/invisible_wall/one))
			if (H.faction_text == faction1)
				return TRUE
		else if (istype(A, /area/caribbean/no_mans_land/invisible_wall/two))
			if (H.faction_text == faction2)
				return TRUE
		else
			return !faction1_can_cross_blocks()
	return FALSE
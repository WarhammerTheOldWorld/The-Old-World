#define CUT_TIME 50
#define CLIMB_TIME 150

#define NO_HOLE 0 //section is intact
#define MEDIUM_HOLE 1 //medium hole in the section - can climb through
#define LARGE_HOLE 2 //large hole in the section - can walk through
#define DESTROY_HOLE 3 //time to remove that fence

/obj/structure/fence
	name = "fence"
	desc = "A fence to keep farm animals in, and brigands out."
	density = TRUE
	anchored = TRUE
	icon = 'icons/obj/structures/wattlefence.dmi'
	icon_state = "straight"
	var/cuttable = TRUE
	var/hole_size= NO_HOLE
	var/invulnerable = FALSE
	var/hole_visuals = TRUE //Whether the fence piece has visuals for being cut. Used in update_cut_status()
/* readd cut fences at a later date when we have sprites
/obj/structure/fence/Initialize()
	. = ..()

	update_cut_status()

/obj/structure/fence/examine(mob/user)
	. = ..()
	switch(hole_size)
		if(MEDIUM_HOLE)
			. += "There is a large hole in \the [src]."
		if(LARGE_HOLE)
			. += "\The [src] has been completely cut through."
*/

/obj/structure/fence/wattle
	icon_state = "straight"

/obj/structure/fence/wattle/corner
	icon_state = "corner"

/obj/structure/fence/wattle/small
	icon_state = "small"




/*
/obj/structure/fence/cut/medium
	icon_state = "straight_cut2"
	hole_size = MEDIUM_HOLE

/obj/structure/fence/cut/large
	icon_state = "straight_cut3"
	hole_size = LARGE_HOLE

old fallout shit
/obj/structure/fence/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/wirecutters))
		if(!cuttable)
			to_chat(user, "<span class='notice'>This section of the fence can't be cut.</span>")
			return
		if(invulnerable)
			to_chat(user, "<span class='notice'>This fence is too strong to cut through.</span>")
			return
		var/current_stage = hole_size

		user.visible_message("<span class='danger'>\The [user] starts cutting through \the [src] with \the [W].</span>",\
		"<span class='danger'>You start cutting through \the [src] with \the [W].</span>")

		if(do_after(user, CUT_TIME*W.toolspeed, target = src))
			if(current_stage == hole_size)
				switch(++hole_size)
					if(MEDIUM_HOLE)
						visible_message("<span class='notice'>\The [user] cuts into \the [src] some more.</span>")
						to_chat(user, "<span class='info'>You could probably fit yourself through that hole now. Although climbing through would be much faster if you made it even bigger.</span>")
						climbable = TRUE
						W.play_tool_sound(user, 20)
					if(LARGE_HOLE)
						visible_message("<span class='notice'>\The [user] completely cuts through \the [src].</span>")
						to_chat(user, "<span class='info'>The hole in \the [src] is now big enough to walk through.</span>")
						climbable = FALSE
						W.play_tool_sound(user, 20)
					if(DESTROY_HOLE)
						visible_message("<span class='notice'>\The [user] removes \the [src].</span>")
						to_chat(user, "<span class='info'>\The [src] is removed.</span>")
						deconstruct(TRUE)
						W.play_tool_sound(user, 20)

				update_cut_status()


	if(istype(W, /obj/item/stack/logs))
		var/obj/item/stack/logs/logs = W
		switch(hole_size)
			if(NO_HOLE)
				to_chat(user, "<span class='warning'>You cannot repair \the [src] any further!</span>")
				return
			if(MEDIUM_HOLE)
				if(logs.get_amount() < 2)
					to_chat(user, "<span class='warning'>You need at least two logs to repair \the [src]!</span>")
					return
				to_chat(user, "<span class='notice'>You start repairing \the [src]...</span>")
				if(do_after(user, 20, target = src))
					if(logs.get_amount() < 2)
						return
					logs.use(2)
					to_chat(user, "<span class='notice'>You completely repair the hole in \the [src].</span>")
					hole_size = NO_HOLE
			if(LARGE_HOLE)
				if(logs.get_amount() < 2)
					to_chat(user, "<span class='warning'>You need at least two logs to repair \the [src]!</span>")
					return
				to_chat(user, "<span class='notice'>You start repairing \the [src]...</span>")
				if(do_after(user, 20, target = src))
					if(logs.get_amount() < 2)
						return
					logs.use(2)
					to_chat(user, "<span class='notice'>You repair a bit of the hole in \the [src].</span>")
					hole_size = MEDIUM_HOLE

		update_cut_status()

	return TRUE

/obj/structure/fence/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/logs(get_turf(src), 4)
	qdel(src)

/obj/structure/fence/proc/update_cut_status()
	if(!cuttable)
		return
	density = TRUE
	switch(hole_size)
		if(NO_HOLE)
			if(!hole_visuals) //This is omega-stupid, fix this idiot
				return
			icon_state = initial(icon_state)
		if(MEDIUM_HOLE)
			if(!hole_visuals)
				return
			icon_state = "straight_cut2"
		if(LARGE_HOLE)
			density = FALSE
			if(!hole_visuals)
				return
			icon_state = "straight_cut3"

*/
#undef CUT_TIME
#undef CLIMB_TIME

#undef NO_HOLE
#undef MEDIUM_HOLE
#undef LARGE_HOLE
#undef DESTROY_HOLE


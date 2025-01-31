/obj/item/grenade/spawnergrenade
	desc = "It is set to detonate in 5 seconds. It will unleash unleash an unspecified anomaly into the vicinity."
	name = "delivery grenade"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "delivery"
	item_state = "flashbang"
	origin_tech = list(TECH_MATERIAL = 3, TECH_MAGNET = 4)
	var/banglet = 0
	var/spawner_type = null // must be an object path
	var/deliveryamt = 1 // amount of type to deliver
	var/list/newvars

	detonate()												// Prime now just handles the two loops that query for people in lockers and people who can see it.

		if(spawner_type && deliveryamt)
			// Make a quick flash
			var/turf/T = get_turf(src)
			playsound(T, 'sound/effects/gore/blast4.ogg', 100, 1)

			for(var/i=1, i<=deliveryamt, i++)
				var/atom/movable/x = new spawner_type
				if(newvars && length(newvars))
					for(var/v in newvars)
						x.vars[v] = newvars[v]
				x.loc = T
				if(prob(50))
					for(var/j = 1, j <= rand(1, 3), j++)
						step(x, pick(NORTH,SOUTH,EAST,WEST))

				// Spawn some hostile syndicate critters

		qdel(src)
		return

/obj/item/grenade/spawnergrenade/manhacks
	name = "manhack delivery grenade"
	spawner_type = /mob/living/simple_animal/hostile/viscerator
	deliveryamt = 5
	origin_tech = list(TECH_MATERIAL = 3, TECH_MAGNET = 4, TECH_ILLEGAL = 4)

/obj/item/grenade/spawnergrenade/spesscarp
	name = "carp delivery grenade"
	spawner_type = /mob/living/simple_animal/hostile/carp
	deliveryamt = 5
	origin_tech = list(TECH_MATERIAL = 3, TECH_MAGNET = 4, TECH_ILLEGAL = 4)

/obj/item/grenade/spawnergrenade/bugs
	name = "infested morsel"
	desc = "The smell is an exquisite blend of rotting meat and some kind of cheese. There's something moving inside."
	icon_state = "bugnade"
	item_state = "burger"
	spawner_type = /mob/living/simple_animal/hostile/scarybat/cult
	deliveryamt = 5
	origin_tech = list(TECH_MATERIAL = 3, TECH_MAGNET = 4, TECH_ILLEGAL = 4)




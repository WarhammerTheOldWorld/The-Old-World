/datum/species/skaven
    name = SPECIES_RAT
    name_plural = "Skaven"
    secondary_langs = list(LANGUAGE_TAU)
    name_language = null // Use the first-name last-name generator rather than a language scrambler
    icobase = 'icons/mob/human_races/r_skaven.dmi'
    deform = 'icons/mob/human_races/r_skaven.dmi'
    damage_mask = 'icons/mob/human_races/masks/dam_mask_human.dmi'
    blood_mask = 'icons/mob/human_races/masks/blood_human.dmi'
    min_age = 18
    max_age = 50
    gluttonous = GLUT_ANYTHING
    total_health = 115
    mob_size = MOB_MEDIUM
    strength = STR_MEDIUM
    sexybits_location = BP_GROIN
    inherent_verbs = list(

        )
    unarmed_types = list(
        /datum/unarmed_attack/stomp,
        /datum/unarmed_attack/kick,
        /datum/unarmed_attack/punch,
        /datum/unarmed_attack/bite,
        )
    darksight = 100

/datum/species/skaven/handle_post_spawn(var/mob/living/carbon/human/H)
	H.age = rand(min_age,max_age)//Random age
	H.update_eyes()	//hacky fix, i don't care and i'll never ever care

	return ..()
/mob/living/carbon/human/skaven
	var/new_skaven = SPECIES_RAT

/mob/living/carbon/human/skaven/New(var/new_loc)
	h_style = "Bald"
	..(new_loc, new_skaven)

/mob/living/carbon/human/skaven
	gender = MALE
	var/isempty = 0
	var/iseating = 0

/mob/living/carbon/human/skaven/Initialize()
	. = ..()
	warfare_faction = SKAVEN
	var/decl/hierarchy/outfit/outfit = outfit_by_type(/decl/hierarchy/outfit/job)
	outfit.equip(src)

//this is the proc that lets skaven eat bodies.
/mob/living/carbon/human/skaven/proc/skaven_eat()
	set category = "Skaven"
	set name = "Consume Corpse"

	var/obj/item/grab/G = src.get_active_hand()
	if(!istype(G))
		to_chat(src, "<span class='warning'>We must be grabbing a creature in our active hand to consume them.</span>")
		return

	var/mob/living/carbon/human/T = G.affecting //this will be modified later as we add more rando species
	if(!istype(T))
		to_chat(src, "<span class='warning'>[T] is not compatible with our biology.</span>")
		return

	if(HUSK in T.mutations) //Eating husks would be kinda strange, but idk
		to_chat(src, "<span class='warning'>This creature's DNA is ruined beyond useability!</span>")
		return

	if(iseating)
		to_chat(src, "<span class='warning'>We are already eating [T]!</span>")
		return

	var/obj/item/organ/external/affecting = T.get_organ(src.zone_sel.selecting)
	if(!affecting)
		to_chat(src, "<span class='warning'>They are missing that body part!</span>") //Dont try and eat a limb that doesn't exist.

	iseating = 1

	for(var/stage = 1, stage<=3, stage++)
		switch(stage)
			if(1)
				to_chat(src, "<span class='notice'>This creature looks delicious. We must hold still while we consume them...</span>")
			if(2)
				to_chat(src, "<span class='notice'>[src] begins to open their jaw</span>")
				src.visible_message("<span class='warning'>[src] widens their jaw!</span>")
			if(3)
				to_chat(src, "<span class='notice'>We bite [T] with a sickening crunch!</span>")
				src.visible_message("<span class='danger'>[src] bites [T] with a loud crunch</span>")
				to_chat(T, "<span class='danger'>You feel a sharp stabbing pain!</span>")
				affecting.take_damage(39, 0, DAM_SHARP, "large organic needle")
				playsound(src, 'sound/effects/lecrunch.ogg', 50, 0, -1)

		if(!do_mob(src, T, 150))
			to_chat(src, "<span class='warning'>Our meal of [T] has been interrupted!</span>")
			iseating = 0
			return

	to_chat(src, "<span class='notice'>We have consumed [T]!</span>")
	src.visible_message("<span class='danger'>[src] sucks the marrow from [T]'s bones!</span>")
	to_chat(T, "<span class='danger'>You have been eaten by a skaven!</span>")

	iseating = 0

	T.death(0)
	T.isburied = 1
	T.gib()
	restore_all_organs()
	src.adjustBruteLoss(-40)
	src.adjustOxyLoss(-40)
	src.adjustStaminaLoss(-5)
	src.adjustToxLoss(-40)
	src.adjustBrainLoss(-40)
	src.adjustFireLoss(-40)
	src.nutrition = 400
	src.thirst = 550
	src.radiation = 0
	src.bodytemperature = T20C
	src.sdisabilities = 0
	src.disabilities = 0
	src.blinded = 0
	src.eye_blind = 0
	src.eye_blurry = 0
	src.ear_deaf = 0
	src.ear_damage = 0
	GLOB.kroot_eats++
	return 1

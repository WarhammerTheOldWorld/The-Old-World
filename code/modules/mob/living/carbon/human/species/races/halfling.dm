/datum/species/halfling
    name = SPECIES_HALFLING
    name_plural = "Skaven"
    secondary_langs = list(LANGUAGE_TAU)
    name_language = null // Use the first-name last-name generator rather than a language scrambler
    icobase = 'icons/mob/human_races/r_def_smeltrat.dmi'
    deform = 'icons/mob/human_races/r_def_smeltrat.dmi'
    damage_mask = 'icons/mob/human_races/masks/dam_mask_human.dmi'
    blood_mask = 'icons/mob/human_races/masks/blood_human.dmi'
    min_age = 18
    max_age = 50
    gluttonous = GLUT_ANYTHING
    total_health = 70
    mob_size = MOB_SMALL
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

/datum/species/halfling/handle_post_spawn(var/mob/living/carbon/human/H)
	H.age = rand(min_age,max_age)//Random age
	H.update_eyes()	//hacky fix, i don't care and i'll never ever care

	return ..()
/mob/living/carbon/human/halfling
	var/new_halfing = SPECIES_HALFLING

/mob/living/carbon/human/halfing/New(var/new_loc)
	h_style = "Bald"
	..(new_loc, new_halfing)

/mob/living/carbon/human/halfing
	gender = MALE
	var/isempty = 0
	var/iseating = 0

/mob/living/carbon/human/halfing/Initialize()
	. = ..()
	warfare_faction = IMPERIUM
	var/decl/hierarchy/outfit/outfit = outfit_by_type(/decl/hierarchy/outfit/job)
	outfit.equip(src)



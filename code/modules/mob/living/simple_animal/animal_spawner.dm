/mob/living/simple_animal/hostile/hive
	name = "monster nest"
	icon = 'icons/mob/blob.dmi'
	desc = "A nest in which monsters dwell."
	icon_state = "blob_factory"
	health = 200
	a_intent = "harm"
	maxHealth = 200
	var/list/mobs = list()
	var/max_mobs = 5
	var/spawn_delay = 50
	var/count = 50 //starts with enough to spawn one
	var/mob_types =list(/mob/living/simple_animal/hostile/carp)
	var/loot = null
	var/spawn_message = "hatches from the"
	AIStatus = AI_OFF //most hives don't need to be attacking things, but making it a hostile mob leaves the opportunity for swarm creatures, robots spitting defense drones, etc
	anchored = 1
	mob_size = MOB_SIZE_LARGE
	wander = 0
	faction = list("hive")



/mob/living/simple_animal/hostile/hive/death(gibbed)
	..(gibbed)
	visible_message("<span class='danger'><b>[src]</b> is smashed into pieces!</span>")
	if(loot)
		new loot (src.loc)
	qdel(src)
	return



/mob/living/simple_animal/hostile/hive/Life()
	. = ..()
	if(mobs.len <= max_mobs && count > spawn_delay)
		spawn_mob()
		count = 0
	count++


/mob/living/simple_animal/hostile/hive/proc/spawn_mob()
	var/mob_type = pick(mob_types)
	var/mob/living/simple_animal/S = new mob_type(src.loc)
	S.hive = src
	src.mobs += S
	for(var/F in src.faction)
		S.faction += F
	visible_message("<span class='danger'><b>[S][spawn_message][src.name]</b>!</span>")


//Hive Types
/mob/living/simple_animal/hostile/hive/syndicate
	name = "ominous beacon"
	desc = "This looks suspicious..."
	icon = 'icons/obj/device.dmi'
	icon_state = "syndbeacon"
	faction = list("syndicate")
	mob_types =list(/mob/living/simple_animal/hostile/syndicate/melee, /mob/living/simple_animal/hostile/syndicate/ranged)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	spawn_message = "teleports to the"


/mob/living/simple_animal/hostile/hive/syndicate/space
	mob_types =list(/mob/living/simple_animal/hostile/syndicate/melee/space, /mob/living/simple_animal/hostile/syndicate/ranged/space)
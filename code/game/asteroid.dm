var/global/list/possiblethemes = list("organharvest","cult","wizden","cavein","xenoden","hitech","speakeasy","plantlab")

var/global/max_secret_rooms = 6

/proc/spawn_room(var/atom/start_loc, var/x_size, var/y_size, var/list/walltypes, var/floor, var/name, var/survival)
	var/list/room_turfs = list("walls"=list(),"floors"=list())

	for(var/x = 0, x < x_size, x++)		//sets the size of the room on the x axis
		for(var/y = 0, y < y_size, y++) //sets it on y axis.
			var/turf/T
			var/cur_loc = locate(start_loc.x + x, start_loc.y + y, start_loc.z)


			var/area/asteroid/artifactroom/A = new
			if(name)
				A.name = name
			else
				A.name = "Artifact Room #[start_loc.x]-[start_loc.y]-[start_loc.z]"


			if(x == 0 || x == x_size-1 || y == 0 || y == y_size-1)
				var/wall = pickweight(walltypes)//totally-solid walls are pretty boring.
				T = cur_loc
				T.ChangeTurf(wall)
				room_turfs["walls"] += T


			else
				T = cur_loc
				T.ChangeTurf(floor)
				room_turfs["floors"] += T

			A.contents += T
	return room_turfs

//////////////

/proc/make_mining_asteroid_secret()
	var/valid = 0
	var/turf/T = null
	var/sanity = 0
	var/list/room = null
	var/list/turfs = null
	var/x_size = 5
	var/y_size = 5

	var/areapoints = 0
	var/theme = "organharvest"
	var/list/walltypes = list(/turf/simulated/wall=3, /turf/simulated/mineral/random=1)
	var/list/floortypes = list(/turf/simulated/floor/plasteel)
	var/list/treasureitems = list()//good stuff. only 1 is created per room.
	var/list/fluffitems = list()//lesser items, to help fill out the room and enhance the theme.

	x_size = rand(3,7)
	y_size = rand(3,7)
	areapoints = x_size * y_size

	switch(pick(possiblethemes))//what kind of room is this gonna be?
		if("organharvest")
			walltypes = list(/turf/simulated/wall/r_wall=2,/turf/simulated/wall=2,/turf/simulated/mineral/random/high_chance=1)
			floortypes = list(/turf/simulated/floor/plasteel,/turf/simulated/floor/engine)
			treasureitems = list(/obj/machinery/bot/medbot/mysterious=1, /obj/item/weapon/circular_saw=1, /obj/structure/closet/critter/cat=2)
			fluffitems = list(/obj/effect/decal/cleanable/blood=5,/obj/item/organ/appendix=2,/obj/structure/closet/crate/freezer=2,
							  /obj/structure/optable=1,/obj/item/weapon/scalpel=1,/obj/item/weapon/storage/firstaid/regular=3,
							  /obj/item/weapon/tank/internals/anesthetic=1, /obj/item/weapon/surgical_drapes=2, /obj/item/device/mass_spectrometer/adv=1,/obj/item/clothing/glasses/hud/health=1)

		if("cult")
			theme = "cult"
			walltypes = list(/turf/simulated/wall/cult=3,/turf/simulated/mineral/random/high_chance=1)
			floortypes = list(/turf/simulated/floor/plasteel/cult)
			treasureitems = list(/obj/item/device/soulstone=1, /obj/item/clothing/suit/space/cult=1, /obj/item/weapon/bedsheet/cult=2,
								 /obj/item/clothing/suit/cultrobes=2, /mob/living/simple_animal/hostile/creature=3)
			fluffitems = list(/obj/effect/gateway=1,/obj/effect/gibspawner=1,/obj/structure/cult/talisman=1,/obj/item/toy/crayon/red=2,
							  /obj/item/organ/heart=2, /obj/effect/decal/cleanable/blood=4,/obj/structure/table/wood=2,/obj/item/weapon/ectoplasm=3,
							  /obj/item/clothing/head/helmet/space/cult=1, /obj/item/clothing/shoes/cult=1)

		if("wizden")
			theme = "wizden"
			walltypes = list(/turf/simulated/wall/mineral/plasma=3,/turf/simulated/mineral/random/high_chance=1)
			floortypes = list(/turf/simulated/floor/wood)
			treasureitems = list(/obj/item/weapon/veilrender/vealrender=2, /obj/item/weapon/spellbook/oneuse/blind=1,/obj/item/clothing/head/wizard/red=2,
							/obj/item/weapon/spellbook/oneuse/forcewall=1, /obj/item/weapon/spellbook/oneuse/smoke=1, /obj/structure/constructshell = 1, /obj/item/toy/katana=3)
			fluffitems = list(/obj/structure/safe/floor=1,/obj/structure/dresser=1,/obj/item/weapon/storage/belt/soulstone=1,/obj/item/trash/candle=3,
							  /obj/item/weapon/dice=3,/obj/item/weapon/staff=2,/obj/effect/decal/cleanable/dirt=3,/obj/item/weapon/coin/mythril=3)

		if("cavein")
			theme = "cavein"
			walltypes = list(/turf/simulated/mineral/random/high_chance=1)
			floortypes = list(/turf/simulated/floor/plating/asteroid/airless, /turf/simulated/floor/plating/beach/sand)
			treasureitems = list(/obj/mecha/working/ripley/mining=1, /obj/item/weapon/pickaxe/drill/diamonddrill=2,/obj/item/weapon/gun/energy/kinetic_accelerator=1,
							/obj/item/weapon/resonator=1, /obj/item/weapon/pickaxe/drill/jackhammer=5)
			fluffitems = list(/obj/effect/decal/cleanable/blood=3,/obj/effect/decal/remains/human=1,/obj/item/clothing/under/overalls=1,
							  /obj/item/weapon/reagent_containers/food/snacks/grown/chili=1,/obj/item/weapon/tank/internals/oxygen/red=2)

		if("xenoden")
			theme = "xenoden"
			walltypes = list(/turf/simulated/mineral/random/high_chance=1)
			floortypes = list(/turf/simulated/floor/plating/asteroid/airless, /turf/simulated/floor/plating/beach/sand)
			treasureitems = list(/obj/item/clothing/mask/facehugger=1)
			fluffitems = list(/obj/effect/decal/remains/human=1,/obj/effect/decal/cleanable/xenoblood/xsplatter=5)

		if("hitech")
			theme = "hitech"
			walltypes = list(/turf/simulated/wall/r_wall=5,/turf/simulated/mineral/random=1)
			floortypes = list(/turf/simulated/floor/greengrid,/turf/simulated/floor/bluegrid)
			treasureitems = list(/obj/item/weapon/stock_parts/cell/hyper=1, /obj/machinery/chem_dispenser/constructable=1,/obj/machinery/computer/telescience=1, /obj/machinery/r_n_d/protolathe=1,
								/obj/machinery/biogenerator=1)
			fluffitems = list(/obj/structure/table/reinforced=2,/obj/item/weapon/stock_parts/scanning_module/phasic=3,
							  /obj/item/weapon/stock_parts/matter_bin/super=3,/obj/item/weapon/stock_parts/manipulator/pico=3,
							  /obj/item/weapon/stock_parts/capacitor/super=3,/obj/item/device/pda/clear=1, /obj/structure/mecha_wreckage/phazon=1)

		if("speakeasy")
			theme = "speakeasy"
			floortypes = list(/turf/simulated/floor/plasteel,/turf/simulated/floor/wood)
			treasureitems = list(/obj/item/weapon/melee/energy/sword/pirate=1,/obj/item/weapon/gun/projectile/revolver/doublebarrel=1,/obj/item/weapon/storage/backpack/satchel_flat=1,
			/obj/machinery/reagentgrinder=2, /obj/machinery/computer/security/wooden_tv=4, /obj/machinery/vending/coffee=3)
			fluffitems = list(/obj/structure/table/wood=2,/obj/structure/reagent_dispensers/beerkeg=1,/obj/item/stack/spacecash/c500=4,
							  /obj/item/weapon/reagent_containers/food/drinks/shaker=1,/obj/item/weapon/reagent_containers/food/drinks/bottle/wine=3,
							  /obj/item/weapon/reagent_containers/food/drinks/bottle/whiskey=3,/obj/item/clothing/shoes/laceup=2)

		if("plantlab")
			theme = "plantlab"
			treasureitems = list(/obj/item/weapon/gun/energy/floragun=1,/obj/item/seeds/novaflowerseed=2,/obj/item/seeds/bluespacetomatoseed=2,/obj/item/seeds/bluetomatoseed=2,
			/obj/item/seeds/coffee_robusta_seed=2, /obj/item/seeds/cashseed=2)
			fluffitems = list(/obj/structure/flora/kirbyplants=1,/obj/structure/table/reinforced=2,/obj/machinery/hydroponics=1,
							  /obj/effect/glowshroom/single=2,/obj/item/weapon/reagent_containers/syringe/charcoal=2,
							  /obj/item/weapon/reagent_containers/glass/bottle/diethylamine=3,/obj/item/weapon/reagent_containers/glass/bottle/ammonia=3)

		/*if("poly")
			theme = "poly"
			x_size = 5
			y_size = 5
			walltypes = list(/turf/simulated/wall/mineral/clown)
			floortypes= list(/turf/simulated/floor/engine)
			treasureitems = list(/obj/item/weapon/spellbook=1,/obj/mecha/combat/marauder=1,/obj/machinery/wish_granter=1)
			fluffitems = list(/obj/item/weapon/melee/energy/axe)*/

	possiblethemes -= theme //once a theme is selected, it's out of the running!
	var/floor = pick(floortypes)

	turfs = get_area_turfs(/area/mine/unexplored)

	if(!turfs.len)
		return 0

	while(!valid)//Finds some spots to place these rooms at, where they won't be spotted immediately.
		valid = 1
		sanity++
		if(sanity > 100)
			return 0

		T=pick(turfs)
		if(!T)
			return 0

		var/list/surroundings = list()

		surroundings += range(7, locate(T.x,T.y,T.z))
		surroundings += range(7, locate(T.x+x_size,T.y,T.z))
		surroundings += range(7, locate(T.x,T.y+y_size,T.z))
		surroundings += range(7, locate(T.x+x_size,T.y+y_size,T.z))

		if(locate(/area/mine/explored) in surroundings)
			valid = 0
			continue

		if(locate(/turf/space) in surroundings)
			valid = 0
			continue

		if(locate(/area/asteroid/artifactroom) in surroundings)
			valid = 0
			continue

		if(locate(/turf/simulated/floor/plating/asteroid/airless) in range(5,T))//A little less strict than the other checks due to tunnels
			valid = 0
			continue

	if(!T)
		return 0

	room = spawn_room(T,x_size,y_size,walltypes,floor,) //WE'RE FINALLY CREATING THE ROOM

	if(room)//time to fill it with stuff
		var/list/emptyturfs = room["floors"]
		for(var/turf/simulated/floor/A in emptyturfs) //remove pls doesn't fix problem
			if(istype(A))
				spawn(2)
					A.fullUpdateMineralOverlays()
		T = pick(emptyturfs)
		if(T)
			new /obj/effect/glowshroom/single(T) //Just to make it a little more visible
			var/surprise = null
			surprise = pickweight(treasureitems)
			new surprise(T)//here's the prize
			emptyturfs -= T

			while(areapoints >= 10)//lets throw in the fluff items
				T = pick(emptyturfs)
				var/garbage = null
				garbage = pickweight(fluffitems)
				new garbage(T)
				areapoints -= 5
				emptyturfs -= T
			//world.log << "The [theme] themed [T.loc] has been created!"

	return 1


/////////PLANET

/obj/effect/landmark/river_waypoint
	var/connected = 0

/proc/createLavaRivers()
	var/list/river_nodes = list()
	var/max = rand(3,5)
	var/num_spawned = 0
	while(num_spawned <= max)
		var/turfs = get_area_turfs(/area/mine/unexplored)
		var/turf/simulated/A = pick(turfs)

	//	var/turf/simulated/A = locate(rand(18, 220), rand(18, 220), 7)
	//	if(!istype(A))
	//		continue
		river_nodes.Add(new /obj/effect/landmark/river_waypoint(A))
		num_spawned++

	//make some randomly pathing rivers
	for(var/obj/effect/landmark/river_waypoint/W in landmarks_list)
		if (W.z != 7 || W.connected)
			continue

		W.connected = 1
		var/turf/simulated/floor/plating/lava/cur_turf = new /turf/simulated/floor/plating/lava(get_turf(W))
		var/turf/target_turf = get_turf(pick(river_nodes))

		var/detouring = 0
		var/cur_dir = get_dir(cur_turf, target_turf)
		//
		while(cur_turf != target_turf)
			//randomly snake around a bit
			if(detouring)
				if(prob(20))
					detouring = 0
					cur_dir = get_dir(cur_turf, target_turf)
			else if(prob(20))
				detouring = 1
				if(prob(50))
					cur_dir = turn(cur_dir, 45)
				else
					cur_dir = turn(cur_dir, -45)
			else
				cur_dir = get_dir(cur_turf, target_turf)

			cur_turf = get_step(cur_turf, cur_dir)

			var/skip = 0

			var/validturf = FALSE
			if(istype(cur_turf, /turf/simulated/floor/plating/asteroid))
				validturf = TRUE
			if(istype(cur_turf, /turf/simulated/mineral))
				validturf = TRUE

			if(!validturf)
				detouring = 0
				cur_dir = get_dir(cur_turf, target_turf)
				cur_turf = get_step(cur_turf, cur_dir)
				continue

			if(!skip)
				cur_turf.ChangeTurf(/turf/simulated/floor/plating/lava)
				if(istype(cur_turf, /turf/simulated/floor/plating/lava))
					cur_turf.Spread(75, rand(65, 20))




/turf/simulated/floor/plating/lava/proc/Spread(var/probability = 50, var/probabilityloss = 50)
	if(probability <= 0)
		return

	//world << "\blue Spread([probability])"
	for(var/turf/simulated/A in orange(1, src))
		if(istype(A, /turf/simulated/floor/plating/asteroid) || istype(A, /turf/simulated/mineral))
			var/turf/simulated/floor/plating/lava/P = new /turf/simulated/floor/plating/lava(A)

			if(P && prob(probability))
				P.Spread(probability - probabilityloss)





///RUIN

var/global/list/potentialRuins = list()

/proc/getRuinList()
	var/list/Lines = file2list("_maps/randomruin/fileList.txt")
	if(!Lines.len)	return
	for (var/t in Lines)
		if (!t)
			continue

		t = trim(t)
		if (length(t) == 0)
			continue
		else if (copytext(t, 1, 2) == "#")
			continue

		var/pos = findtext(t, " ")
		var/name = null
	//	var/value = null

		if (pos)
			name = lowertext(copytext(t, 1, pos))
		//	value = copytext(t, pos + 1)
		else
			name = lowertext(t)

		if (!name)
			continue
		world << "<span class='boldannounce'>Ruin added to list.</span>"
		potentialRuins.Add(t)


/proc/seedRandomRuins()
	var/max = 3
	var/num_spawned = 0
	var/list/turfs = null
	while(num_spawned <= max)
		var/spawnturfs = get_area_turfs(/area/mine/unexplored)
		var/turf/simulated/A = pick(spawnturfs)
		new /obj/effect/landmark/randomruin(A)
		num_spawned++
	turfs = get_area_turfs(/area/ruins/)
	for(var/turf/T in turfs)
		T.baseturf = /turf/simulated/floor/plating/asteroid

/obj/effect/landmark/randomruin
	name = "random ruin"

/obj/effect/landmark/randomruin/initialize()
	load()

/obj/effect/landmark/randomruin/New()
	load()


/obj/effect/landmark/randomruin


/area/ruins
	name = "ruins"
	has_gravity = 1

/obj/effect/landmark/randomruin/proc/load()
	if(potentialRuins.len)
		world << "<span class='boldannounce'>Loading random ruin...</span>"

		var/map = pick(potentialRuins)
		var/file = file(map)
		var/x_offset = x
		var/y_offset = y

		if(isfile(file))
			maploader.load_map(file, x_offset, y_offset, 7)
			world.log << "Ruin loaded: [map]"

		world << "<span class='boldannounce'>Ruin loaded.</span>"
		potentialRuins -= map

	else
		world << "<span class='boldannounce'>No ruins found.</span>"
		return
//	qdel(src)

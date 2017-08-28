-- Tarkin Travel System
-- www.tarkin.org 2015
-- Function: Template for the Tarkin travel system.
--
-- Guidelines:
-- pcollector and collector MUST have unique names, so we add a number at the end of these.
-- collector# is for terminal from Coronet
-- collector#R is for terminal returning to corrent
-- Terminal name format: City or Location (Planet)
-- For return terminals, please comment their location above their code block as it is not
-- obvious where they are when reading the code block itself.

-- Network Connections:

-- Rebel Hideout - (Corellia) To:
  -- Rebel Outpost (Rori)
  -- Moenia Starport - (Naboo)
  -- Talus Installation - (Talus)
  
-- Rebel Safehouse - (Lok) To: 
  -- Rebel Outpost (Rori)
  
-- Starbird Base - (Rori) To:
  -- Rebel Outpost (Rori)
  -- Rebel Safehouse - (Lok)
  
-- Rebel Outpost - (Rori) To:
  -- Starbird Base - (Rori)
  -- Moenia Starport - (Naboo)
  
-- Rebel Installation - (Talus) To:
  -- Rebel Hideout - (Corellia)
  
-- Moenia Starport - (Naboo) To:
  -- Rebel Outpost (Rori)
  -- Rebel Hideout - (Corellia)

--========DISABLED=========
-- Anchorhead - (Tatooine) To:
  -- Moenia Starport - (Naboo)
  -- Rebel Hideout - (Corellia)
  -- Rebel Safehouse - (Lok)

RebelZephyrScreenPlay = ScreenPlay:new {
  numberOfActs = 1,

  screenplayName = "RebelZephyrScreenPlay"
}

registerScreenPlay("RebelZephyrScreenPlay", true)

function RebelZephyrScreenPlay:start()
  if (isZoneEnabled("yavin4")) then
    self:spawnSceneObjects()
    self:spawnMobiles()
  end
end

function RebelZephyrScreenPlay:spawnSceneObjects()

-- Place the terminals into the world

  -- Rebel Hideout - (Corellia) ========================
   
  local pCollector0 = spawnSceneObject("corellia", "object/tangible/furniture/imperial/data_terminal_s1.iff", -6528, 398.0, 6042, 0, 0, 0, 1, 0)
  SceneObject(pCollector0):setCustomObjectName("\\#ee3377Travel to Rebel Outpost (Rori)")
  createObserver(OBJECTRADIALUSED, "RebelZephyrScreenPlay", "teleportRebelOutpost", pCollector0)

  local pCollector1 = spawnSceneObject("corellia", "object/tangible/furniture/imperial/data_terminal_s1.iff", -6522, 398.0, 6043, 0, 0, 0, 1, 0)
  SceneObject(pCollector1):setCustomObjectName("\\#ee3377Travel to Moenia Starport - (Naboo)")
  createObserver(OBJECTRADIALUSED, "RebelZephyrScreenPlay", "teleportMoenia", pCollector1)
  
  local pCollector2 = spawnSceneObject("corellia", "object/tangible/furniture/imperial/data_terminal_s1.iff", -6532, 398.0, 6041, 0, 0, 0, 1, 0)
  SceneObject(pCollector2):setCustomObjectName("\\#ee3377Travel to Talus Installation - (Talus)")
  createObserver(OBJECTRADIALUSED, "RebelZephyrScreenPlay", "teleportTalus", pCollector2)
  
  -- Rebel Safehouse - (Lok) ========================
  
  local pCollector3 = spawnSceneObject("lok", "object/tangible/furniture/imperial/data_terminal_s1.iff", -4761, 4.0, 3516, 0, 0, 0, 1, 0)
  SceneObject(pCollector3):setCustomObjectName("\\#ee3377Travel to Rebel Outpost (Rori)")
  createObserver(OBJECTRADIALUSED, "RebelZephyrScreenPlay", "teleportRebelOutpost", pCollector3)
  
  -- Starbird Base - (Rori) ========================
  
  local pCollector4 = spawnSceneObject("rori", "object/tangible/furniture/imperial/data_terminal_s1.iff", -5311, 76, 5004, 0, 1, 0, 0, 0)
  SceneObject(pCollector4):setCustomObjectName("\\#ee3377Travel to Rebel Outpost (Rori)")
  createObserver(OBJECTRADIALUSED, "RebelZephyrScreenPlay", "teleportRebelOutpost", pCollector4)
  
  local pCollector13 = spawnSceneObject("rori", "object/tangible/furniture/imperial/data_terminal_s1.iff", -5307, 76, 5004, 0, 1, 0, 0, 0)
  SceneObject(pCollector13):setCustomObjectName("\\#ee3377Travel to Rebel Safehouse - (Lok)")
  createObserver(OBJECTRADIALUSED, "RebelZephyrScreenPlay", "teleportSafehouse", pCollector13)
  
  -- Rebel Outpost - (Rori) ========================
  
  local pCollector5 = spawnSceneObject("rori", "object/tangible/furniture/imperial/data_terminal_s1.iff", 3703, 96.0, -6411, 0, -0.707107, 0, 0.707107, 0)
  SceneObject(pCollector5):setCustomObjectName("\\#ee3377Travel to Starbird Base - (Rori)")
  createObserver(OBJECTRADIALUSED, "RebelZephyrScreenPlay", "teleportStarbird", pCollector5)

  local pCollector6 = spawnSceneObject("rori", "object/tangible/furniture/imperial/data_terminal_s1.iff", 3703, 96.0, -6417, 0, -0.707107, 0, 0.707107, 0)
   SceneObject(pCollector6):setCustomObjectName("\\#ee3377Travel to Moenia Starport - (Naboo)")
  createObserver(OBJECTRADIALUSED, "RebelZephyrScreenPlay", "teleportMoenia", pCollector6)
  
  -- Rebel Installation - (Talus) ========================
  
  local pCollector7 = spawnSceneObject("talus", "object/tangible/furniture/imperial/data_terminal_s1.iff", 2388, 125, -4994, 0, 0, 0, 0, 0)
  SceneObject(pCollector7):setCustomObjectName("\\#ee3377Travel to Rebel Hideout - (Corellia)")
  createObserver(OBJECTRADIALUSED, "RebelZephyrScreenPlay", "teleportHideout", pCollector7)
  
  
  -- Anchorhead - (Tatooine) ========================
  
--  local pCollector8 = spawnSceneObject("tatooine", "object/tangible/furniture/imperial/data_terminal_s1.iff", 51.8, 52.0, -5335.9, 0, 0, 0, 1, 0)
--  SceneObject(pCollector8):setCustomObjectName("\\#ee3377Travel to Rebel Hideout - (Corellia)")
--  createObserver(OBJECTRADIALUSED, "RebelZephyrScreenPlay", "teleportHideout", pCollector8)

--  local pCollector9 = spawnSceneObject("tatooine", "object/tangible/furniture/imperial/data_terminal_s1.iff", 48.9, 52.0, -5335.9, 0, 0, 0, 1, 0)
--  SceneObject(pCollector9):setCustomObjectName("\\#ee3377Travel to Moenia Starport - (Naboo)")
--  createObserver(OBJECTRADIALUSED, "RebelZephyrScreenPlay", "teleportMoenia", pCollector9)
  
--  local pCollector10 = spawnSceneObject("tatooine", "object/tangible/furniture/imperial/data_terminal_s1.iff", 46.1, 52.0, -5335.9, 0, 0, 0, 1, 0)
--  SceneObject(pCollector10):setCustomObjectName("\\#ee3377Travel to Rebel Safehouse - (Lok)")
--  createObserver(OBJECTRADIALUSED, "RebelZephyrScreenPlay", "teleportSafehouse", pCollector10)
  
  -- Moenia Starport - (Naboo) - (Tatooine) ========================
  
  local pCollector11 = spawnSceneObject("naboo", "object/tangible/furniture/imperial/data_terminal_s1.iff", 4717, 4, -4654, 0, 0, 0, 1, 0)
  SceneObject(pCollector11):setCustomObjectName("\\#ee3377Travel to Rebel Outpost - Rori")
  createObserver(OBJECTRADIALUSED, "RebelZephyrScreenPlay", "teleportRebelOutpost", pCollector11)
  
  local pCollector12 = spawnSceneObject("naboo", "object/tangible/furniture/imperial/data_terminal_s1.iff", 4720, 4, -4654, 0, 0, 0, 1, 0)
  SceneObject(pCollector12):setCustomObjectName("\\#ee3377Travel to Rebel Hideout - Corellia")
  createObserver(OBJECTRADIALUSED, "RebelZephyrScreenPlay", "teleportHideout", pCollector12)
  
  
end

function RebelZephyrScreenPlay:spawnMobiles()

  -- Place NPCs here.
end

-- Functions that actually teleport the player

function RebelZephyrScreenPlay:teleportAH(pCollectorA, pPlayer)
	if (pPlayer == nil) then
		return
	end

	if CreatureObject(pPlayer):isRebel() then	
		SceneObject(pPlayer):switchZone("tatooine", 48, 0, -5342, 0)
	else
		CreatureObject(pPlayer):sendSystemMessage("You are not authorized to use this terminal")
	end
	return 0
end

function RebelZephyrScreenPlay:teleportMoenia(pCollectorB, pPlayer)
	if (pPlayer == nil) then
		return
	end

	if CreatureObject(pPlayer):isRebel() then	
		SceneObject(pPlayer):switchZone("naboo", 4731, 4, -4677, 0)
	else
		CreatureObject(pPlayer):sendSystemMessage("You are not authorized to use this terminal")
	end
	return 0
end

function RebelZephyrScreenPlay:teleportTalus(pCollectorC, pPlayer)
	if (pPlayer == nil) then
		return
	end

	if CreatureObject(pPlayer):isRebel() then	
		SceneObject(pPlayer):switchZone("talus", 2391, 4, -4990, 0)
	else
		CreatureObject(pPlayer):sendSystemMessage("You are not authorized to use this terminal")
	end
	return 0
end

function RebelZephyrScreenPlay:teleportRebelOutpost(pCollectorD, pPlayer)
	if (pPlayer == nil) then
		return
	end

	if CreatureObject(pPlayer):isRebel() then	
		SceneObject(pPlayer):switchZone("rori", 3691, 0, -6403, 0)
	else
		CreatureObject(pPlayer):sendSystemMessage("You are not authorized to use this terminal")
	end
	return 0
end

function RebelZephyrScreenPlay:teleportStarbird(pCollectorE, pPlayer)
	if (pPlayer == nil) then
		return
	end

	if CreatureObject(pPlayer):isRebel() then	
		SceneObject(pPlayer):switchZone("rori", -5310, 0, 5009, 0)
	else
		CreatureObject(pPlayer):sendSystemMessage("You are not authorized to use this terminal")
	end
	return 0
end

function RebelZephyrScreenPlay:teleportHideout(pCollectorF, pPlayer)
	if (pPlayer == nil) then
		return
	end

	if CreatureObject(pPlayer):isRebel() then	
		SceneObject(pPlayer):switchZone("corellia", -6522, 0, 6035, 0)
	else
		CreatureObject(pPlayer):sendSystemMessage("You are not authorized to use this terminal")
	end
	return 0
end

function RebelZephyrScreenPlay:teleportSafehouse(pCollectorG, pPlayer)
	if (pPlayer == nil) then
		return
	end

	if CreatureObject(pPlayer):isRebel() then	
		SceneObject(pPlayer):switchZone("lok", -4766, 0, 3512, 0)
	else
		CreatureObject(pPlayer):sendSystemMessage("You are not authorized to use this terminal")
	end
	return 0
end

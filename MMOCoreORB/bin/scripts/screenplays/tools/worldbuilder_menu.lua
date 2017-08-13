-- Legend of Hondo
-- Admin items for decorating / world building

local ObjectManager = require("managers.object.object_manager")
includeFile("tools/worldbuilder_items.lua")

AdminDecor = ScreenPlay:new {
	numberOfActs = 1,
}
registerScreenPlay("AdminDecor", true)

function AdminDecor:openWindow(pPlayer)
	if (pPlayer == nil) then
		return
	end

	self:showCategories(pPlayer)
end

function AdminDecor:showCategories(pPlayer)
	local sui = SuiListBox.new("AdminDecor", "showItems") -- calls showItems on SUI window event

	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())

	sui.setTitle("Admin Decor")
	sui.setPrompt("Decorative items for admin use. These items may be placed outside and moved/rotated like any piece of furniture. They will be deleted when the server reboots. \n\nTo automatically generate screenplay code that will load the normal non-targetable versions of these objects, select an object and type\n /tarkin spOutStatic\nThis will put the loadSceneObject screenplay call in the following file on the server (so you can cut/paste it into your desired screenplay)\n /home/tarkin/Core3/MMOCoreORB/bin/custom_scripts/tmp/spOutStatic.lua \n\nSelect a catagory from the list below.")

	for i = 1, #wbiTable, 1 do
		sui.add(wbiTable[i].catName, "")
	end

	sui.sendTo(pPlayer)
end

function AdminDecor:showItems(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end


	if (args == "-1") then
		CreatureObject(pPlayer):sendSystemMessage("No category was selected...")
		return
	end


	local selectedIndex = tonumber(args) + 1

	writeScreenPlayData(pPlayer, "AdminDecor", "categorySelected", selectedIndex) 

	local sui = SuiListBox.new("AdminDecor", "itemSelection") -- calls itemSelection on SUI window event

	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())

	sui.setTitle("Admin Decor")
	sui.setPrompt(wbiTable[selectedIndex].catName .. "\n\n Press Cancel to return to the main menu.")

	for i = 1, #wbiTable[selectedIndex].items, 2 do
		sui.add(wbiTable[selectedIndex].items[i], wbiTable[selectedIndex].items[i+1])
	end

	sui.sendTo(pPlayer)
end

function AdminDecor:itemSelection(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return self:showCategories(pPlayer)
	end

	if (args == "-1") then
		CreatureObject(pPlayer):sendSystemMessage("No item was selected...")
		return
	end

	local selectedItemIndex = tonumber(args) + 1
	local catIndex = tonumber(readScreenPlayData(pPlayer, "AdminDecor", "categorySelected"))

	local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")
	local pItem = giveItem(pInventory, wbiTable[catIndex].items[selectedItemIndex*2], -1)

	self:showItems(pPlayer, pSui, eventIndex, catIndex-1) -- Opens the current screen again
end

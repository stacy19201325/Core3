/*
				Copyright Tarkin Project
		See file COPYING for copying conditions.*/

#ifndef TARKINCOMMAND_H_
#define TARKINCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"

class TarkinCommand : public QueueCommand {
public:

	TarkinCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		if (!creature->isPlayerCreature())
			return GENERALERROR;

		ManagedReference<PlayerObject*> ghost = creature->getPlayerObject();

		if (ghost == NULL)
			return GENERALERROR;

		StringTokenizer args(arguments.toString());

		try {
			String command;

			if(args.hasMoreTokens()){
				args.getStringToken(command);	
			} else {
				throw Exception();
			}
			
			command = command.toLowerCase();
			
			if(command == "aboutme"){
				aboutMe(creature);
			} else if (command == "houseplop"){
				housePlop(creature, ghost);
			} else if (command == "wbi"){
				worldBuildingItems(creature);
			} else if (command == "spoutstatic"){
				spOutStatic(creature, target);
			} else {
				throw Exception();
			}
			
		} catch (Exception& e){
			StringBuffer text;
			text << endl;
			text << "Tarkin: The Command" << endl;
			text << "- - - - - - - - - - - - - - - - - - -" << endl;
			text << "/tarkin aboutme"  << endl;
			text << "- Provides a list of helpful information about lots, vendors, etc."  << endl;
			//text << "/tarkin newCommand"  << endl;
			//text << "- Description of new command"  << endl;
			text << endl;
			
			if (ghost->isAdmin()){
				text << "Tarkin: Admin Commands" << endl;
				text << "- - - - - - - - - - - - - - - - - - -" << endl;
				text << "/tarkin housePlop"  << endl;
				text << "- Calls a menu that allows an admin to place a building where they're standing."  << endl;
				text << "/tarkin wbi"  << endl;
				text << "- Calls a menu that generates special world building items into the inventory. Admin can drop these items outside and use them to output screenplay data to permanently load the non-touchy versions of the objects (filler buildings, walls, etc)."  << endl;
				text << "/tarkin spOutStatic"  << endl;
				text << "- writes a spawnSceneObject screenplay call for the static version of the selected to a file on the server."  << endl;
			}
			
			creature->sendSystemMessage(text.toString());
		}

		return SUCCESS;
	}


	// Helpful account information for a player
	void aboutMe(CreatureObject* creature) const {
		if(creature->getZoneServer() == NULL)
			return;

		ManagedReference<PlayerObject*> ghost = creature->getPlayerObject();
		ManagedReference<AuctionManager*> auctionManager = server->getZoneServer()->getAuctionManager();

		if (ghost == NULL || auctionManager == NULL)
			return;

		ManagedReference<AuctionsMap*> auctionsMap = auctionManager->getAuctionMap();
		if(auctionsMap == NULL)
			return;

		PlayerManager* playerManager = server->getZoneServer()->getPlayerManager();

		if(playerManager == NULL)
			return;

		int lotsRemaining = ghost->getLotsRemaining();


		StringBuffer body;

		body << "Player Name: " << creature->getFirstName() << endl;
		body << "Unused Lots: " << String::valueOf(lotsRemaining) << endl << endl;
		body << "Structures:";

		for (int i = 0; i < ghost->getTotalOwnedStructureCount(); i++) {
			ManagedReference<StructureObject*> structure = creature->getZoneServer()->getObject(ghost->getOwnedStructure(i)).castTo<StructureObject*>();

			int num = i + 1;
			body << endl << String::valueOf(num) << ". ";

			if (structure == NULL) {
				body << "NULL Structure" << endl;
				continue;
			}
			
			StringIdManager* sidman = StringIdManager::instance();
			String buildingName = sidman->getStringId("@building_name:" + structure->getObjectNameStringIdName()).toString();

			body << buildingName << endl;
			//body << "    Type: " << structure->getObjectNameStringIdName() << endl; // debug
			body << "    Lots: " << String::valueOf(structure->getLotSize()) << endl;
			body << "    Maintenance Pool: " << String::valueOf(structure->getSurplusMaintenance()) << " credits" << endl;
			body << "    Maintenance Rate: " << String::valueOf(structure->getMaintenanceRate()) << " credits/hr" << endl;

			if (structure->getBasePowerRate() > 0) {
				body << "    Power Reserves: " << String::valueOf(structure->getSurplusPower()) << " units" << endl;
				body << "    Power Consumption: " << String::valueOf(structure->getBasePowerRate()) << " units/hr" << endl;
			}

			body << "    Planet: ";
			Zone* zone = structure->getZone();
			if (zone == NULL) {
				body << "NULL" << endl;
			} else {
				body << zone->getZoneName() << endl;
				body << "    World Position: " << structure->getWorldPositionX() << ", " << structure->getWorldPositionY() << endl;
			}
			body << endl;
		}
		body << " - - - - - - - " << endl;
		body << endl;
		body << "Vendors:" << endl;
		body << "Max # of vendors: " << creature->getSkillMod("manage_vendor") << endl;
		body << "Max # of items: " << creature->getSkillMod("vendor_item_limit") << endl;
		body << "Total # of items: " << auctionsMap->getPlayerItemCount(creature) << endl;
		body << endl;

		SortedVector<unsigned long long>* ownedVendors = ghost->getOwnedVendors();
		for (int i = 0; i < ownedVendors->size(); i++) {
			ManagedReference<SceneObject*> vendor = creature->getZoneServer()->getObject(ownedVendors->elementAt(i));

			int num = i + 1;
			body << String::valueOf(num) << ". ";

			if (vendor == NULL) {
				body << "NULL Vendor" << endl << endl;
				continue;
			}

			body << vendor->getDisplayedName() << endl;

			DataObjectComponentReference* data = vendor->getDataObjectComponent();
			if(data == NULL || data->get() == NULL || !data->get()->isVendorData()) {
				body << "    NULL Data Component" << endl << endl;
				continue;
			}

			VendorDataComponent* vendorData = cast<VendorDataComponent*>(data->get());
			if(vendorData == NULL) {
				body << "    NULL Vendor Data Component" << endl << endl;
				continue;
			}

			bool init = false;
			if (vendorData->isInitialized())
				init = true;

			body << "    Initialized? " << (init ? "Yes" : "No");
			body << endl << "    # of items: " << auctionsMap->getVendorItemCount(vendor) << endl;

			float secsRemaining = 0.f;
			if( vendorData->getMaint() > 0 ){
				secsRemaining = (vendorData->getMaint() / vendorData->getMaintenanceRate())*3600;
			}

			body << "    Maintenance Pool: " << String::valueOf(vendorData->getMaint()) << " credits " << endl;
			body << "    Maintenance Rate: " << String::valueOf((int)vendorData->getMaintenanceRate()) << " credits/hr" << endl;

			body << "    Planet: ";
			Zone* zone = vendor->getZone();
			if (zone == NULL){
				body << "NULL" << endl;
			} else if (!vendor->getParent().get()->isCellObject()) {
				body << zone->getZoneName() << endl;
				body << "    World Position: My Inventory" << endl;
			} else {
				body << zone->getZoneName() << endl;
				body << "    World Position: " << vendor->getWorldPositionX() << ", " << vendor->getWorldPositionY() << endl;
			}
			body << endl;
		}
		
		body << " - - - - - - - " << endl;
		body << endl;
		body << "Vetern Rewards Available:" << endl;

		for( int i = 0; i < playerManager->getNumVeteranRewardMilestones(); i++ ){
			int milestone = playerManager->getVeteranRewardMilestone(i);
			String claimedReward = ghost->getChosenVeteranReward(milestone);
			if( claimedReward.isEmpty() )
				body << String::valueOf(milestone) << " days";

			if (i+1 != playerManager->getNumVeteranRewardMilestones()){
				body << ", ";
			} else {
				body << ".";
			}
		}

		ManagedReference<Account*> account = ghost->getAccount();

		body << " I have " << account->getAgeInDays() << " days logged for veteran rewards.";

		// Wrap it up and send it off
		ManagedReference<SuiMessageBox*> box = new SuiMessageBox(creature, 0);
		box->setPromptTitle("About Me");
		box->setPromptText(body.toString());
		box->setUsingObject(ghost);
		box->setForceCloseDisabled();

		ghost->addSuiBox(box);
		creature->sendMessage(box->generateMessage());
	}
	
	// Opens a window that allows an admin to place a structure from the list
	void housePlop(CreatureObject* creature, PlayerObject* ghost) const {
		// For an admin-only command
		if (!ghost->isAdmin())
			throw Exception(); 
		
		if (creature->getParent() != NULL){
			creature->sendSystemMessage("You must be outside to place a structure.");
			throw Exception();
		}

		Lua* lua = DirectorManager::instance()->getLuaInstance();

		Reference<LuaFunction*> housePlop = lua->createFunction("HousePlop", "openWindow", 0);
		*housePlop << creature;

		housePlop->callFunction();
	}
	
	// Opens a window that despenses special world builder items for admin use
	void worldBuildingItems(CreatureObject* creature) const {
		Lua* lua = DirectorManager::instance()->getLuaInstance();

		Reference<LuaFunction*> adminDecor = lua->createFunction("AdminDecor", "openWindow", 0);
		*adminDecor << creature;

		adminDecor->callFunction();
	}
	
	// Outputs a screenplay call spawnSceneObject("planet", "staticObjectTemplateFilePathAndName", x, z, y, cellNumber, dw, dx, dy, dz>
	// to file on server at Core3/MMOCoreORB/bin/custom_scripts/tmp/spOutStatic.lua
	void spOutStatic(CreatureObject* creature, const uint64& target) const {
		ManagedReference<SceneObject*> object = server->getZoneServer()->getObject(target, false);

		String planetName = "";
		String templateFile = "";

		if (object == NULL){
			planetName = creature->getZone()->getZoneName();
		} else {
			planetName = object->getZone()->getZoneName();
			templateFile = object->getObjectTemplate()->getFullTemplateString();
		}

		StringBuffer text;
		
		if (!templateFile.contains("hondo/decoration")){
			creature->sendSystemMessage("Error: Target object must be a decendant of object/tangible/hondo/decoration/");
			throw Exception();
		}

		// Examples:
		// object/tangible/hondo/decoration/building/tatooine/filler_building_tatt_style01_01.lua
		// object/tangible/hondo/decoration/structure/tatooine/antenna_tatt_style_2.lua
		// get changed to
		// object/building/tatooine/filler_building_tatt_style01_01.lua
		// object/static/structure/tatooine/antenna_tatt_style_2.iff

		if (templateFile.contains("decoration/building")){
			templateFile = templateFile.replaceAll("tangible/hondo/decoration/", ""); // Fix path for filler type buildings
		} else {
			templateFile = templateFile.replaceAll("tangible/hondo/decoration", "static"); // Fix path for static objects
		}

		text << "spawnSceneObject(\"" << planetName << "\", \"" << templateFile << "\", ";

		if (object->getParent() != NULL && object->getParent().get()->isCellObject()) {
			// Inside
			ManagedReference<CellObject*> cell = cast<CellObject*>( object->getParent().get().get());
			Vector3 cellPosition = object->getPosition();

			text << cellPosition.getX() << ", " << cellPosition.getZ() << ", " << cellPosition.getY() << ", " << cell->getObjectID() << ", ";
		}else {
			// Outside
			Vector3 worldPosition = object->getWorldPosition();
			text << worldPosition.getX() << ", " << worldPosition.getZ() << ", " << worldPosition.getY() << ", " << "0" << ", ";
		}

		Quaternion* dir = object->getDirection();

		text << dir->getW() << ", " << dir->getX() << ", " << dir->getY() << ", " << dir->getZ() << ")";

		// Write the data to the file
		File* file = new File("custom_scripts/tmp/spOutStatic.lua");
		FileWriter* writer = new FileWriter(file, true); // true for appending new lines

		writer->writeLine(text.toString());

		writer->close();
		delete file;
		delete writer;

		creature->sendSystemMessage("Data written to Core3/MMOCoreORB/bin/custom_scripts/tmp/spOutStatic.lua!");
		
	}
};

#endif //TARKINCOMMAND_H_

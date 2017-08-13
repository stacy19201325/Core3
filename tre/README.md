### Instructions
- Each folder must be packed as it's own tre file. 
- New content *ALWAYS* goes into the tarkin_custom_tre folder. 
- Should the tarkin_custom_tre folder become larger than 100MB, create a new folder called tarkin_custom_2_tre and use make that the *OLNY* place where new content goes. Repeat this every time a TRE reaches 100MB. Why? Because that's how SOE optimized the client and it makes sense in a lot of ways.
- When creating the tre file for tarkin_custom_tre, it is a good practice to name the resulting file tarkin_custom_DAYmonthYEARtre, such as tarkin_custom_23JUL17.tre, and keep the old file as a backup.
- The other two folders, tarkin_post and tarkin_pre are needed for to ensure the NGE houses are loaded properly. Unless some fixes are found related to the NGE houses, these tre files will never change and thus they need to be rebuilt.


#### Loading Order - Client
- Loaded from swgemu_live.cfg, the client must load the Tarkin custom content in this order, with the most recent content additions being directly below default_patch.tre (which contains only 3 default textures).

searchTree_00_29=default_patch.tre  
searchTree_00_28=tarkin_custom_23JUL17.tre  
searchTree_00_27=tarkin_post14.tre  
searchTree_01_26=patch_sku1_14_00.tre  
searchTree_00_25=patch_14_00.tre  
searchTree_00_24=tarkin_pre14.tre  
...  

- Note that numbers, 28, 29, etc can be added to as new tre files are created.

#### Loading Order - Server
- Loaded from Core3/MMOCoreORB/bin/conf/config.lua
- The Tarkin II repo does not contain this file, for security reasons. You can find a default copy inside the official SWGEmu repo.

"default_patch.tre",  
"tarkin_custom_23JUL17.tre",  
"tarkin_post14.tre",  
"patch_sku1_14_00.tre",  
"patch_14_00.tre",  
"tarkin_pre14.tre",  
...  

#### CRC File
- The file tre/tarkin_custom_tre/misc/object_template_crc_string_table.iff is the that tells the client (and server) what objects exist in the game. Any time a new object is added to the game, the object file for it must be added to this file otherwise it won't show up on the client. Unfortunately, this file is saved in a proprietary format which prevents it from being tracked by git like a normal text file. As a result we have to pay careful attention to how we maintain it. 
- All new objects should be added *ONLY* to tre/tarkin_custom_tre/misc/object_template_crc_string_table.iff, ignoring the older version in the tre/tarkin_post/ folder (as the client/server will load the tarkin_custom_tre instead).
- If you are working on a mod that will edit this file, always make a copy of the current file from tarkin_custom_tre/misc/ and rename the original as redundant backup (put the date short form in at the end of the file name for good measure). Inform other team members that you *have already added your changes to the file* so that you can push those changes and make them available to other team members if need be. Good teamwork here will prevent issues where two people have added a few entries to the files. 
- Maintainting a plain text file that lists all the custom entries to the CRC table that have been made, with a simple format where the most recent additions are always on the top of the file, is an execellent way to avoid losing data and to generally make our mods easier to understand. AU1217 - I've added object_template_crc_string_table.txt for this purpose, but I did not fill it in the entire history of our mods. 

#### Creating the TRE Files
- Use Sytner's IFF Editor (SIE), which you can download from www.modthegalaxy.com. Other tools, such as TRE Explorer and TRE-Edit tend to occasionally create corrupted files. 
- As of version 3.6.0.0 of SIE, the workflow is basically...

1. Copy the current tre from the repo to your Windows desktop. You can do this by using a shared folder from your development VM (Best practice) or by downloading the repo from GitHub. Make sure you're on the correct branch in git, either way.
2. Open SIE.
2. Click on the Repository window.
3. On the right side of the toolbar near the top, select TOC/TRE builder > Create .tre from directory on disk.
4. Browse to the folder where the tre files are, such as tarkin_custom_tre, and select it. Give the output file a name (including the .tre extention) and save it.  


You are now freee to backup the old tre file (tarkin_custom_23JUL17.tre) and distribute its more up to date replacement (tarkin_custom_15AUG17.tre).

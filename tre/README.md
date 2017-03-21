This directory contains custom files that are required for both the client and the server. The files must be packed into TRE files and loaded in a specific order. Use Sytner's IFF Editor to pack the TRE files.

### Pack the tre files like so: 
```
tarkin_custom_tre ---> tarkin_custom.tre 
tarkin_housing_system ---> tarkin_housing_system.tre 
tarkin_post ---> tarkin_post.tre 
tarkin_pre ---> tarkin_pre.tre 
```

### Client TRE Order

Inisde swgemu_live.cfg
```
[SharedFile] 
	maxSearchPriority=31 
	searchTree_00_30=default_patch.tre 
	searchTree_00_29=tarkin_housing_system.tre 
	searchTree_00_28=tarkin_custom.tre 
	searchTree_01_27=tarkin_post.tre 
	searchTree_00_26=patch_sku1_14_00.tre 
	searchTree_00_25=patch_14_00.tre 
	searchTree_00_24=tarkin_pre.tre 
	searchTree_01_23=patch_sku1_13_00.tre 
	.... 
```

### Server TRE Order

Inside Core3/MMOCoreORB/bin/conf/config.lua 
```
TreFiles = { 
	"default_patch.tre", 
	"tarkin_housing_system.tre", 
	"tarkin_custom.tre", 
	"tarkin_post.tre", 
	"patch_sku1_14_00.tre", 
	"patch_14_00.tre", 
	"tarkin_pre.tre", 
	"patch_sku1_13_00.tre", 
	....
```	
### IMPORTANT NOTE ABOUT CRC TABLE EDITNG:

The _ONLY_ CRC table in the Tarkin TRE file structure is loaded from tarkin_post.tre, which is located here, 

Core3/tre/tarkin_post/misc/object_template_crc_string_table.iff 

Any time new items need to be added to the CRC table, even when the items are for new features that will be packed in their own TRE files, you _NEED_ to add them to this CRC file and repack the tarkin_post.tre file (rather than making a new copy of CRC file in the TRE file for your new feature).  

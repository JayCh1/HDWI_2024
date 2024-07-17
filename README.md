# HDWI_USFS_cloud

11 July 2024 

cloned/copied from the USFS Github repository for further development and optimization (history on USFS github
included below)

17 July 2024

a) created two branches for transition away from ncl to using shell script and ncgen

  i) branch #1 will contribute to the production of history/climate files by computing HDWI for a single yyyymmddhh

  ii) branch #2 will compute HDWI values for a single day using all times available for burn period for that day








@@@@@@@@@@@@@@@@@ USFS repo history) @@@@@@@@@@@@@@@@@@@@@@

Repository to transition http://hdwindex.org products to USFS-hosted cloud environment

12 August 2022 Update:

I have added two directory trees to this repository:
  alaska
  conus

Each directory tree contains shell (bash) scripts, python code, fortran code (and executables), and NCAR Command Language (ncl)
scripts that combine to produce and archive HDWI datafiles and images for the alaska/conus domain. The scripts/code called by each 
shell script are included in the subdirectories where each script resides, with a from_<shell_script_name> naming convention. of the 
On our stand-alone server, the alaska and conus scripts are called at different times and run to completion independently of each 
other. The two runs are quite close to identical, with only a few differences related to data times and how precisely the 
analyses are presented on the web page (link above).

16 August 2022

I have added html code and css files shell_ncgen_historythat are used by hdwindex.org as the public-facing front end for our product.

28 August

Today, I implemented the following changes:
a) removed the sub-folders in conus and alaska
b) renamed conus and alaska to HDW_script and HDW_scripts_AK respectively to align them with what's expected in the code
b) removed the old, non-functional html code - only the version of the html code that works is currently in the repository
c) added a new file (install_sequence) that include the steps needed to prepare a clean empty docker to run the conus and alaska scripts
d) added a "crontab" file to be used in docker
e) added new data and climo folders with files that are expected by the scripts in the HDW_script and HDW_scripts_AK folders

14 September

Today, I finished updating all the scripts, html code, crontab, and install_sequence files so the routines will execute cleanly 
a freshly initiated Docker that follows the instructions therein.

Next step is to test this for any lingering bugs, typos, or design flaws.



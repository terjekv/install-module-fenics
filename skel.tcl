#%Module1.0##################################################################
#
set appname    [lrange [split [module-info name] {/}] 0 0]
set appversion [lrange [split [module-info name] {/}] 1 1]
set apphome    /opt/uio/modules/packages/$appname/$appversion

set conda_env  fenicsproject

## Short description of package:
module-whatis   "The FEniCS Project is a collection of free software with an extensive list of features for automated, efficient solution of differential equations."

conflict python

## Modify as needed, removing any variables not needed.  Non-path variables
## can be set with "setenv VARIABLE value".
prepend-path    PATH            $apphome/envs/$conda_env/bin
# prepend-path	LD_LIBRARY_PATH	$profile/lib

#prepend-path	PYTHONPATH	$profile/lib/python2.7/site-packages
#prepend-path	PKG_CONFIG_PATH $profile/lib/pkgconfig
#prepend-path	BOOST_DIR	$profile
#prepend-path	CMAKE_PREFIX_PATH	$profile
setenv		INSTALL_PATH	$apphome

if { [module-info mode] != "whatis"  && [info exists ::env(MATINST_VERBOSE)] } {
    puts stderr "[module-info mode] FEniCS installation (PATH, MANPATH, INSTALL_PATH)"
}

# Help procedure: called by "module help FEniCS"
 proc ModulesHelp {} {
## URL of application homepage:
       set appurl     http://www.fenicsproject.org

       puts stderr "
       modulefile \"[module-info name]\" \n
       Set environment to enable the usage of the FEniCS distribution.
       This build is based on FEniCS' conda environment.\n
       For more information see $appurl \n"

          return 0
          }

## These lines are for logging module usage.  Don't remove them:
set modulefile [lrange [split [module-info name] {/}] 0 0]
set version    [lrange [split [module-info name] {/}] 1 1]
set action     [module-info mode]

if { [module-info mode] == "load" && ! [info exists ::env(MODULE_PRIVATE)] } {
    system logger -t module -p debug USER=$::tcl_platform(user),APP=,VERSION=
}

## Don't remove this line!  For some reason, it has to be here...

#!/sbin/sh

###########################
# MMT Reborn Logic
###########################

############
# Config Vars
############

# Set this to true if you want to skip mount for your module
SKIPMOUNT="false"
# Set this to true if you want to clean old files in module before injecting new module
CLEANSERVICE="false"
# Set this to true if you want to load vskel after module info print. If you want to manually load it, consider using load_vksel function
AUTOVKSEL="true"
# Set this to true if you want store debug logs of installation
DEBUG="true"

############
# Replace List
############

# List all directories you want to directly replace in the system
# Construct your list in the following example format
REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"
# Construct your own list here
REPLACE="
/system/priv-app/AsusLauncherDev
/system/priv-app/Lawnchair
/system/priv-app/NexusLauncherPrebuilt
/system/product/priv-app/ParanoidQuickStep
/system/product/priv-app/ShadyQuickStep
/system/product/priv-app/TrebuchetQuickStep
/system/product/priv-app/NexusLauncherRelease
/system/product/overlay/PixelLauncherIconsOverlay
/system/system_ext/priv-app/NexusLauncherRelease
/system/system_ext/priv-app/DerpLauncherQuickStep
/system/system_ext/priv-app/TrebuchetQuickStep
/system/system_ext/priv-app/Lawnchair
/system/system_ext/priv-app/PixelLauncherRelease
/system/system_ext/priv-app/Launcher3QuickStep
"

############
# Permissions
############

# Set permissions
set_permissions() {
  set_perm_recursive "$MODPATH" 0 0 0777 0777
  set_perm_recursive "$MODPATH/system/product/overlay" 0 0 0777 0777
}

############
# Info Print
############

# Set what you want to be displayed on header of installation process
info_print() {
  ui_print ""
  ui_print "**********************************************"
  ui_print "• Systemless Lawnchair Extra"
  ui_print "• By TeamFiles"
  ui_print "**********************************************"
  ui_print ""
    
  sleep 2
}

############
# Main
############

# Change the logic to whatever you want
init_main() {  
  ui_print ""
  ui_print "[*] Which variant you want to install?"
  ui_print "Press volume up to switch to another launcher variant"
  ui_print "Press volume down to install that variant"
  ui_print "Check Systemless Lawnchair Extra Post on @modulesrepo telegram"
  ui_print "to get Difference Between Variants"
  ui_print ""
  
  sleep 1.5
  
  ui_print "[1] Alpha 4 Official, Android 12L Only"
  ui_print "[2] Developer Build #1029, Android 12L Only"
  ui_print "[3] Old, Android 11 & Android 12 Only"
  
  ui_print ""
  ui_print "[*] Select which variant you want:"
  
  SM=1
  while true; do
    ui_print "  $SM"
    "$VKSEL" && SM="$((SM + 1))" || break
    [[ "$SM" -gt "3" ]] && SM=1
  done

  case "$SM" in
  "1") FCTEXTAD1="Alpha 4 Official";;
  "2") FCTEXTAD1="Developer Build #1029";;
  "3") FCTEXTAD1="Old, Android 11-12";;
  esac

  ui_print "[*] Selected: $FCTEXTAD1"
  ui_print ""
  
  if [[ "$FCTEXTAD1" == "Alpha 4 Official" ]]; then
    mv -f "$MODPATH/system/priv-app/Lawnchair/official.apk" "$MODPATH/system/priv-app/Lawnchair/Lawnchair.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnchair/developer.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnchair/old.apk"

  elif [[ "$FCTEXTAD1" == "Developer Build #1029" ]]; then
    mv -f "$MODPATH/system/priv-app/Lawnchair/developer.apk" "$MODPATH/system/priv-app/Lawnchair/Lawnchair.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnchair/official.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnchair/old.apk"

  elif [[ "$FCTEXTAD1" == "Old, Android 11-12" ]]; then
    mv -f "$MODPATH/system/priv-app/Lawnchair/old.apk" "$MODPATH/system/priv-app/Lawnchair/Lawnchair.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnchair/official.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnchair/developer.apk"
  fi
  
  ui_print ""
  ui_print "[*] Do you wanna use AOSP Enhance?"
  ui_print "[*] This will make launcher smoother"
  ui_print "[*] If you get random freezes then don't use this"
  ui_print "[*] It's made by @iamlooper(telegram)"
  ui_print "Press volume up to switch to another choice"
  ui_print "Press volume down to continue with that choice"
  ui_print ""
  
  sleep 1.5
  
  ui_print "[1] Yes"
  ui_print "[2] No"
  
  ui_print ""
  ui_print "[*] Select your desired option:"
  
  SM=1
  while true; do
    ui_print "  $SM"
    "$VKSEL" && SM="$((SM + 1))" || break
    [[ "$SM" -gt "2" ]] && SM=1
  done

  case "$SM" in
  "1") FCTEXTAD1="Yes";;
  "2") FCTEXTAD1="No";;
  esac

  ui_print "[*] Selected: $FCTEXTAD1"
  ui_print ""
  
  if [[ "$FCTEXTAD1" == "Yes" ]]; then
    [[ "$IS64BIT" == "true" ]] && mv -f "$MODPATH/system/bin/aosp_enhancer64" "$MODPATH/system/bin/aosp_enhancer" || mv -f "$MODPATH/system/bin/aosp_enhancer32" "$MODPATH/system/bin/aosp_enhancer"

  elif [[ "$FCTEXTAD1" == "No" ]]; then
	rm -rf "$MODPATH/system/bin/aosp_enhancer64"
	rm -rf "$MODPATH/system/bin/aosp_enhancer32"
	rm -rf "$MODPATH/service.sh"
  fi
  
  ui_print ""
  ui_print "[*] Which of the following lawnicons you want to install?"
  ui_print "Press volume up to switch to another lawnicons version"
  ui_print "Press volume down to install those lawnicons"
  ui_print ""
  
  sleep 1.5
  
  ui_print "[1] Official Lawnicons"
  ui_print "[2] Lawnicons By TeamFiles"
  ui_print "[3] RK Icons"
  ui_print "[4] DG Icons"
  ui_print "[5] Acons"
  ui_print "[6] Cayicons"
  ui_print "[7] None Of The Above"
  
  ui_print ""
  ui_print "[*] Select which lawnicons you want:"
  
  SM=1
  while true; do
    ui_print "  $SM"
    "$VKSEL" && SM="$((SM + 1))" || break
    [[ "$SM" -gt "7" ]] && SM=1
  done

  case "$SM" in
  "1") FCTEXTAD1="Official Lawnicons";;
  "2") FCTEXTAD1="Lawnicons By TeamFiles";;
  "3") FCTEXTAD1="RK Icons";;
  "4") FCTEXTAD1="DG Icons";;
  "5") FCTEXTAD1="Acons";;
  "6") FCTEXTAD1="Cayicons";;
  "7") FCTEXTAD1="None";;
  esac

  ui_print "[*] Selected: $FCTEXTAD1"
  ui_print ""
  
  if [[ "$FCTEXTAD1" == "Official Lawnicons" ]]; then
    mv -f "$MODPATH/system/priv-app/Lawnicons/Lawnicons.apk" "$MODPATH/system/priv-app/Lawnicons/Lawnicons.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnicons/Acons.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnicons/cayicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/DGicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/RKicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/TeamFiles.apk"

  elif [[ "$FCTEXTAD1" == "Lawnicons By TeamFiles" ]]; then
    mv -f "$MODPATH/system/priv-app/Lawnicons/TeamFiles.apk" "$MODPATH/system/priv-app/Lawnicons/TeamFiles.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnicons/Acons.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnicons/cayicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/DGicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/RKicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/Lawnicons.apk"

  elif [[ "$FCTEXTAD1" == "RK Icons" ]]; then
    mv -f "$MODPATH/system/priv-app/Lawnicons/RKicons.apk" "$MODPATH/system/priv-app/Lawnicons/RKicons.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnicons/Acons.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnicons/cayicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/DGicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/TeamFiles.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/Lawnicons.apk"
	
  elif [[ "$FCTEXTAD1" == "DG Icons" ]]; then
    mv -f "$MODPATH/system/priv-app/Lawnicons/DGicons.apk" "$MODPATH/system/priv-app/Lawnicons/DGicons.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnicons/Acons.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnicons/cayicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/RKicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/TeamFiles.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/Lawnicons.apk"
	
  elif [[ "$FCTEXTAD1" == "Acons" ]]; then
    mv -f "$MODPATH/system/priv-app/Lawnicons/Acons.apk" "$MODPATH/system/priv-app/Lawnicons/Acons.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnicons/DGicons.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnicons/cayicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/RKicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/TeamFiles.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/Lawnicons.apk"
	
  elif [[ "$FCTEXTAD1" == "Cayicons" ]]; then
    mv -f "$MODPATH/system/priv-app/Lawnicons/cayicons.apk" "$MODPATH/system/priv-app/Lawnicons/cayicons.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnicons/DGicons.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnicons/Acons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/RKicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/TeamFiles.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/Lawnicons.apk"
	
   elif [[ "$FCTEXTAD1" == "None" ]]; then
    rm -rf "$MODPATH/system/priv-app/Lawnicons/Acons.apk"
    rm -rf "$MODPATH/system/priv-app/Lawnicons/cayicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/DGicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/RKicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/Lawnicons.apk"
	rm -rf "$MODPATH/system/priv-app/Lawnicons/TeamFiles.apk"
  fi
  
  ui_print "[*] Clearing system cache to properly make it work..."
  ui_print ""

  rm -rf "/data/system/package_cache"

  sleep 0.5

  ui_print "[*] Done!"
  ui_print ""

  sleep 0.5

  ui_print " --- Notes --- "
  ui_print ""
  ui_print "[*] Reboot is required"
  ui_print ""
  ui_print "[*] Report issues to @fileschat on Telegram"
  ui_print ""
  ui_print "[*] You can find me at @saitama_96 on Telegram for direct support"

  sleep 2
}
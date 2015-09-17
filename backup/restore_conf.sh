#!/bin/bash
# restore apps' conf

echo " "
echo " "
echo "=========================================================="
echo "         Which backup do you want to restore ?"
echo "----------------------------------------------------------"
echo " "
echo " "
echo " "


cd backup/confs/
printf "Please select server's conf to be restored :\n"
select save in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done

echo "$save"

cd ../../

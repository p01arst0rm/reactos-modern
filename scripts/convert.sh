#!/usr/bin/env sh
# --------------------------------------------------------------------
# 
# Convert PNG Images to gif using gimp and it's script-fu capabilities
# --------------------------------------------------------------------
# Usage: 
# convert.cmd C:\path\to\tiff\directory
# --------------------------------------------------------------------

integer max_count=`ls *.${source_fmt} | wc -l`
integer count=1

_gimp="'/c/Program Files/GIMP 2/'"


for i in `ls ${1}*.tif`
do
  echo "[ CONVERTING ] (${count}/${max_count}):"
  echo "${inp_file}"
  echo "${out_file}"

  inp_file=$i

  name=`echo $i | awk '{ n=split($0,a,"."); print a[1]; }'`
  out_file="${name}.png"

  gimp_script="(let* ((img (car"
  gimp_script="${gimp_script} (file-tiff-load 1 \"${inp_file}\" \"${inp_dirinp_file}\")))"
  gimp_script="${gimp_script} (drawable (car (gimp-image-active-drawable img))))"
  gimp_script="${gimp_script} (file-png-save 1 img drawable \"${out_file}\" \"${out_file}\" 1 0 0 0 0 0 0))"
  gimp_script="${gimp_script} (gimp-quit 0))"
  
  echo ""
  echo $gimp_script
  echo ""

  ${_gimp} -c -i -d -b "$gimp_script"
  # --------------------------------
  
  ((cnt = cnt + 1))
done
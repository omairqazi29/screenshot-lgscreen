screen=$(sed -n '/DHCP_LG_FRAMES_MAX=/ s///p' personavars.txt)
rm lg-*.png
until [ $screen -eq 1 ]
do
  ssh -T lg@lg$screen << EOF
  rm lg-$screen*.png
  export DISPLAY=:0
  scrot "lg-"$screen"_%d-%m-%Y_%H-%M-%S.png" -e 'echo \$f > .scrotname'
EOF
  fname=$(ssh -T lg@lg$screen 'cat .scrotname')
  scp lg@lg$screen:/home/lg/$fname ~/
  echo 'Screenshot of screen number '$screen' is saved as '$fname' in the home directory'
  ((screen=screen-1))
done
scrot 'lg-1_%d-%m-%Y_%H-%M-%S.png' -e 'echo Screenshot of screen number 1 is saved as $f in the home directory'

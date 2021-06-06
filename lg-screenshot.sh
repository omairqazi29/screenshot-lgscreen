read -p 'Enter path to save the img into: ' path
read -p 'Enter screen number: ' screen
smax=$(sed -n '/DHCP_LG_FRAMES_MAX=/ s///p' personavars.txt)
until [ $screen -le $smax ] && [ $screen -gt 0 ]
do
  echo 'Screen number '$screen' not included in the installation, please try again.'
  read -p 'Enter screen number: ' screen
done
ssh -T lg@lg$screen << EOF
export DISPLAY=:0
scrot "lg-"$screen"_%d-%m-%Y_%H-%M-%S.png" -e 'echo \$f > .scrotname'
EOF
fname=$(ssh -T lg@lg$screen 'cat .scrotname')
scp lg@lg$screen:/home/lg/$fname $path
echo 'Screenshot of screen number '$screen' is saved as '$fname' in '$path

1/ pacman -S docker vagrant ansible python-pywinrm

2/ vagrant plugin install  vagrant-reload

Si il y a un pb de version avec la command à l'etape 2, faire `export VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1` et reessayé la commande 2

------------------
./goad.sh -t check -l GOAD -p virtualbox -m local
./goad.sh -t install -l GOAD -p virtualbox -m local


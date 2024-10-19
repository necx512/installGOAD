# Installation v3 beta

## Etape 1:
`git clone https://github.com/Orange-Cyberdefense/GOAD.git`

## Etape 2
`git checkout v3-beta`

## Etape 3
Due to some issues modify the following files:

**goad.sh**
Check python version with `python3 --version` and adapt it in goad.sh. For exemple, if python's version is 3.12.07, change `if [ "$version_numeric" -ge 30800 ] && [ "$version_numeric" -lt 31200 ]; then` to `if [ "$version_numeric" -ge 30800 ] && [ "$version_numeric" -lt 31208 ]; then`

**requirements.yml**
remplacer `ansible-core==2.12.6` par `ansible-core`

## Etape 4
rm -rf ~/.goad

## Etape 5 Check
Run `./goad.sh -p virtualbox` to get a CLI.
It the interface run `check` : `GOAD/virtualbox/local/192.168.56.X > check`

## Etape 6 Install
Run `./goad.sh -p virtualbox` to get a CLI.
In the CLI:
`GOAD/virtualbox/local/192.168.56.X > set_lab GOAD`
`GOAD/virtualbox/local/192.168.56.X > set_ip_range 192.168.57`
`GOAD/virtualbox/local/192.168.57.X > install`





# General issues
Reinstaller ruby puis vagrant

## Vagrant

### Error 1
```bash
➜  /tmp vagrant plugin install vagrant-reload
Installing the 'vagrant-reload' plugin. This can take a few minutes...
Vagrant failed to properly resolve required dependencies. These
errors can commonly be caused by misconfigured plugin installations
or transient network issues. The reported error is:

conflicting dependencies bigdecimal (= 3.1.5) and bigdecimal (= 3.1.8)
  Activated bigdecimal-3.1.8
  which does not match conflicting dependency (= 3.1.5)

  Conflicting dependency chains:
    bigdecimal (= 3.1.8), 3.1.8 activated

  versus:
    bigdecimal (= 3.1.5)

  Gems matching bigdecimal (= 3.1.5):
    bigdecimal-3.1.5
```
**solution** : VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1 vagrant plugin install vagrant-reload

### Error 2
```
Timed out while waiting for the machine to boot. This means that
Vagrant was unable to communicate with the guest machine within
the configured ("config.vm.boot_timeout" value) time period.

If you look above, you should be able to see the error(s) that
Vagrant had when attempting to connect to the machine. These errors
are usually good hints as to what may be wrong.

If you're using a custom box, make sure that networking is properly
working and you're able to connect to the machine. It is a common
problem that networking isn't setup properly in these boxes.
Verify that authentication configurations are also setup properly,
as well.

If the box appears to be booting properly, you may want to increase
the timeout ("config.vm.boot_timeout") value.
[-] Providing error stop 
```

**solution** : vérifier qu'il n'y a pas de regles netfilter qui bloque



## Ansible
### Error 1
ERROR! Unexpected Exception, this is probably a bug: '_AnsiblePathHookFinder' object has no attribute 'find_spec'
Dans requirements.yml, remplacer `ansible-core==2.12.6` par `ansible-core`


## Vagrant / VB
### Error 1
```
The provider 'virtualbox' that was requested to back the machine
'GOAD-DC01' is reporting that it isn't usable on this system. The
reason is shown below:

Vagrant has detected that you have a version of VirtualBox installed
that is not supported by this version of Vagrant. Please install one of
the supported versions listed below to use Vagrant:

4.0, 4.1, 4.2, 4.3, 5.0, 5.1, 5.2, 6.0, 6.1, 7.0

A Vagrant update may also be available that adds support for the version
you specified. Please check www.vagrantup.com/downloads.html to download
the latest version.
[-] Providing error stop 
```
D'après `https://github.com/hashicorp/vagrant/issues/13501`, dans `/usr/bin/VBox`:

```
    VirtualBoxVM|virtualboxvm)
        exec "$INSTALL_DIR/VirtualBoxVM" "$@"
        ;;
    VBoxManage|vboxmanage)
    ########################
        if [[ $@ == "--version" ]]; then
           echo "7.0.0r164728"
        else
           exec "$INSTALL_DIR/VBoxManage" "$@"
        fi
        ;;
    ########################
    VBoxSDL|vboxsdl)
        exec "$INSTALL_DIR/VBoxSDL" "$@"
        ;;
```

### Error 2
```
There was an error while executing `VBoxManage`, a CLI used by Vagrant
for controlling VirtualBox. The command and stderr is shown below.

Command: ["startvm", "a39ee3c3-d837-4424-b38f-189618905cda", "--type", "headless"]

Stderr: VBoxManage: error: Out of memory condition when allocating memory with low physical backing. (VERR_NO_LOW_MEMORY)
VBoxManage: error: Details: code NS_ERROR_FAILURE (0x80004005), component ConsoleWrap, interface IConsole

[-] Providing error stop
```

**solution**
`echo 1 > /proc/sys/vm/drop_caches`










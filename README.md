# General issues
Reinstaller ruby puis vagrant

# Error 1
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

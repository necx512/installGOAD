1/ git clone git@github.com:necx512/GOAD.git

2/ Modify /etc/ssl/openssl.cfg st: 

```
[provider_sect]
default = default_sect
legacy = legacy_sect

[default_sect]
activate = 1

[legacy_sect]
activate = 1
```
 <span style="color:red">/!\\**Ensure that this file is restored after installation** text</span>.

3/ Ensure that:
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
<span style="color:red">/!\\**Ensure that this is restored after installation** text</span>.

4/ cd GOAD

5/ python3 -m venv venv_goad 

6/ source venv_goad/bin/activate

7/ export VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1

8/ python3 -m pip install ansible-core 
** Note. The official documentation say to do `python3 -m pip install ansible-core==2.12.6` but I have an issue with this version. The last version seems to work**

9/ python3 -m pip install pywinrm

10/ ansible-galaxy install -r ansible/requirements.yml

11/ ./goad.sh -t check -l GOAD -p virtualbox -m local

12/ ./goad.sh -t install -l GOAD -p virtualbox -m local
This should take about 2h30 on my machine

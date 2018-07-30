## Locale  
fix locale error:     
```bash
#locale # show locale vars
sudo locale-gen "en_US.UTF-8"
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
sudo dpkg-reconfigure locales
```
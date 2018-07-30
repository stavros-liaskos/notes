# Simulate visits from specific urls
I want to simulate visits from specific urls, so I can disable auth for that specific urls 
  
production vm: 192.168.33.11  
proxy vm: 192.168.33.50

add this in my `hosts` file:
```
## simulation of TEST Server Link Placement
192.168.33.50   staging.example.com
## production url simulation
192.168.33.11   www.example.com
```

add this in "production vm" .htaccess file
```
SetEnvIfNoCase Referer ^(http://staging.example.com|http://www.example.com/|) noauth=1

AuthType Basic
AuthName "prod preview"
AuthUserFile /var/www/.htpasswd
Require valid-user
Require env noauth
```
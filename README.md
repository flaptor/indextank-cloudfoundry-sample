IndexTank CloudFoundry Sample
=============================

This is a sample app, that can index random documents on an IndexTank instance provided by CloudFoundry.

Usage
-----
1. login on cloudfoundry, using vmc
2. create an indextank service on your cloud
```
vmc create-service indextank idxtnk_random
```
3. create the sample app
```
vmc push SOMEAPPNAME --path THIS_APP_DIRECTORY 
```
4. Bind the idxtnk_random service to your app
```
vmc bind-service SOMEAPPNAME idxtnk_random
```
5. Start your app
```
vmc start SOMEAPPNAME
```

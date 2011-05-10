IndexTank CloudFoundry Sample
=============================

This is a sample app, that indexes a random document  on an IndexTank instance provided by CloudFoundry.
If you are building a CloudFoundry app and need indextank support, just look at the **before** block.

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

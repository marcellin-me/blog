---
layout: post
title: Travis-ci - Send notification with custom message
description: "Send an notification from travis-ci to a list of specified email-addresses with customized message"
modified: 2016-09-29T05:35:00-04:00
tags: [travis-ci, email notification, continuous deployment]
---

### Description
We need to send email (with custom email) from travis to specified users when the build fails.

* NOTE: As of now, Travis-ci does not allow custom messages for email notification.

### End Goal

```yml
notifications:
  email:
    on_success: never
    on_failure: always
    recipients:
      - email1@domain.com
      - email2@domain.com
```

### Step by step

* Specify when to send email - only when build/test failed

```yml
on_success: never # do not send anything if build succeeds
on_failure: always # if there is a fail
# other options are [always|never|change]
```
* Specify email addresses

```yml
recipients:
  - email1@domain.com
  - email2@domain.com
```

* Complete travis config file

```yml
---
language: node_js
node_js:
  - "4.5.0"

sudo: false

notifications:
  email:
    on_success: change # only if status change from fail to success
    on_failure: always # if there is a fail
    recipients:
      - email1@domain.com
      - email2@domain.com

cache:
  directories:
    - node_modules

before_install:
  - export PATH=/usr/local/phantomjs-2.0.0/bin:$PATH
  - "npm config set spin false"
  - "npm install -g npm@^2"

install:
  - npm install -g bower
  - npm install
  - bower install

script:
  - ember test

before_deploy:
  - ember test -f 'Acceptance |'
deploy:
  skip_cleanup: true
  provider: script
  script: ember deploy testing --verbose
  on:
    branch: deployment
```

Now you can do this!

### GitHub resources:
* [Travis documentation](https://docs.travis-ci.com/user/notifications#Email-notifications)

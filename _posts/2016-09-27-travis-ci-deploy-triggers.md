---
layout: post
title: Travis-ci - deployment triggers
description: "Deploy your code only for specified branch and all tests are passing"
modified: 2016-09-26T05:35:00-04:00
tags: [ember-cli@v1.13.14, emberjs, ember-cli-deploy, github pages, travis-ci, triggers, continuous deployment]
---

### Description
We need to deploy our Emberjs application when:

* code is pushed/merged into **deployment** branch.
* all acceptance tests succeed.

### End Goal

```yml
before_deploy:
  - ember test -f 'Acceptance |'
deploy:
  skip_cleanup: true
  provider: script
  script: ember deploy testing --verbose
  on:
    branch: deployment
```

### Step by step

* Setup deployment trigger

```yml
deploy:
  on:
    branch: deployment
```

* Run the acceptance tests

```yml
before_deploy:
  - ember test -s -f 'Acceptance |'
```

* Add the deployment command

```yml
deploy:
  provider: script
  script: ember deploy testing --verbose
```

* Complete travis config file

```yml
---
language: node_js
node_js:
  - "4.5.0"

sudo: false

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
  - npm test

before_deploy:
  - ember test -s -f 'Acceptance |'
deploy:
  skip_cleanup: true
  provider: script
  script: ember deploy testing --verbose
  on:
    branch: deployment
```

Now you can do this!

### GitHub resources:
* [Travis config file](http://nshimiye.com/tutorial-ember-cli-1.13.14/tests/?testId=6c41b476)

<!-- {% gist mmistakes/6589546 %} -->

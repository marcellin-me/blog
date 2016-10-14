---
layout: post
title: App Deployment - deploy different index files
description: "Sometimes you want to deploy your app along with tracking code that run only on production server, but not during development"
modified: 2016-10-11T05:35:00-04:00
tags: [ember-cli@v1.13.14, emberjs, embere-cli-deloy, deployment, Google analytics, configuration, travis-ci]
---

### Description
We want to deploy an Ember app that uses google analytics tracking script.

* Enable it for production deployments
* Disable it during development

### End Goal
<iframe width="700" height="150" src="//nshimiye.com/tutorial-ember-cli-1.13.14/#/knowledge/whois" ></iframe>

### Step by step

* Create a production deployment folder

```sh
mkdir -p .deployment/production 
```

* Add the custom index file that contains Google analytics script

```html
<!-- .deployment/production/index.html -->
<script type="text/javascript">
  window.ga=window.ga||function(){(ga.q=ga.q||[]).push(arguments)};ga.l=+new Date;
  ga('create', 'UA-XXXXX-Y', 'auto');
  ga('send', 'pageview');
</script>
<script async src='https://www.google-analytics.com/analytics.js'></script>
```

* Make sure Google analytics tracks all pages

```javascript
// .deployment/production/router.js
Router.reopen({
  notifyGoogleAnalytics: function() {
    return ga('send', 'pageview', {
        'page': this.get('url'),
        'title': this.get('url')
      });
  }.on('didTransition')
});
```

* Add deployment commands in travis configuration file
  * copy index file
  * add google analytics code to the Router

```yml
before_deploy:
  - cp -rf .deployment/production/index.html app/
  # append content of ".deployment/production/router.js" to "app/router.js"
  - cat app/router.js > app/router.tmp.js
  - cat app/router.tmp.js .deployment/production/router.js > app/router.js
```

Now if you **deploy** your app using travis, it will have google analytics enabled,
but when you run it **locally**, you won't have to worry about messing up your analytics data!

### GitHub resources:
* [Google analytics](https://developers.google.com/analytics/devguides/collection/analyticsjs/)
* [Google analytics in Emberjs app](https://guides.emberjs.com/v1.10.0/cookbook/helpers_and_components/adding_google_analytics_tracking/)
* [Code for the Example App](https://fuse-mars.github.io/tutorial-ember-cli-1.13.14)

<!-- {% gist mmistakes/6589546 %} -->

---
layout: post
title: Testable Redirect Logic
description: "Implement an Ember utility function that provides a way to make internal or external transition"
modified: 2017-09-03T21:33:56+05:45
tags: [ember-cli@v2.14.2, Emberjs, Ember, Ember-cli-mirage, Utility Function, utils, Testing, Redirect, External Urls, Absolute Urls ]
---

### Description
We want to be able to write acceptance test for our Ember app that allow people to navigate to external websites as well as internal pages.
* Ability to ensure external redirect
  * As of now, I have not found a way to test logic that involves external redirect (i.e. call to `window.location.replace ...`)
* Ability to ensure internal redirect

### End Goal

```javascript
// app/utils/build-transition.js
export default function buildTransition(route, input) {
  if (isValidLink(input)) {
    return { run: () => window.location.replace(input), valid: true };
  } else if(isValidRoute(input)) {
    return { run: () => route.transitionTo(input), valid: true };
  } else {
    return { run: () => { throw new Error(input) }, valid: false };
  }
}
```

### Step by step

* Create the application and call it `Local`

```sh
# * **Local** allows people to find restaurants that offer local food and drinks(ex: yak or rice wine in Nepal)
# * User can view description and offered local refreshments of each found restaurant.
# * User can view menu on the restaurant's website `External transition`
# * For those restaurants that do not have a website, User can view menu on restaurant's page `Internal transition`

# we use node v8.4.0, npm 5.3.0, and ember-cli 2.14.2
ember new local && cd local
```

* Install dependancies

```sh
# we use ember-cli-mirage for backend simulation
ember install ember-cli-mirage
```

* Run the newly create app

```sh
ember start
# you should see a running app by visiting http://localhost:4200
```

* Create necessary routes

```sh
# we use ember-cli-mirage for backend simulation
ember g route restaurants
ember g route restaurants/index # show list of found restaurants
ember g route restaurants/restaurant # show menu of the restaurant
```

* Create `build-transition` utility function

```sh
ember g util build-transition
```

* Add logic to the `build-transition` utility function

```javascript
// our utility function allows us to
// 1. visit external url if user provides valid url
// 2. visit a page in our app if user provides a valid route's path name
// app/utils/build-transition.js
// ... check repo for implementation of isValidLink and isValidRoute
export default function buildTransition(route, input) {
  if (isValidLink(input)) {
    return { run: () => window.location.replace(input), valid: true };
  } else if(isValidRoute(input)) {
    return { run: () => route.transitionTo(input), valid: true };
  } else {
    return { run: () => {throw new Error(input)}, valid: false };
  }
}
```

* Write a unit test for `build-transition` function

```javascript
// * NOTE that we are not calling run, but instead checking to see what would get executed if we call it.
// tests/unit/utils/build-transition.js
// ...
test('it calls window location function for external links', function(assert) {
        let link = 'https://example.com/menu.html';

        let result = buildTransition(link);
        assert.ok(result.valid);
        assert.ok(!result.run.toString().includes('transitionTo'));
        assert.ok(result.run.toString().includes('window.location'));
});
test('it calls transitionTo function for internal links/routes', function(assert) {
        let link = 'application';  

        let result = buildTransition(link);
        assert.ok(result.valid);
        assert.ok(!result.run.toString().includes('window.location'));
        assert.ok(result.run.toString().includes('transitionTo'));
});
test('it calls error function for invalid links/routes', function(assert) {
        let link = 'invalid.route';

        let result = buildTransition(link);
        assert.ok(!result.valid);
        assert.ok(!result.run.toString().includes('window.location'));
        assert.ok(!result.run.toString().includes('transitionTo'));
        assert.ok(result.run.toString().includes('error'));
});
```

* Run unit test for `build-transition` function

```sh
ember test
```

* Use the `build-transition` function inside `restaurants/index` route

```javascript
// app/routes/restaurants/index.js
// ...
  buildTransition(menuLink).run();
// ...
```

* Run the app to make sure all changes have taken effect

```sh
# do this if you have stopped your app
ember start
# you should see a running app by visiting http://localhost:4200
```

Now you can do this!

### Resources:
* [Local Demo](https://marcellin.me/apps/local/)
* [Tasted Github](https://github.com/marcellin-me/local)
* [Ember Redirection](https://guides.emberjs.com/v2.14.0/routing/redirection/)

### use cases

* Writing Acceptance test for **Signup with Google** feature

<!-- {% gist mmistakes/6589546 %} -->

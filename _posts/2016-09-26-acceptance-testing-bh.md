---
layout: post
title: Acceptance testing - button hover
description: "Acceptance test to simulate the display of input helpful info, when user hover on top of the ifno button"
modified: 2016-09-26T05:35:00-04:00
tags: [ember-cli@v1.13.14, emberjs, JavaScript, acceptance testing]
---

### Description
We have a search box, a text on top of it, and a question mark to provide useful info in case a user gets confused.

The information is shown when the user hover over this **question mark**

### End Goal
<iframe width="500" height="300" src="//nshimiye.com/tutorial-ember-cli-1.13.14/#/search" frameborder="0"></iframe>

### Step by step

* create the acceptance test

```sh
# terminal
ember g acceptance-test show-searchinput-tooltip-on-hover
```

* writing the test logic:
  * go to search page

  ```javascript
  visit('/search');
  ```

  * make sure the question-mark icon exist

  ```javascript
  andThen(function() {
    assert.equal(find('.full-name .info-icon').length, 1,
                  'name info icon exist');
  });
  ```

  * hover over the "question-mark" icon in front of the Name input box

  ```javascript
  andThen(function() {
    let ic = find('.full-name .info-icon');
    ic.mouseenter();
  });
  ```

  * A message "Enter a partial or complete name" should show up

  ```javascript
  andThen(function() {
    let messageBox = find('.full-name .popover-content');
    assert.equal(messageBox.text().trim().search(message), 0,
                  'helpful message is shown');
  });
  ```

* Complete test

```javascript
import { test } from 'qunit';
import moduleForAcceptance from
    'app-test/tests/helpers/module-for-acceptance';

moduleForAcceptance('Acceptance | show searchinput tooltip on hover');

test('Hovering over the question-mark icon', function(assert) {
  visit('/search');
  let searchRouteName = 'search',
  message = 'Enter a partial or complete name';

  andThen(function() {
    assert.equal(currentRouteName(), searchRouteName,
                  'search page reached');
    assert.equal(find('.full-name .info-icon').length, 1,
                  'name info icon exist');
  });

  andThen(function() {
    let ic = find('.full-name .info-icon');
    ic.mouseenter();
  });

  andThen(function() {
    let messageBox = find('.full-name .popover-content');
    assert.equal(messageBox.length, 1, 'popover box is present');
    assert.equal(messageBox.text().trim().search(message), 0,
                  'helpful message is shown');
  });

  andThen(function() {
    let ic = find('.full-name .info-icon');
    ic.mouseleave();
  });

  andThen(function() {
    let messageBox = find('.full-name .popover-content');
    assert.equal(messageBox.length, 0, 'popover box is removed');
  });
});

```

Now you can do this!

### GitHub resources:
* [Product](https://fuse-mars.github.io/tutorial-ember-cli-1.13.14)
* [Testing](http://nshimiye.com/tutorial-ember-cli-1.13.14/tests/?testId=6c41b476)


<!-- {% gist mmistakes/6589546 %} -->

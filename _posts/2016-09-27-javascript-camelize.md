---
layout: post
title: JavaScript - Camelize
description: "Deploy your code only for specified branch and all tests are passing"
modified: 2016-09-26T05:35:00-04:00
tags: [JavaScript, function]
---

### Description
We want to join the word tokens of a phrase together, by capitalized each term's first word.

### End Goal

```javascript
function camelize(str) {
    return str
        .replace(/\s(.)/g, function($1) { return $1.toUpperCase(); })
        .replace(/\s/g, '')
        .replace(/\-(.)/g, function($1) { return $1.toUpperCase(); })
        .replace(/\-/g, '')
        .replace(/^(.)/, function($1) { return $1.toLowerCase(); });
}
```

### Step by step

* Capitalize each first letter of the word that follows a space

```javascript
.replace(/s(.)/g, function($1) { return $1.toUpperCase(); })
```

* Remove all spaces

```javascript
.replace(/\s/g, '')
```

* Capitalize each first letter of the word that follows a dash

```javascript
.replace(/\-(.)/g, function($1) { return $1.toUpperCase(); })
```

* Remove all dashes

```javascript
.replace(/\-/g, '')
```

* Make sure the first is lowercased

```javascript
.replace(/^(.)/, function($1) { return $1.toLowerCase(); });
```

Now you can do this!

### Resources:
* [camelize](http://www.definition-of.com/camelize)

### use cases

* Turn user input into bot commands: `camelize(userInput) === systemCommand`

<!-- {% gist mmistakes/6589546 %} -->

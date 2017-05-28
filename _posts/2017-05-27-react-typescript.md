---
layout: post
title: React with TypeScript
description: "Implement a React application using TypeScript"
modified: 2017-05-27T18:21:00-04:00
tags: [React, TypeScript, Web Development]
---

### Description
We want to clarify the type of information, each variable holds in our react app.
* To make sure each component is called with the right arguments
* So that a new developer can easily understand the code.

### End Goal

A site that helps us track different types of wine that we drink

<iframe width="700" height="250" src="https://marcellin.me/apps/tasted/" ></iframe>

### Step by step

* Install development package

```sh
# this package help us create and build the react application
npm install create-react-app
```

* Create the application and call it `Tasted`

```sh
# we use "react-scripts-ts" to enable TypeScript
# source: https://github.com/wmonk/create-react-app-typescript
create-react-app tasted --scripts-version=react-scripts-ts
```

* Run the newly create app

```sh
cd tasted
yarn start
# you should see a running app by visiting http://localhost:
```

* Create a form component for entering information

  * Define interfaces for both properties and state

```typescript
// src/components/tasted-wine-form.tsx
export interface TWPropsInterface {}
export interface TWStateInterface {
    value: string;
}
```

  * Define main class

```typescript
// src/components/tasted-wine-form.tsx
class TastedWineForm extends React.Component<TWPropsInterface, TWStateInterface> {
    constructor(props: TWPropsInterface) {
        super(props);
        this.state = { value: '' };

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleChange(event: React.ChangeEvent<HTMLInputElement>) {
        this.setState({ value: event.target.value });
    }

    handleSubmit(event: React.FormEvent<HTMLFormElement>) {
        alert('A name was submitted: ' + this.state.value);
        event.preventDefault();
    }

    render() {
        return (
            <form onSubmit={this.handleSubmit}>
                <label>
                    Name:
                    <input type="text" value={this.state.value} onChange={this.handleChange} />
                </label>
                <input type="submit" value="Submit" />
            </form>
        );
    }
}
```

* Create component to display entered information

  * Define interfaces for properties, state is ignored because we do not use it anywhere

```typescript
// src/components/tasted-wine.tsx
export interface WPropsInterface {
  wine: { name: string, cost: number, rating: number, note: string }
}
```

  * Define main class

```typescript
// src/components/tasted-wine.tsx
// @NOTE wine is the domain model
class TastedWine extends React.Component<WPropsInterface, null> {
    render() {
        return (
            <div>
                <div>
                    Name: <h1> {this.props.wine.name} </h1>
                </div>
                <div>
                    Cost: <span> {this.props.wine.cost} </span>
                </div>
                <div>
                    Rating: <span> {this.props.wine.rating} </span>
                </div>
                <div>
                    Note: {this.props.wine.note}
                </div>
            </div>
        );
    }
}
```

* Modify the app component to include the form and the display components

  * Define interfaces for both properties and state

```typescript
// src/App.tsx
export interface APropsInterface {}
export interface AStateInterface {
  wineList: Array<{ name: string, cost: number, rating: number, note: string }>;
}
```

  * Define main class

```typescript
// src/App.tsx
class App extends React.Component<APropsInterface, AStateInterface> {
  constructor(props: APropsInterface) {
    super(props);
    this.state = { wineList: [] };
  }

  render() {
    let TastedWineList = this.state.wineList.map(wine => <TastedWine wine={wine} />);
    return (
      <div className="App">
        <div className="tasted-form">
          <TastedWineForm />
        </div>
        <div className="App-intro">
          {TastedWineList}
        </div>
      </div>
    );
  }
}
```

* Run the app to make all changes have taken effect

```sh
yarn start
# you should see a running app by visiting http://localhost:
```

Now you can do this!

### Resources:
* [React](http://www.definition-of.com/camelize)
* [TypeScript](http://www.definition-of.com/camelize)
* [create-react-app](http://www.definition-of.com/camelize)
* [create-react-app-typescript](http://www.definition-of.com/camelize)

### use cases

* TypeScript is good for big JavaScript projects which are maintained by multiple developers
* React can be a good replacement for jQuery, it component based structure provides clean and readable code.

<!-- {% gist mmistakes/6589546 %} -->

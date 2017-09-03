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

```typescript
// * Define interfaces for both properties and state
// src/components/tasted-wine-form.tsx
export interface WineInterface {
    name: string; cost: number; rating: number; note: string;
}
export interface TWPropsInterface {
  saveRecord: (wine: WineInterface) => void;
}
export interface TWStateInterface {
    wine: WineInterface;
}
```

```typescript
// * Define main class
// src/components/tasted-wine-form.tsx
// top code omitted ...
class TastedWineForm extends React.Component<TWPropsInterface, TWStateInterface> {
  constructor(props: TWPropsInterface) {
      super(props);
      let wine: WineInterface = EMPTY_RECORD;
      this.state = { wine };

      this.handleChange = this.handleChange.bind(this);
      this.handleSubmit = this.handleSubmit.bind(this);
  }
  resetForm() {
      this.setState({ wine: EMPTY_RECORD });
  }

  handleChange(event: React.ChangeEvent<HTMLInputElement>) {
      const target = event.target;
      const value = target.value;
      const name = target.name;
      let wine = this.state.wine;
      wine = Object.assign(wine, { [name]: value });
      this.setState({ wine });
  }

    handleSubmit(event: React.FormEvent<HTMLFormElement>) {
        event.preventDefault();
        this.props.saveRecord(this.state.wine);
        this.resetForm();
    }

    render() {
        return (
            <form onSubmit={this.handleSubmit} className="form-inline">
            { /*
              @NOTE form content omitted
              check Github for complete version
              https://github.com/marcellin-me/tasted/blob/master/src/components/tasted-wine-form.tsx#L62-#L109
              */ }
            </form>
        );
    }
}
// bottom code omitted ...
```

* Create component to display entered information


```typescript
// * Define interfaces for properties, state is ignored because we do not use it anywhere
// src/components/tasted-wine.tsx
export interface WPropsInterface {
  wine: WineInterface
}
```


```typescript
// * Define main class
// src/components/tasted-wine.tsx
// @NOTE wine is the domain model
// top code omitted ...
class TastedWine extends React.Component<WPropsInterface, null> {
    render() {
        return (
            <div>
            { /*
              @NOTE div content omitted
              check Github for complete version
              https://github.com/marcellin-me/tasted/blob/master/src/components/tasted-wine.tsx#L15-#L25
              */ }
            </div>
        );
    }
}
// bottom code omitted ...
```

* Modify the app component to include the form and the display components

```typescript
// * Define interfaces for both properties and state
// src/App.tsx
export interface APropsInterface {}
export interface AStateInterface {
  wineList: Array<WineInterface>;
}
```

```typescript
// * Define main class
// src/App.tsx
// top code omitted ...
class App extends React.Component<APropsInterface, AStateInterface> {
  constructor(props: APropsInterface) {
    super(props);
    this.state = { wineList: [] };
    this.saveRecord = this.saveRecord.bind(this);

  }

  // @NOTE middle code omitted ...
  // check Github for complete version

  render() {
    let TastedWineList = this.state.wineList.map((wine, i) => <TastedWine key={i} wine={wine} />);
    return (
      <div className="App" >
        <div className="tasted-form">
          <TastedWineForm saveRecord={this.saveRecord} />
        </div>
        <div className="App-intro">
          {TastedWineList}
        </div>
      </div>
    );
  }
}
// bottom code omitted ...
```

* Run the app to make sure all changes have taken effect

```sh
yarn start
# you should see a running app by visiting http://localhost:
```

Now you can do this!

### Resources:
* [Tasted Demo](https://marcellin.me/apps/tasted/)
* [Tasted Github](https://github.com/marcellin-me/tasted)
* [React](https://facebook.github.io/react/)
* [TypeScript](https://www.typescriptlang.org/)
* [create-react-app](https://github.com/facebookincubator/create-react-app)
* [create-react-app-typescript](https://github.com/wmonk/create-react-app-typescript)

### use cases

* TypeScript is good for big JavaScript projects which are maintained by multiple developers
* React can be a good replacement for jQuery, its component based structure provides clean and readable code.

<!-- {% gist mmistakes/6589546 %} -->

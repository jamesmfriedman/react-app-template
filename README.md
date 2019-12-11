This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.<br />
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

### `npm dev`

An alias for `npm start`

### `npm test`

Launches the test runner in the interactive watch mode.<br />
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.<br />
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.<br />

### `npm run build:docker`

Creates a docker image with a thin NGINX server ready to serve up the app.

- In package.json, make sure you update the tag name which is defaulted to project/name.
- You can run the image like so
  - `docker run -e PORT=3000 -p 3000:3000 project/name`
  - Have have to specify the port for NGINX to run on
  - You must then expose that port through docker

You can specify runtime configuration variables on the image. These will be available to the frontend app under window.process.env. Specify the CONFIG_VARS environment variable set to the variables you would like to pass to the frontend.

`docker run -e CONFIG_VARS='MY_VAR,ANOTHER_VAR' -e MY_VAR="hello" -e ANOTHER_VAR="world" -e PORT=3000 -p 3000:3000 project/name`

window.process.env will now be set to {MY_VAR: 'hello', ANOTHER_VAR: 'world'}

Note that the above ONLY happens when running in production from the docker container. During development, there is an empty object that is passed. Create react app uses a .env file for managing build time configuration. You can put environment variables in there, but you will be responsible for merging them together at runtime. A contrived example.

```js
const myEnv = {
  ...process.env, // from webpack
  ...window.process.env // from docker
}
```

The above will result in a environment where runtime configuration overrides the build.

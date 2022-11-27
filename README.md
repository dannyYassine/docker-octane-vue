# docker-octane-vue

Simple skeleton in order to quickly start a new project with the following technologies with docker-compose:

* laravel with octane (swoole)
* vue (with typescript)
* postgres

<br>

<table>
  <tr>
    <td valign="top">
<div style="width: 150px; height: 75px;">
        <img width="150" height="75" src="https://laravel.com/img/logomark.min.svg">
    </div>
</td>
    <td valign="top">
<div style="width: 150px; height: 75px;">
        <img width="90" height="75" src="https://avatars.githubusercontent.com/u/6128107?s=200&v=4">
    </div>
    <td valign="top">
<div style="width: 150px; height: 75px;">
        <img width="100" height="75" src="https://www.postgresql.org/media/img/about/press/elephant.png">
    </div>
</td>
  </tr>
</table>

Technologies:
* [laravel](https://laravel.com/)
* [laravel octane](https://laravel.com/docs/9.x/octane#main-content)
* [vue](https://vuejs.org/)
* [typescript](https://www.typescriptlang.org/)
* [postgres](https://www.postgresql.org/)
* [gitpod](https://www.gitpod.io/)
* [supabase](https://supabase.com/)

## Develoment

* Ready to use docker-compose.yml
* CDE using [Gitpod](https://www.gitpod.io/)

## Structure

Each technology is containerized for easy development

    * Backend: laravel-octane with swoole
    * Frontend: vue client
    * Data: database (postgres)

## Auto refresh

While the containers are running, the backend and frontend will auto refresh when making changes to the application code. No need to rebuild the containers.

# Getting Started

## Using docker-compose locally

##### Build the containers

```bash
make build
```

##### Start developing

```bash
make dev
```

##### While the containers are running, migrate the database

```bash
make migrate
```

## Using gitpod

#### Workspace
Simply start the workspace with this project, eveyrthing is configured in .gitpod.yml

# Deploy options

The options below are free, great for getting things started, and very easy to scale up with their paid plans.

## Backend

* Render https://render.com/docs/web-services

## Database

* Supabase https://supabase.com

## Frontend

* Firebase https://firebase.google.com/docs/hosting
* Render https://render.com/docs/static-sites

## Examples

### Deploying to render

while using `render.yaml` https://render.com/docs/blueprint-spec

```
# A web service
  - type: web
    name: api
    env: docker
    dockerfilePath: ./deploy/php.api.dockerfile # optional
    dockerContext: ./api # optional
    
# A background worker that consumes a queue
  - type: worker
    name: queue
    env: docker
    dockerfilePath: ./deploy/php.queue.dockerfile # optional
    dockerContext: ./api # optional
    
# A static site for the vue app
  - type: web
    name: docker-octane-vue-client
    env: static
    branch: master
    buildCommand: cd client && yarn && yarn build
    staticPublishPath: ./client/dist
    routes:
      - type: rewrite
        source: /*
        destination: /index.html
```

## PhpUnit on VsCode

#### Update settings.json

update the key in `better-phpunit.docker.paths` to the local path of this project on your machine.
```json
"better-phpunit.docker.paths": {
     "<project_path_on_your_computer>/api": "/usr/src/api"
},
```

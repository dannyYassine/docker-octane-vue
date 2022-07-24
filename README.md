# docker-octane-vue

Simple skeleton in order to quickly start a new project with the following technologies:

* laravel-octane (swoole)
* vue
* mysql/mariadb

<br>
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
        <img width="150" height="75" src="https://vuejs.org/images/logo.svg">
    </div>
    <td valign="top">
<div style="width: 150px; height: 75px;">
        <img width="150" height="75" src="https://mariadb.org/wp-content/themes/twentynineteen-child/icons/mariadb_org_rgb_h.svg">
    </div>
</td>
  </tr>
</table>

## Structure

Each technology is containerized for easy development

    * Backend: laravel-octane with swoole
    * Frontend: vue client
    * Data: database (mysql or mariadb)

## Auto refresh

While the containers are running, the backend and frontend will auto refresh when making changes to the application code. No need to rebuild the containers.

## Getting Started

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

## PhpUnit on VsCode

#### Update settings.json

update the key in `better-phpunit.docker.paths` to the local path of this project on your machine.
```json
"better-phpunit.docker.paths": {
     "<project_path_on_your_computer>/api": "/usr/src/api"
},
```

# Deploy options

The options below are free, great for getting things started, and very easy to scale up with their paid plans.

## Backend

* Heroku https://devcenter.heroku.com/articles/build-docker-images-heroku-yml
* Render https://render.com/docs/web-services

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
```

### Deploying to heroku

ref: https://www.youtube.com/watch?v=4axmcEZTE7M

* Create (if not there) a `heroku.yml` file at the root of the project with:
```shell
build:
  docker:
    web: deploy/php.api.dockerfile
    worker: deploy/php.worker.dockerfiler
```
* Create a pipeline on heroku.
* Modify the stack to `container` for the pipeline:
```bash
heroku stack:set container --app <app-name>
```
* Create a staging application
* Add a config var for `APP_KEY`
* Deploy with branch

##### Under a paid plan

* for zero downtime, set [preboot](https://devcenter.heroku.com/articles/preboot):
```bash
heroku features:enable preboot -a <app>
```
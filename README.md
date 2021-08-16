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

    make build

##### Start developing

    make dev

##### While the containers are running, migrate the database

    make migrate

## Deploying to heroku

* Create a `heroku.yml` file at the root of the project with:
```shell
build:
  docker:
    web: php.deploy.dockerfile
```
* Create a pipeline on heroku.
* Modify the stack to `container` for the pipeline:
```bash
    heroku stack:set container --app <app-name>
```
* Create a staging application
* Add a config var for `APP_KEY`
* Deploy with branch
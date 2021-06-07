# docker-octane-vue

Simple skeleton in order to quickly start a new project with the following technologies:

* laravel-octane (swoole)
* vue
* mysql/mariadb

<br>
<br>

<div style="display: flex;">
    <div style="width: 150px; height: 75px;">
        <img style="height: 100%; width: auto" src="https://laravel.com/img/logomark.min.svg">
    </div>
    <div style="width: 150px; height: 75px;">
        <img style="width: 150px; height: 75px;" src="https://vuejs.org/images/logo.svg">
    </div>
    <div style="width: 150px; height: 75px;">
        <img style="width: 150px; height: 75px;" src="https://mariadb.org/wp-content/themes/twentynineteen-child/icons/mariadb_org_rgb_h.svg">
    </div>
</div>

## Structure

Each technology is containerized for easy development

    * Backend: laravel-octane with swoole
    * Frontend: vue client
    * Data: database (mysql or mariadb)

## Auto refresh

While the containers are running, the backend and frontend will auto refresh when making changes to the application code.

## Getting Started

##### Build the containers

    make build

##### Start developing

    make dev

##### While the containers are running, migrate the database

    make migrate

# TypeScript HAF App Template

Sample HAF indexer and API server. Indexes Hive from a starting block number for relevant `insert_operation_here` operations using the HAF app sync algorithm.

## How To Use This Template

### HAF App Names

Replace every instance of `myhaf_app` with your actual HAF app name in:
* All SQL files in [src/sql](https://github.com/techcoderx/typescript-haf-app-template/tree/main/src/sql) folder
* [src/constants.ts](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/constants.ts)
* [.env.example](https://github.com/techcoderx/typescript-haf-app-template/blob/main/.env.example)
* [scripts/block_processing_healthcheck.sh](https://github.com/techcoderx/typescript-haf-app-template/blob/main/scripts/block_processing_healthcheck.sh)
* This README file

Replace every instance of `myhaf_api` with your actual HAF app API schema name in:
* [src/sql/create_apis.sql](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/sql/create_apis.sql)
* [src/sql/drop_db.sql](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/sql/drop_db.sql)
* [src/server.ts](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/server.ts)
* PostgREST start scripts in [scripts](https://github.com/techcoderx/typescript-haf-app-template/tree/main/scripts) folder (including docker)
* [docker/compose.yml](https://github.com/techcoderx/typescript-haf-app-template/blob/main/docker/compose.yml)
* This README file

Replace every instance of `myhaf_owner` with your actual HAF app owner role in:
* [src/sql/create_apis.sql](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/sql/create_apis.sql)
* [src/sql/builtin_roles.sql](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/sql/builtin_roles.sql)
* [scripts/block_processing_healthcheck.sh](https://github.com/techcoderx/typescript-haf-app-template/blob/main/scripts/block_processing_healthcheck.sh)
* [Dockerfile](https://github.com/techcoderx/typescript-haf-app-template/blob/main/Dockerfile)
* [docker/compose.yml](https://github.com/techcoderx/typescript-haf-app-template/blob/main/docker/compose.yml)
* This README file

Replace every instance of `myhaf_user` with your actual HAF app API user in:
* [src/sql/create_apis.sql](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/sql/create_apis.sql)
* PostgREST start scripts in [scripts](https://github.com/techcoderx/typescript-haf-app-template/tree/main/scripts) folder (including docker)
* [docker/compose.yml](https://github.com/techcoderx/typescript-haf-app-template/blob/main/docker/compose.yml)
* This README file

Replace the environment variable prefix `HAFAPP` in:
* [.env.example](https://github.com/techcoderx/typescript-haf-app-template/blob/main/.env.example)
* [Dockerfile](https://github.com/techcoderx/typescript-haf-app-template/blob/main/Dockerfile)
* [config.ts](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/config.ts)
* [scripts/docker_entrypoint.sh](https://github.com/techcoderx/typescript-haf-app-template/blob/main/scripts/docker_entrypoint.sh)
* This README file

### Table Definitions

Write the PostgreSQL table definitions in [src/sql/create_tables.sql](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/sql/create_tables.sql) file. All registered tables (forking app) must contain the column `hive_rowid` as shown in the example table. List the registered table names (without schema name) in [src/schema.ts](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/schema.ts), under `HAF_TABLES` array.

Then define foreign key definitions in the same file under `HAF_FKS` object, and list those definitions that has to be dropped when uninstalling the HAF app in [src/sql/drop_db.sql](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/sql/drop_db.sql).

### Function Definitions

An example PL/pgSQL function for fetching `custom_json` operations has been defined in [src/sql/create_functions.sql](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/sql/create_functions.sql). Adapt the function to your desired set of operation IDs by referring to the operations list linked in the file.

Define all operation processing methods in the same file.

### API Definitions

Define PostgREST API definitions in [src/sql/create_apis.sql](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/sql/create_apis.sql) file under the HAF app API schema.

### Config Definitions

Define additional configuration required in [config.js](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/config.ts) file. All constants are to be defined in [constants.ts](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/config.ts).

### Operation Validation and Execution

Include the required validation for operations fetched from `myhaf_app.enum_op()` in [src/processor.ts](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/processor.ts) file in `validateAndParse()` method. Execute the operations by calling the operation processing PL/pgSQL methods in `process()` within the same file.

### State Providers

Import the required state providers in [src/schema.ts](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/schema.ts). The `accounts` state provider has been [included](https://github.com/techcoderx/typescript-haf-app-template/blob/main/src/schema.ts#L38-L40) as an example.

### Docker

A sample [Dockerfile](https://github.com/techcoderx/typescript-haf-app-template/blob/main/Dockerfile) and [compose.yml](https://github.com/techcoderx/typescript-haf-app-template/blob/main/docker/compose.yml) is supplied in this template.

* Replace all instances of `myhaf_owner` with your app user.
* Replace the image names in [scripts/build_instance.sh](https://github.com/techcoderx/typescript-haf-app-template/blob/main/scripts/build_instance.sh) and [docker/compose.yml](https://github.com/techcoderx/typescript-haf-app-template/blob/main/docker/compose.yml).
* Replace compose service and profile names in [docker/compose.yml](https://github.com/techcoderx/typescript-haf-app-template/blob/main/docker/compose.yml) and this README file.

### Everything Else

* Replace the LICENSE file with your desired license.
* Replace all values in package.json with actual names and URLs.
* Delete this section of the README file and update the HAF app description above.

## Required Dependencies

* Synced [HAF](https://gitlab.syncad.com/hive/haf) node, ideally using [`haf_api_node`](https://gitlab.syncad.com/hive/haf_api_node) compose

## Docker Setup

This assumes HAF is running through [`haf_api_node`](https://gitlab.syncad.com/hive/haf_api_node).

Clone this repository, then add the following in the `.env` file in `haf_api_node` directory:

```env
COMPOSE_FILE="${COMPOSE_FILE}:/path/to/myhaf/repo/docker/compose.yml"
HAFAPP_VERSION=latest
```

Build the Docker image:

```sh
cd /path/to/myhaf/repo
./scripts/build_instance.sh
```

Run the HAF app sync:
```sh
docker compose up -d myhaf-app-block-processing
```

Run the PostgREST server:
```sh
docker compose up -d myhaf-app-postgrest
```

You may need to add the following entries to `PG_ACCESS` in `haf_base.yml`:
```
host    haf_block_log    haf_admin     ${COMPOSE_PROJECT_NAME}-myhaf-install-1.${NETWORK_NAME}            trust\n
host    haf_block_log    myhaf_owner   ${COMPOSE_PROJECT_NAME}-myhaf-install-1.${NETWORK_NAME}            trust\n
host    haf_block_log    myhaf_owner   ${COMPOSE_PROJECT_NAME}-myhaf-block-processing-1.${NETWORK_NAME}   trust\n
host    haf_block_log    myhaf_user    ${COMPOSE_PROJECT_NAME}-myhaf-postgrest-1.${NETWORK_NAME}          trust\n
host    haf_block_log    haf_admin     ${COMPOSE_PROJECT_NAME}-myhaf-uninstall-1.${NETWORK_NAME}          trust\n
```

## Setup

### PostgreSQL Roles
```bash
psql -f src/sql/builtin_roles.sql haf_block_log
```

### PostgREST Installation
```bash
./scripts/postgrest_install.sh
```

### PostgREST API methods
```bash
psql -f src/sql/create_apis.sql block_log
```

## Installation
```
git clone https://github.com/techcoderx/typescript-haf-app-template
cd typescript-haf-app-template
npm i
```

## Compile
```
npm run compile
```

## Sync
```bash
npm start
```

## Start PostgREST server
```bash
./scripts/postgrest_start.sh postgres://myhaf_user:<myhaf_user_password>@localhost:5432/block_log <server_port>
```

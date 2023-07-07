-- Drop all FK constraints
ALTER TABLE myhaf_app.table_name DROP CONSTRAINT IF EXISTS table_fk_name;

-- Drop all state providers
SELECT hive.app_state_provider_drop_all('myhaf_app');

-- Remove context and drop schema
SELECT hive.app_remove_context('myhaf_app');
DROP SCHEMA IF EXISTS myhaf_app CASCADE;
DROP SCHEMA IF EXISTS myhaf_api CASCADE;
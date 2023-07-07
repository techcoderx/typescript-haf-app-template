DROP SCHEMA IF EXISTS myhaf_api CASCADE;
CREATE SCHEMA IF NOT EXISTS myhaf_api AUTHORIZATION myhaf_app;
GRANT USAGE ON SCHEMA myhaf_api TO myhaf_user;
GRANT USAGE ON SCHEMA myhaf_app TO myhaf_user;
GRANT SELECT ON ALL TABLES IN SCHEMA myhaf_api TO myhaf_user;
GRANT SELECT ON ALL TABLES IN SCHEMA myhaf_app TO myhaf_user;
GRANT SELECT ON TABLE hive.myhaf_app_accounts TO myhaf_user;

-- GET /
CREATE OR REPLACE FUNCTION myhaf_api.home()
RETURNS jsonb
AS
$function$
DECLARE
    _last_processed_block INTEGER;
    _db_version INTEGER;
BEGIN
    SELECT last_processed_block, db_version INTO _last_processed_block, _db_version FROM myhaf_app.state;
    RETURN jsonb_build_object(
        'last_processed_block', _last_processed_block,
        'db_version', _db_version
    );
END
$function$
LANGUAGE plpgsql STABLE;

-- The rest of PostgREST API methods goes here
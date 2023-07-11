DROP TYPE IF EXISTS myhaf_app.op_type CASCADE;
CREATE TYPE myhaf_app.op_type AS (
    id BIGINT,
    block_num INT,
    body TEXT
);

CREATE OR REPLACE FUNCTION myhaf_app.enum_op(IN _first_block INT, IN _last_block INT)
RETURNS SETOF myhaf_app.op_type
AS
$function$
BEGIN
    -- Adapt to desired operation type id
    -- https://gitlab.syncad.com/hive/hive/-/blob/master/libraries/protocol/include/hive/protocol/operations.hpp
    RETURN QUERY
        SELECT
            id,
            block_num,
            body::TEXT
        FROM hive.myhaf_app_operations_view
        WHERE block_num >= _first_block AND block_num <= _last_block AND op_type_id=18
        ORDER BY block_num, id;
END
$function$
LANGUAGE plpgsql STABLE;

DROP TYPE IF EXISTS myhaf_app.block_type CASCADE;
CREATE TYPE myhaf_app.block_type AS (
    num INTEGER,
    created_at TIMESTAMP
);

CREATE OR REPLACE FUNCTION myhaf_app.enum_block(IN _first_block INT, IN _last_block INT)
RETURNS SETOF myhaf_app.block_type
AS
$function$
BEGIN
    -- Fetch block headers
    RETURN QUERY
        SELECT
            num,
            created_at
        FROM hive.myhaf_app_blocks_view
        WHERE num >= _first_block AND num <= _last_block
        ORDER BY num;
END
$function$
LANGUAGE plpgsql STABLE;

-- Process transactions
-- Example code here shows querying user id by account name from accounts state provider
CREATE OR REPLACE FUNCTION myhaf_app.process_tx(_username VARCHAR)
RETURNS void
AS
$function$
DECLARE
    _hive_user_id INTEGER = NULL;
BEGIN
    SELECT id INTO _hive_user_id FROM hive.myhaf_app_accounts WHERE name=_username;
    IF _hive_user_id IS NULL THEN
        RAISE EXCEPTION 'Could not process non-existent user %', _username;
    END IF;
END
$function$
LANGUAGE plpgsql VOLATILE;
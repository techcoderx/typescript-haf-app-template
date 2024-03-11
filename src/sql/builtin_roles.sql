-- Role involved into data schema creation.
DO $$
BEGIN
  CREATE ROLE myhaf_owner WITH LOGIN INHERIT IN ROLE hive_applications_owner_group;
EXCEPTION WHEN duplicate_object THEN RAISE NOTICE '%, skipping', SQLERRM USING ERRCODE = SQLSTATE;
END
$$;

DO $$
BEGIN
  CREATE ROLE myhaf_user WITH LOGIN INHERIT IN ROLE hive_applications_group;  
EXCEPTION WHEN duplicate_object THEN RAISE NOTICE '%, skipping', SQLERRM USING ERRCODE = SQLSTATE;
END
$$;

--- Allow to create schemas
GRANT myhaf_owner TO haf_admin;
GRANT myhaf_user TO myhaf_owner;
#! /bin/sh

set -e

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1; pwd -P )"

print_help () {
    cat <<EOF
Usage: $0 [OPTION[=VALUE]]...

Uninstalls VSC-HAF app.
OPTIONS:
    --host=VALUE             Allows to specify a PostgreSQL host location (defaults to localhost)
    --port=NUMBER            Allows to specify a PostgreSQL operating port (defaults to 5432)
    --user=VALUE             Allows to specify a PostgreSQL user (defaults to haf_admin)
    --url=URL                Allows to specify a PostgreSQL URL (empty by default, overrides options above)
    --help,-h,-?             Displays this help message
EOF
}

POSTGRES_USER=${POSTGRES_USER:-"haf_admin"}
POSTGRES_HOST=${POSTGRES_HOST:-"localhost"}
POSTGRES_PORT=${POSTGRES_PORT:-5432}
POSTGRES_URL=${POSTGRES_URL:-""}

while [ $# -gt 0 ]; do
  case "$1" in
    --host=*)
        POSTGRES_HOST="${1#*=}"
        ;;
    --port=*)
        POSTGRES_PORT="${1#*=}"
        ;;
    --user=*)
        POSTGRES_USER="${1#*=}"
        ;;
    --postgres-url=*)
        POSTGRES_URL="${1#*=}"
        ;;
    --help|-h|-?)
        print_help
        exit 0
        ;;
    -*)
        echo "ERROR: '$1' is not a valid option"
        echo
        print_help
        exit 1
        ;;
    *)
        echo "ERROR: '$1' is not a valid argument"
        echo
        print_help
        exit 2
        ;;
    esac
    shift
done

POSTGRES_ACCESS_ADMIN=${POSTGRES_URL:-"postgresql://$POSTGRES_USER@$POSTGRES_HOST:$POSTGRES_PORT/haf_block_log"}
echo "Uninstalling HAF app..."
echo "Connection URL: ${POSTGRES_ACCESS_ADMIN}"
psql "$POSTGRES_ACCESS_ADMIN" -v "ON_ERROR_STOP=OFF" -f "$SCRIPTPATH/../src/sql/drop_db.sql"

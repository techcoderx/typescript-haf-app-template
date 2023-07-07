import yargs from 'yargs'
import * as dotenv from 'dotenv'

dotenv.config()
const { argv } = yargs(process.argv)

let config = {
    postgres_url: 'postgres://username:password@127.0.0.1:5432/block_log',

    // non-postgrest api server port
    http_host: '127.0.0.1',
    http_port: 3010,

    // logging
    log_level: 'info'
}

// Config overwrites through CLI args or environment vars
for (let c in config)
    config[c] = argv[c] || process.env['HAFAPP_' + c.toUpperCase()] || config[c]

export default config
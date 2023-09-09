import yargs from 'yargs'
import * as dotenv from 'dotenv'

dotenv.config()
const config = yargs(process.argv)
    .env('HAFAPP')
    .options({
        postgresUrl: {
            type: 'string',
            default: 'postgres://username:password@127.0.0.1:5432/block_log'
        },
        httpHost: {
            type: 'string',
            default: '127.0.0.1'
        },
        httpPort: {
            type: 'number',
            default: 3010
        },
        logLevel: {
            type: 'string',
            default: 'info'
        }
    })
    .parseSync()

export default config
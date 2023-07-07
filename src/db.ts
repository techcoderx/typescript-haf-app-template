import pg from 'pg'
import config from './config.js'
import logger from './logger.js'

const client = new pg.Client({ connectionString: config.postgres_url })

const db = {
    init: async () => {
        await client.connect()
        logger.info('Connected to database',config.postgres_url)
    },
    disconnect: async () => {
        await client.end()
        logger.info('Disconnected from database')
    },
    client: client
}

export default db
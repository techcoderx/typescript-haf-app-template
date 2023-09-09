import pg from 'pg'
import config from './config.js'
import logger from './logger.js'

const client = new pg.Client({ connectionString: config.postgresUrl })

const db = {
    init: async () => {
        await client.connect()
        logger.info('Connected to database',config.postgresUrl)
    },
    disconnect: async () => {
        await client.end()
        logger.info('Disconnected from database')
    },
    client: client
}

export default db
import { APP_CONTEXT } from './constants.js'
import logger from './logger.js'
import db from './db.js'
import { AppNextBlock } from './processor_types.js'

const context = {
    exists: async () => {
        let ctxExists = await db.client.query('SELECT hive.app_context_exists($1);',[APP_CONTEXT])
        return ctxExists.rows[0].app_context_exists
    },
    create: async () => {
        if (await context.exists())
            return logger.info('App context already exists, skipping app context creation')
        await db.client.query('SELECT hive.app_create_context($1,$2);',[APP_CONTEXT,false])
        logger.info('Created app context',APP_CONTEXT)
    },
    attach: async () => {
        let isAttached = await db.client.query('SELECT hive.app_context_is_attached($1);',[APP_CONTEXT])
        if (!isAttached.rows[0].app_context_is_attached) {
            logger.info('Attaching app context...')
            await db.client.query('CALL hive.appproc_context_attach($1);',[APP_CONTEXT])
            logger.info('App context attached successfully')
        } else
            logger.info('App context already attached, skipping')
    },
    detach: async () => {
        let isAttached = await db.client.query('SELECT hive.app_context_is_attached($1);',[APP_CONTEXT])
        if (isAttached.rows[0].app_context_is_attached) {
            logger.info('Detaching app context...')
            await db.client.query('SELECT hive.app_context_detach($1);',[APP_CONTEXT])
            logger.info('App context detached successfully')
        } else
            logger.info('App context already detached, skipping')
    },
    nextBlocks: async (): Promise<AppNextBlock> => {
        return (await db.client.query<AppNextBlock>('SELECT * FROM hive.app_next_block($1);',[APP_CONTEXT])).rows[0]
    }
}

export default context
import express from 'express'
import cors from 'cors'
import logger from './logger.js'
import config from './config.js'
import db from './db.js'

await db.init()
const app = express()
app.use(cors())

// init enums (if any) here

app.get('/', async (req,res) => {
    let query = await db.client.query('SELECT myhaf_api.home();')
    if (query.rowCount === 0)
        return res.status(503).send({ error: 'no state found' })
    res.send(query.rows[0].home)
})

const server = app.listen(config.http_port,config.http_host,() => {
    logger.info(`HAF app server listening to ${config.http_host+':'+config.http_port}`)
})

let terminating = false
const handleExit = async () => {
    if (terminating) return
    terminating = true
    process.stdout.write('\r')
    logger.info('Received SIGINT')
    await db.disconnect()
    server.close()
    logger.info('HLS server closed successfully')
    process.exit(0)
}

process.on('SIGINT', handleExit)
process.on('SIGTERM', handleExit)
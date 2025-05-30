import { CUSTOM_JSON_ID, SCHEMA_NAME } from './constants.js'
import db from './db.js'
import logger from './logger.js'

type ParsedOp = {
    valid: boolean
    ts?: Date
    user?: string
}

const processor = {
    validateAndParse: async (op: any, ts: Date): Promise<ParsedOp> => {
        try {
            let parsed = JSON.parse(op.body)
            // sanitize and filter custom json
            // adjust operation field checking as necessary
            if (parsed.type !== 'custom_json_operation' ||
                !parsed.value ||
                parsed.value.id !== CUSTOM_JSON_ID ||
                !Array.isArray(parsed.value.required_posting_auths) ||
                parsed.value.required_posting_auths.length > 1 || // who is really transacting in multisig?
                parsed.value.required_posting_auths.length === 0 || // use posting auth only
                !parsed.value.json)
                return { valid: false }
            let payload = JSON.parse(parsed.value.json)
            let details: ParsedOp = {
                valid: true,
                ts: ts,
                user: parsed.value.required_posting_auths[0]
            }
            // validate operation here
            return { valid: false }
        } catch {
            logger.debug('Failed to parse operation, id:',op.id,'block:',op.block_num)
            return { valid: false }
        }
    },
    process: async (op: any, ts: Date): Promise<boolean> => {
        let result = await processor.validateAndParse(op, ts)
        if (result.valid) {
            logger.trace('Processing op',result)
            // call the appropriate PL/pgSQL here to process operation
            await db.client.query(`SELECT ${SCHEMA_NAME}.process_tx($1);`,[result.user])
        }
        return result.valid
    }
}

export default processor
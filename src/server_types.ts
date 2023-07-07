import type express from 'express'

export interface HafApiRequestTypes extends express.Request {
    // replace with your api request fields
    query: {
        id?: string
    }
}
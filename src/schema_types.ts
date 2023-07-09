export type FK_TYPE = {
    table: string
    fk: string
    ref: string
}

export type FKS_TYPE = {
    [key: string]: FK_TYPE
}

export type INDEX_TYPE = {
    table_name: string,
    columns: INDEX_COL_TYPE[]
}

export type INDEX_COL_TYPE = {
    col_name: string,
    order: Ordering
}

export type INDEXES_TYPE = {
    [key: string]: INDEX_TYPE
}

export enum Ordering {
    ASC,
    DESC
}
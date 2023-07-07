declare namespace config {
    const postgres_url: string
    const http_host: string
    const http_port: number
    const log_level: 'warn' | 'info' | 'debug' | 'trace'
}

export = config
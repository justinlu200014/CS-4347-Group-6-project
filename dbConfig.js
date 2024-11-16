const config = {
    server: 'VIVI',
    database: 'StudentRecordSystemNormalized',
    user: 'cs4347',
    password: 'deliverable2',
    driver: 'msnodesqlv8',
    options: {
        encrypt: false, 
        trustedConnection: true, 
        trustServerCertificate: true 
    }
}
module.exports = config
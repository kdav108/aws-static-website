const fs = require('fs');
const html = fs.readFileSync('index.html', { encoding:'utf8' });

/**
 * Lambda function handler. 
 * 
 * Returns a static HTML page.
 */
exports.handler = async (event) => {
    const response = {
        statusCode: 200,
        headers: {
            'Content-Type': 'text/html',
        },
        body: html,
    };
    return response;
};

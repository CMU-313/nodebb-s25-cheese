const axios = require('axios');

async function post(url, data, jar) {
    try {
        const cookies = jar.getCookiesSync(url).map(cookie => cookie.toString()).join('; ');
        const response = await axios.post(url, data, {
            headers: {
                Cookie: cookies,
            },
        });
        return response.data;
    } catch (error) {
        console.error('API POST error:', error);
        throw error;
    }
}

module.exports = {
    post: post, // Correctly export the post function
};
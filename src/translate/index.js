var request = require('request');

const translatorApi = module.exports;

translatorApi.translate = async function (postData) {
    console.log('[Translate] Called with content:', postData.content);
    const TRANSLATOR_API = "http://localhost:8080/"
    const response = await fetch(TRANSLATOR_API+'/?content='+postData.content);
    const data = await response.json();
    console.log(data)
    return [data["is_english"], data["translated_content"]]
}

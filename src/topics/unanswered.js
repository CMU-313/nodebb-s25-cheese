'use strict';

const db = require('../database');

async function getUnanswered(callback) {
    const topicIds = await db.getSortedSetRange('topics:tid', 0, -1);
    const unansweredTopics = [];

    for (const tid of topicIds) {
        const topic = await db.getObject(`topic:${tid}`);
        if (topic.unanswered == 1) {
            unansweredTopics.push(topic);
        }
    }

    callback(null, unansweredTopics);
}
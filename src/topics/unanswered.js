'use strict';

const db = require('../database');

async function getUnanswered(callback) {
	// Fetch all topic IDs
	const topicIds = await db.getSortedSetRange('topics:tid', 0, -1);
	const unansweredTopics = [];

	// Fetch topic details in parallel to avoid await inside the loop
	const topics = await Promise.all(topicIds.map(tid => db.getObject(`topic:${tid}`)));

	// Filter unanswered topics
	for (const topic of topics) {
		if (topic.unanswered === 1) {
			unansweredTopics.push(topic);
		}
	}

	callback(null, unansweredTopics);
}

// Test function call
getUnanswered((err, topics) => {
	if (err) {
		console.error(err);
	} else {
		console.log(topics);
	}
});


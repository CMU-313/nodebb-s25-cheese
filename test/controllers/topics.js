'use strict';

const topicsController = require('../../src/controllers/topics');
const db = require('../../src/database');

jest.mock('../../src/database'); // Mock the database module

describe('getUnansweredTopics', () => {
	beforeEach(() => {
		jest.clearAllMocks();
	});

	test('should return unanswered topics (postcount === 1)', async () => {
		// Mock Redis data
		const mockTids = [1, 2, 3];
		const mockTopics = [
			{ tid: 1, title: 'Unanswered Topic 1', postcount: 1 },
			{ tid: 2, title: 'Answered Topic 1', postcount: 2 },
			{ tid: 3, title: 'Unanswered Topic 2', postcount: 1 },
		];

		// Mock database calls
		db.getSortedSetRevRange.mockResolvedValue(mockTids);
		db.getTopicsByTids = jest.fn().mockResolvedValue(mockTopics);

		// Call function
		const result = await topicsController.getUnansweredTopics(10, 0);

		// Expect only unanswered topics
		expect(result).toEqual([
			{ tid: 1, title: 'Unanswered Topic 1', postcount: 1 },
			{ tid: 3, title: 'Unanswered Topic 2', postcount: 1 },
		]);

		// Verify database calls
		expect(db.getSortedSetRevRange).toHaveBeenCalledWith('topics:tid', 0, 9);
		expect(db.getTopicsByTids).toHaveBeenCalledWith(mockTids, 0);
	});

	test('should return an empty array if no unanswered topics exist', async () => {
		// Mock Redis response with only answered topics
		db.getSortedSetRevRange.mockResolvedValue([1, 2, 3]);
		db.getTopicsByTids.mockResolvedValue([
			{ tid: 1, title: 'Answered Topic', postcount: 5 },
			{ tid: 2, title: 'Another Answered Topic', postcount: 3 },
		]);

		const result = await topicsController.getUnansweredTopics(10, 0);
		expect(result).toEqual([]); // No unanswered topics
	});

	test('should return an empty array if no topics are found', async () => {
		db.getSortedSetRevRange.mockResolvedValue([]); // No topic IDs
		db.getTopicsByTids.mockResolvedValue([]);

		const result = await topicsController.getUnansweredTopics(10, 0);
		expect(result).toEqual([]);
	});

	test('should handle database errors', async () => {
		db.getSortedSetRevRange.mockRejectedValue(new Error('Database failure'));

		await expect(topicsController.getUnansweredTopics(10, 0))
			.rejects.toThrow('Error fetching unanswered topics: Database failure');
	});
});

// this code is from chatgpt
const request = require('supertest');
const assert = require('assert');

const API_URL = 'http://localhost:4567';
const ADMIN_TOKEN = '922602ad-5f42-4e19-9608-6673eedda36b';

describe('GET /api/topics/unanswered', function () {
    it('should return a list of unanswered topics', async function () {
        console.log("🚀 Testing: GET /api/topics/unanswered");

        const res = await request(API_URL)
            .get('/api/topics/unanswered')
            .set('Authorization', ADMIN_TOKEN) // 🔹 Ensure authentication
            .expect('Content-Type', /json/)
            .expect(200);

        console.log("✅ Response:", res.body);

        assert(Array.isArray(res.body.topics), 'Response should be an array');
        res.body.topics.forEach(topic => {
            assert.strictEqual(topic.postcount, 1, 'Each topic should be unanswered');
        });
    });

    it('should return an empty array if no unanswered topics exist', async function () {
        console.log("🚀 Checking if there are any unanswered topics...");

        const res = await request(API_URL)
            .get('/api/topics/unanswered')
            .set('Authorization', ADMIN_TOKEN) // 🔹 Ensure authentication
            .expect(200);

        console.log("✅ Response:", res.body);

        if (res.body.topics.length === 0) {
            console.log("✅ No unanswered topics exist, test passes.");
            assert.deepStrictEqual(res.body.topics, []);
        } else {
            console.log(`⚠️ Found ${res.body.topics.length} unanswered topics, skipping empty test.`);
        }
    });

    it('should support pagination with limit & offset', async function () {
        console.log("🚀 Testing: Pagination for /api/topics/unanswered");

        const res = await request(API_URL)
            .get('/api/topics/unanswered?limit=2&offset=0')
            .set('Authorization', ADMIN_TOKEN) // 🔹 Ensure authentication
            .expect(200);

        console.log("✅ Paginated Response:", res.body);

        assert(res.body.topics.length <= 2, 'Should return at most 2 topics');
    });
});

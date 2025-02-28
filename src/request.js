'use strict';

const { CookieJar } = require('tough-cookie');
const fetchCookie = require('fetch-cookie').default;

exports.jar = function () {
	return new CookieJar();
};

async function call(url, method, { body, timeout, jar, ...config } = {}) {
	let fetchImpl = fetch;
	if (jar) {
		fetchImpl = fetchCookie(fetch, jar);
	}

	const jsonTest = /application\/([a-z]+\+)?json/;
	const opts = {
		...config,
		method,
		headers: {
			'content-type': 'application/json',
			...config.headers,
		},
	};
	if (timeout > 0) {
		opts.signal = AbortSignal.timeout(timeout);
	}

	if (body && ['POST', 'PUT', 'PATCH', 'DEL', 'DELETE'].includes(method)) {
		if (opts.headers['content-type'] && jsonTest.test(opts.headers['content-type'])) {
			opts.body = JSON.stringify(body);
		} else {
			opts.body = body;
		}
	}

	const response = await fetchImpl(url, opts);

	const { headers } = response;
	const contentType = headers.get('content-type');
	const isJSON = contentType && jsonTest.test(contentType);
	let respBody = await response.text();
	if (isJSON && respBody) {
		try {
			respBody = JSON.parse(respBody);
		} catch (err) {
			throw new Error('invalid json in response body', url);
		}
	}

	return {
		body: respBody,
		response: {
			ok: response.ok,
			status: response.status,
			statusCode: response.status,
			statusText: response.statusText,
			headers: Object.fromEntries(response.headers.entries()),
		},
	};
}

/*
  Define createUser and deleteUser functions
*/

exports.createUser = async function (userData) {
	const url = 'https://your-api.com/users'; // Replace with actual endpoint
	return call(url, 'POST', { body: userData });
};

exports.deleteUser = async function (userId) {
	const url = `https://your-api.com/users/${userId}`; // Replace with actual endpoint
	return call(url, 'DELETE');
};

/*
const { body, response } = await request.get('someurl?foo=1&baz=2')
*/
exports.get = async (url, config) => call(url, 'GET', config);
exports.head = async (url, config) => call(url, 'HEAD', config);
exports.del = async (url, config) => call(url, 'DELETE', config);
exports.delete = exports.del;
exports.options = async (url, config) => call(url, 'OPTIONS', config);

/*
const { body, response } = await request.post('someurl', { body: { foo: 1, baz: 2}})
*/
exports.post = async (url, config) => call(url, 'POST', config);
exports.put = async (url, config) => call(url, 'PUT', config);
exports.patch = async (url, config) => call(url, 'PATCH', config);
exports.loginUser = async function (credentials) {
	const url = 'https://your-api.com/auth/login'; // Replace with actual login endpoint
	return call(url, 'POST', { body: credentials });
};

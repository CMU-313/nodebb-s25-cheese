'use strict';

define('forum/topic/resolve', [
	'alerts', 'hooks', 'api'
], function (alerts, hooks, api) {
	const Resolve = {};
	let modal;

	Resolve.init = function (tid, isResolved, onComplete) {
		if (modal) {
			return;
		}
		Resolve.tid = tid;
		Resolve.isResolved = isResolved;
		Resolve.onComplete = onComplete;

		showModal();
	};

	function showModal() {
		app.parseAndTranslate('modals/resolve-topic', {}, function (html) {
			modal = html;
			$('body').append(modal);

			if (Resolve.isResolved) {
				modal.find('.card-header').translateText('[[topic:unresolve-topic]]');
			} else {
				modal.find('.card-header').translateText('[[topic:resolve-topic]]');
			}

			modal.find('#resolve_thread_commit').on('click', onCommitClicked);
			modal.find('#resolve_topic_cancel').on('click', closeResolveModal);
		});
	}

	function onCommitClicked() {
		const commitEl = modal.find('#resolve_thread_commit');

		if (!commitEl.prop('disabled')) {
			commitEl.prop('disabled', true);
			closeResolveModal();

			const message = Resolve.isResolved ? '[[topic:topic-unresolve-success]]' : '[[topic:topic-resolve-success]]';
			const data = { tid: Resolve.tid, resolved: !Resolve.isResolved };

			alerts.alert({
				alert_id: 'tid_resolve_' + Resolve.tid,
				title: '[[topic:thread-tools.resolve]]',
				message: message,
				type: 'success',
				timeout: config.undoTimeout,
				timeoutfn: function () {
					updateTopicResolution(data);
				},
				clickfn: function (alert, params) {
					delete params.timeoutfn;
					alerts.success('[[topic:topic-resolve-undone]]');
				}
			});
		}
	}

	function updateTopicResolution(data) {
		hooks.fire('action:topic.resolve', data);

		api.put(`/topics/${data.tid}/resolved`, { resolved: data.resolved })
			.then(() => {
				if (typeof Resolve.onComplete === 'function') {
					Resolve.onComplete();
				}
			})
			.catch(alerts.error);
	}

	function closeResolveModal() {
		if (modal) {
			modal.remove();
			modal = null;
		}
	}

	return Resolve;
});

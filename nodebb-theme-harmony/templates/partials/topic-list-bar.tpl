<div class="{{{ if config.theme.stickyToolbar }}}sticky-tools{{{ end }}} mb-3">
	<nav class="topic-list-header d-flex flex-nowrap my-2 p-0 border-0 rounded">
		<div class="d-flex flex-row p-2 text-bg-light gap-1 border rounded w-100 align-items-center">
			<div component="category/controls" class="d-flex me-auto mb-0 gap-2 flex-wrap">
				{{{ if template.category }}}
				<!-- IMPORT partials/category/watch.tpl -->
				<!-- IMPORT partials/tags/filter-dropdown-left.tpl -->
				<!-- IMPORT partials/category/sort.tpl -->

				<!-- Add Unanswered Questions Button -->
				<button id="unanswered-button" class="btn-ghost-sm ff-secondary d-flex gap-2 align-items-center" data-filter="unanswered">
					<i class="fa fa-question-circle me-1 text-primary"></i>
					<span>[[topic:unanswered-questions]]</span>
				</button>

				<script>
				$(document).ready(function() {
					$('#unanswered-button').on('click', function() {
						// Add active class to this button and remove from others
						$(this).addClass('active').siblings('.active').removeClass('active');
						
						// Show loading indicator if available
						if (app.loadingIndicator) {
							app.loadingIndicator.show();
						}
						
						// Make AJAX request to get unanswered topics
						$.ajax({
							url: config.relative_path + '/api/topics/unanswered',
							type: 'GET',
							data: {
								limit: 20
							},
							success: function(response) {
								// Get the topics container
								var $topicsContainer = $('[component="category"]').find('[component="category/topic"]').parent();
								$topicsContainer.empty();
								
								if (response && response.topics && response.topics.length) {
									// Use NodeBB's template system to render the topics
									app.parseAndTranslate('partials/topics_list', 'topics', {
										topics: response.topics
									}, function(html) {
										$topicsContainer.append(html);
									});
								} else {
									// Show "no topics" message
									$topicsContainer.append('<div class="alert alert-info">No unanswered topics found</div>');
								}
								
								// Hide loading indicator
								if (app.loadingIndicator) {
									app.loadingIndicator.hide();
								}
							},
							error: function(error) {
								console.error('Error fetching unanswered topics:', error);
								if (app.alertError) {
									app.alertError('Error loading unanswered topics: ' + (error.responseJSON ? error.responseJSON.error : 'Unknown error'));
								}
								if (app.loadingIndicator) {
									app.loadingIndicator.hide();
								}
							}
						});
						
						return false; // Prevent default action
					});
				});
				</script>
				
				{{{ end }}}
				{{{ if (template.popular || template.top)}}}
				<!-- IMPORT partials/topic-terms.tpl -->
				{{{ end }}}
				{{{ if (template.unread || (template.recent || (template.popular || template.top))) }}}
				<!-- IMPORT partials/topic-filters.tpl -->
				<!-- IMPORT partials/category/filter-dropdown-left.tpl -->
				<!-- IMPORT partials/tags/filter-dropdown-left.tpl -->
				{{{ end }}}
				{{{ if template.unread }}}
				<div class="markread btn-group {{{ if !topics.length }}}hidden{{{ end }}}">
					<!-- IMPORT partials/category/selector-dropdown-left.tpl -->
				</div>
				{{{ end }}}
				{{{ if template.tag }}}
				<!-- IMPORT partials/category/filter-dropdown-left.tpl -->
				<!-- IMPORT partials/tags/watch.tpl -->
				{{{ end }}}
				<!-- IMPORT partials/category/tools.tpl -->

				{{{ if (!feeds:disableRSS && rssFeedUrl) }}}
				<a class="btn-ghost-sm d-none d-lg-flex align-self-stretch" target="_blank" href="{rssFeedUrl}" itemprop="item" title="[[global:rss-feed]]"><i class="fa fa-rss text-primary"></i></a>
				{{{ end }}}

				<a href="{{{ if template.category }}}{url}{{{ else }}}{config.relative_path}/{selectedFilter.url}{querystring}{{{ end }}}" class="btn btn-secondary fw-semibold position-absolute top-100 translate-middle-x start-50 mt-1 hide" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;" id="new-topics-alert">
					<i class="fa fa-fw fa-arrow-up"></i> [[recent:load-new-posts]]
				</a>
			</div>

			<div class="d-flex gap-1 align-items-center">
				{{{ if template.category }}}
					{{{ if privileges.topics:create }}}
					<a href="{config.relative_path}/compose?cid={cid}" component="category/post" id="new_topic" class="btn btn-primary btn-sm text-nowrap" data-ajaxify="false" role="button">[[category:new-topic-button]]</a>
					{{{ end }}}
				{{{ else }}}
					{{{ if canPost }}}
					<!-- IMPORT partials/buttons/newTopic.tpl -->
					{{{ end }}}
				{{{ end }}}
				<!-- only show login button if not logged in and doesn't have any posting privilege -->
				{{{ if (!loggedIn && (!privileges.topics:create && !canPost))}}}
				<a component="category/post/guest" href="{config.relative_path}/login" class="btn btn-sm btn-primary">[[category:guest-login-post]]</a>
				{{{ end }}}
			</div>
		</div>
	</nav>
</div>
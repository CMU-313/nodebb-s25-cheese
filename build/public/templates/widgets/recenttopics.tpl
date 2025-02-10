<div class="overflow-hidden">
<ul id="recent_topics" class="list-unstyled d-flex flex-column gap-3" data-numtopics="{numTopics}">
{{{ each topics }}}
<li class="widget-topics">
<div class="d-flex gap-1">
<a class="text-decoration-none" href="{{{ if ./user.userslug }}}{relative_path}/user/{./user.userslug}{{{ else }}}#{{{ end }}}">
{buildAvatar(./teaser.user, "24px", true, "avatar-tooltip not-responsive")}
</a>
<div class="px-1 text-truncate">
<a href="{relative_path}/topic/{./slug}">{./title}</a>
</div>
</div>
<div class="text-end text-xs post-preview-footer fs-6">
<span class="timeago" title="{./lastposttimeISO}"></span>
</div>
</li>
{{{ end }}}
</ul>
</div>
<script>
'use strict';
/* globals app, socket*/
(function() {
function onLoad() {
var	topics = $('#recent_topics');
var recentTopicsWidget = app.widgets.recentTopics;
var numTopics = parseInt(topics.attr('data-numtopics'), 10) || 8;
if (!recentTopicsWidget) {
recentTopicsWidget = {};
recentTopicsWidget.onNewTopic = function(topic) {
var recentTopics = $('#recent_topics');
if (!recentTopics.length) {
return;
}
app.parseAndTranslate('widgets/partials/topics', { topics: [topic] }, function(html) {
processHtml(html);
html.hide()
.prependTo(recentTopics)
.fadeIn();
if (recentTopics.children().length > numTopics) {
recentTopics.children().last().remove();
}
});
};
app.widgets.recentTopics = recentTopicsWidget;
socket.on('event:new_topic', app.widgets.recentTopics.onNewTopic);
}
function processHtml(html) {
if ($.timeago) {
html.find('span.timeago').timeago();
}
}
}
if (document.readyState === 'loading') {
document.addEventListener('DOMContentLoaded', onLoad);
} else {
onLoad();
}
})();
</script>
{{{ if matchCount }}}
<div class="card card-header text-xs px-2 py-1 fw-semibold border-0 align-self-start">[[search:results-matching, {matchCount}, {search_query}, {time}]] </div>
{{{ else }}}
{{{ if search_query }}}
<div class="badge text-bg-warning align-self-start">[[search:no-matches]]</div>
{{{ end }}}
{{{ end }}}
<div id="results" class="search-results" data-search-query="{search_query}">
{{{ if showAsPosts }}}
{{{ if posts.length }}}
<ul component="posts" class="posts-list list-unstyled" data-nextstart="{nextStart}">
{{{ each posts }}}
<li component="post" class="posts-list-item  {{{ if ./deleted }}} deleted{{{ else }}}{{{ if ./topic.deleted }}} deleted{{{ end }}}{{{ end }}}{{{ if ./topic.scheduled }}} scheduled{{{ end }}}" data-pid="{./pid}" data-uid="{./uid}">
<hr/>
<a class="topic-title fw-semibold fs-5 mb-2 text-reset text-break d-block" href="{config.relative_path}/post/{./pid}">
{{{ if ./isMainPost }}}<i class="fa fa-book text-muted" title="[[topic:topic]]"></i> {{{ end }}}{./topic.title}
</a>
<div class="post-body d-flex flex-column gap-1">
<div class="d-flex gap-3 post-info text-sm align-items-center">
<div class="post-author d-flex align-items-center gap-1">
<a class="lh-1 text-decoration-none" href="{config.relative_path}/user/{./user.userslug}">{buildAvatar(./user, "16px", true, "not-responsive")}</a>
<a class="lh-1 fw-semibold" href="{config.relative_path}/user/{./user.userslug}">{../user.displayname}</a>
</div>
<span class="timeago text-muted lh-1" title="{./timestampISO}"></span>
</div>
<div component="post/content" class="content text-sm text-break">
{./content}
</div>
</div>
</li>
{{{ end }}}
</ul>
<div component="posts/loading" class="loading-indicator text-center hidden">
<i class="fa fa-refresh fa-spin"></i>
</div>
{{{ end }}}
{{{ end }}}
{{{ if showAsTopics }}}
{{{ each posts }}}
<hr/>
<div class="topic-row  mb-3">
<a class="topic-title fw-semibold fs-5 text-reset text-break" href="{config.relative_path}/post/{./pid}">
{{{ if !./isMainPost }}}RE: {{{ end }}}{./topic.title}
</a>
<div class="post-body d-flex flex-column gap-1">
<div class="d-flex gap-3 post-info">
<div class="post-author d-flex gap-1">
<a class="lh-1 text-decoration-none" href="{config.relative_path}/user/{./user.userslug}">{buildAvatar(./user, "16px", true, "not-responsive")}</a>
<a class="fw-semibold text-sm" href="{config.relative_path}/user/{./user.userslug}">{../user.displayname}</a>
</div>
<span class="timeago text-sm text-muted" title="{./timestampISO}"></span>
</div>
</div>
</div>
{{{ end }}}
{{{ end }}}
{{{ if users.length }}}
<div id="users-container" class="users-container row row-cols-2 row-cols-lg-3 row-cols-xl-4 g-4">
{{{ each users }}}
<a href="{config.relative_path}/user/{./userslug}" class="btn-ghost ff-secondary align-items-start justify-content-start p-2 ff-base">
{buildAvatar(@value, "48px", true, "flex-shrink-0")}
<div class="d-flex flex-column text-truncate">
<div class="fw-semibold text-truncate" title="{./displayname}">{./displayname}</div>
<div class="text-xs text-muted text-truncate">@{./username}</div>
{{{ if section_online }}}
<div class="text-xs text-muted text-truncate">
<span class="timeago" title="{./lastonlineISO}"></span>
</div>
{{{ end }}}
{{{ if section_joindate }}}
<div class="text-xs text-muted text-truncate">
<span class="timeago" title="{./joindateISO}"></span>
</div>
{{{ end }}}
{{{ if section_sort-reputation }}}
<div class="text-xs text-muted text-truncate">
<span>{formattedNumber(./reputation)}</span>
</div>
{{{ end }}}
{{{ if section_sort-posts }}}
<div class="text-xs text-muted text-truncate">
<span>{formattedNumber(./postcount)}</span>
</div>
{{{ end }}}
{{{ if section_flagged }}}
<div class="text-xs text-muted text-truncate">
<span>{formattedNumber(./flags)}</span>
</div>
{{{ end }}}
</div>
</a>
{{{ end }}}
</div>
{{{ end }}}
{{{ if tags.length }}}
<div class="tag-list row row-cols-2 row-cols-lg-3 row-cols-xl-4 gx-3 gy-2">
{{{each tags}}}
<a href="{config.relative_path}/tags/{./valueEncoded}" data-tag="{./valueEscaped}" class="btn-ghost ff-secondary flex-column gap-0 align-items-start justify-content-start text-truncate p-2 ff-base">
<div class="fw-semibold text-nowrap tag-item w-100 text-truncate">{./valueEscaped}</div>
<div class="text-xs text-muted text-nowrap tag-topic-count">[[global:x-topics, {formattedNumber(./score)}]]</div>
</a>
{{{end}}}
</div>
{{{ end }}}
{{{ if categories.length }}}
<ul class="categories list-unstyled">
{{{each categories}}}
<li component="categories/category" data-cid="{./cid}" class="w-100 border-bottom py-3 py-lg-4 gap-lg-0 gap-2 d-flex flex-column flex-lg-row align-items-start category-{./cid} {./unread-class}">
<meta itemprop="name" content="{./name}">
<div class="d-flex col-lg-7 gap-2 gap-lg-3">
<div class="flex-shrink-0">
{buildCategoryIcon(@value, "40px", "rounded-1")}
</div>
<div class="flex-grow-1 d-flex flex-wrap gap-1">
<h2 class="title text-break fs-4 fw-semibold m-0 tracking-tight w-100">
{{{ if ./isSection }}}
{./name}
{{{ else }}}
<a class="text-reset" href="{{{ if ./link }}}{./link}{{{ else }}}{config.relative_path}/category/{./slug}{{{ end }}}" itemprop="url">{../name}</a>
{{{ end }}}
</h2>
{{{ if ./descriptionParsed }}}
<div class="description text-muted text-sm w-100">
{./descriptionParsed}
</div>
{{{ end }}}
{{{ if !config.hideSubCategories }}}
{{{ if ./children.length }}}
<div class="category-children row row-cols-2 g-2 my-1 w-100">
{{{ each ./children }}}
{{{ if !./isSection }}}
<span class="category-children-item small">
<div class="d-flex align-items-center gap-1">
<i class="fa fa-fw fa-caret-right text-primary"></i>
<a href="{{{ if ./link }}}{./link}{{{ else }}}{config.relative_path}/category/{./slug}{{{ end }}}" class="text-reset fw-semibold">{./name}</a>
</div>
</span>
{{{ end }}}
{{{ end }}}
</div>
{{{ end }}}
{{{ end }}}
</div>
</div>
{{{ if (!./link && !./isSection) }}}
<div class="d-flex col-lg-5 col-12 align-content-stretch">
<div class="meta stats d-none d-lg-grid col-6 gap-1 pe-2 text-muted" style="grid-template-columns: 1fr 1fr;">
<div class="card card-header border-0 p-2 overflow-hidden rounded-1 d-flex flex-column align-items-center">
<span class="fs-5 ff-secondary lh-1" title="{./totalTopicCount}">{humanReadableNumber(./totalTopicCount, 0)}</span>
<span class="d-none d-xl-flex text-lowercase text-xs">[[global:topics]]</span>
<i class="d-xl-none fa fa-fw text-xs text-muted opacity-75 fa-list"></i>
</div>
<div class="card card-header border-0 p-2 overflow-hidden rounded-1 d-flex flex-column align-items-center">
<span class="fs-5 ff-secondary lh-1" title="{./totalPostCount}">{humanReadableNumber(./totalPostCount, 0)}</span>
<span class="d-none d-xl-flex text-lowercase text-xs">[[global:posts]]</span>
<i class="d-xl-none fa fa-fw text-xs text-muted opacity-75 fa-message"></i>
</div>
</div>
{{{ if !config.hideCategoryLastPost }}}
<div component="topic/teaser" class="teaser col-lg-6 col-12 {{{ if !config.theme.mobileTopicTeasers }}}d-none d-lg-block{{{ end }}}">
<div class="lastpost border-start border-2 lh-sm h-100" style="border-color: {./bgColor}!important;">
{{{ each ./posts }}}
{{{ if @first }}}
<div component="category/posts" class="ps-2 text-xs d-flex flex-column h-100 gap-1">
<div class="text-nowrap text-truncate">
<a class="text-decoration-none" href="{config.relative_path}/user/{./user.userslug}">{buildAvatar(posts.user, "18px", true, "avatar-tooltip")}</a>
<a class="permalink text-muted timeago text-xs" href="{config.relative_path}/topic/{./topic.slug}{{{ if ./index }}}/{./index}{{{ end }}}" title="{./timestampISO}" aria-label="[[global:lastpost]]"></a>
</div>
<div class="post-content text-xs text-break line-clamp-sm-2 lh-sm position-relative flex-fill">
<a class="stretched-link" tabindex="-1" href="{config.relative_path}/topic/{./topic.slug}{{{ if ./index }}}/{./index}{{{ end }}}" aria-label="[[global:lastpost]]"></a>
{./content}
</div>
</div>
{{{ end }}}
{{{ end }}}
{{{ if !./posts.length }}}
<div component="category/posts" class="ps-2">
<div class="post-content overflow-hidden text-xs">
[[category:no-new-posts]]
</div>
</div>
{{{ end }}}
</div>
</div>
{{{ end }}}
</div>
{{{ end }}}
</li>
{{{end}}}
</ul>
{{{ end }}}
<nav component="pagination" class="pagination-container mt-3{{{ if !pagination.pages.length }}} hidden{{{ end }}}" aria-label="[[global:pagination]]">
<ul class="pagination pagination-sm gap-1 hidden-xs hidden-sm justify-content-center">
<li class="page-item previous {{{ if !pagination.prev.active }}} disabled{{{ end }}}">
<a class="page-link rounded fw-secondary px-3" href="?{pagination.prev.qs}" data-page="{pagination.prev.page}" aria-label="[[global:pagination.previouspage]]"><i class="fa fa-chevron-left"></i> </a>
</li>
{{{each pagination.pages}}}
{{{ if ./separator }}}
<li component="pagination/select-page" class="page-item page select-page">
<a class="page-link rounded fw-secondary px-3" href="#" aria-label="[[global:pagination.go-to-page]]"><i class="fa fa-ellipsis-h"></i></a>
</li>
{{{ else }}}
<li class="page-item page{{{ if ./active }}} active{{{ end }}}" >
<a class="page-link rounded fw-secondary px-3" href="?{./qs}" data-page="{./page}" aria-label="[[global:pagination.page-x, {./page}]]">{./page}</a>
</li>
{{{ end }}}
{{{end}}}
<li class="page-item next {{{ if !pagination.next.active }}} disabled{{{ end }}}">
<a class="page-link rounded fw-secondary px-3" href="?{pagination.next.qs}" data-page="{pagination.next.page}" aria-label="[[global:pagination.nextpage]]"> <i class="fa fa-chevron-right"></i></a>
</li>
</ul>
{{{ if !template.topic }}}
<ul class="pagination pagination-sm hidden-md hidden-lg justify-content-center">
<li class="page-item first{{{ if !pagination.prev.active }}} disabled{{{ end }}}">
<a class="page-link fw-secondary" href="?{pagination.first.qs}" data-page="1" aria-label="[[global:pagination.firstpage]]"><i class="fa fa-fast-backward"></i> </a>
</li>
<li class="page-item previous{{{ if !pagination.prev.active }}} disabled{{{ end }}}">
<a class="page-link fw-secondary" href="?{pagination.prev.qs}" data-page="{pagination.prev.page}" aria-label="[[global:pagination.previouspage]]"><i class="fa fa-chevron-left"></i> </a>
</li>
<li component="pagination/select-page" class="page-item page select-page">
<a class="page-link fw-secondary" href="#" aria-label="[[global:pagination.go-to-page]]">{pagination.currentPage} / {pagination.pageCount}</a>
</li>
<li class="page-item next{{{ if !pagination.next.active }}} disabled{{{ end }}}">
<a class="page-link fw-secondary" href="?{pagination.next.qs}" data-page="{pagination.next.page}" aria-label="[[global:pagination.nextpage]]"> <i class="fa fa-chevron-right"></i></a>
</li>
<li class="page-item last{{{ if !pagination.next.active }}} disabled{{{ end }}}">
<a class="page-link fw-secondary"  href="?{pagination.last.qs}" data-page="{pagination.pageCount}" aria-label="[[global:pagination.lastpage]]"><i class="fa fa-fast-forward"></i> </a>
</li>
</ul>
{{{ end }}}
</nav>
</div>
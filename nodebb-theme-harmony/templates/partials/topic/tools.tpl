{{{ {{{ if true }}} }}}
<div class="btn-group thread-tools bottom-sheet">
	<button class="btn-ghost-sm ff-secondary d-flex gap-2 dropdown-toggle" data-bs-toggle="dropdown" type="button" aria-haspopup="true" aria-expanded="false">
		<i class="fa fa-fw fa-gear text-primary"></i>
		<span class="d-none d-md-inline fw-semibold">[[topic:thread-tools.title]]</span>
	</button>
	<ul class="dropdown-menu p-1 text-sm" role="menu">
	<li>
        <a href="#" class="dropdown-item rounded-1 d-flex align-items-center gap-2">
            <i class="fa fa-fw fa-bug text-danger"></i> DEBUG BUTTON
        </a>
    </li>
		<li>
			<a component="topic/resolve" href="#" class="dropdown-item rounded-1 d-flex align-items-center gap-2" role="menuitem">
				<i class="fa fa-fw fa-check-circle text-success"></i> [[topic:mark-as-resolved]]
			</a>
		</li>

		<li>
			<a component="topic/lock" href="#" class="dropdown-item rounded-1 d-flex align-items-center gap-2" role="menuitem">
				<i class="fa fa-fw fa-lock text-warning"></i> [[topic:thread-tools.lock]]
			</a>
		</li>
	</ul>
</div>
{{{ end }}}

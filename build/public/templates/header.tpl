<!DOCTYPE html>
<html lang="{function.localeToHTML, userLang, defaultLang}" {{{if languageDirection}}}data-dir="{languageDirection}" style="direction: {languageDirection};"{{{end}}}>
<head>
<title>{browserTitle}</title>
{{{each metaTags}}}{function.buildMetaTag}{{{end}}}
<link rel="stylesheet" type="text/css" href="{relative_path}/assets/client{{{if bootswatchSkin}}}-{bootswatchSkin}{{{end}}}{{{ if (languageDirection=="rtl") }}}-rtl{{{ end }}}.css?{config.cache-buster}" />
{{{each linkTags}}}{function.buildLinkTag}{{{end}}}
<script>
var config = JSON.parse('{{configJSON}}');
var app = {
user: JSON.parse('{{userJSON}}')
};
document.documentElement.style.setProperty('--panel-offset', `${localStorage.getItem('panelOffset') || 0}px`);
</script>
{{{if useCustomHTML}}}
{{customHTML}}
{{{end}}}
{{{if useCustomCSS}}}
<style>{{customCSS}}</style>
{{{end}}}
</head>
<body class="{bodyClass} skin-{{{if bootswatchSkin}}}{bootswatchSkin}{{{else}}}noskin{{{end}}}">
<a class="visually-hidden-focusable position-absolute top-0 start-0 p-3 m-3 bg-body" style="z-index: 1021;" href="#content">[[global:skip-to-content]]</a>
<div class="layout-container d-flex justify-content-between pb-4 pb-md-0">
<nav component="sidebar/left" class="{{{ if config.theme.openSidebars}}}open{{{ end }}} text-dark bg-light sidebar sidebar-left start-0 border-end vh-100 d-none d-lg-flex flex-column justify-content-between sticky-top">
<ul id="main-nav" class="list-unstyled d-flex flex-column w-100 gap-2 mt-2 overflow-y-auto">
{{{ each navigation }}}
{{{ if displayMenuItem(@root, @index) }}}
<li class="nav-item mx-2 {./class}{{{ if ./dropdown }}} dropend{{{ end }}}" title="{./title}">
<a class="nav-link navigation-link d-flex gap-2 justify-content-between align-items-center {{{ if ./dropdown }}}dropdown-toggle{{{ end }}}" {{{ if ./dropdown }}} href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" {{{ else }}} href="{./route}"{{{ end }}} {{{ if ./id }}}id="{./id}"{{{ end }}}{{{ if ./targetBlank }}} target="_blank"{{{ end }}} {{{ if ./text }}}aria-label="{./text}"{{{ end }}}>
<span class="d-flex gap-2 align-items-center text-nowrap truncate-open">
<span class="position-relative">
{{{ if ./iconClass }}}
<i class="fa fa-fw {./iconClass}" data-content="{./content}"></i>
<span component="navigation/count" class="visible-closed position-absolute top-0 start-100 translate-middle badge rounded-1 bg-primary {{{ if !./content }}}hidden{{{ end }}}">{./content}</span>
{{{ end }}}
</span>
{{{ if ./text }}}<span class="nav-text small visible-open fw-semibold text-truncate">{./text}</span>{{{ end }}}
</span>
<span component="navigation/count" class="visible-open badge rounded-1 bg-primary {{{ if !./content }}}hidden{{{ end }}}">{./content}</span>
</a>
{{{ if ./dropdown }}}
<ul class="dropdown-menu p-1 shadow" role="menu">
{./dropdownContent}
</ul>
{{{ end }}}
</li>
{{{ end }}}
{{{ end }}}
</ul>
<div class="sidebar-toggle-container align-self-start">
{{{ if !config.disableCustomUserSkins }}}
<div class="dropend m-2" component="skinSwitcher" title="[[themes/harmony:skins]]">
<a data-bs-toggle="dropdown" href="#" role="button" class="nav-link position-relative" aria-haspopup="true" aria-expanded="false" aria-label="[[themes/harmony:skins]]">
<span class="justify-content-between w-100">
<span class="d-flex gap-2 align-items-center text-nowrap truncate-open">
<span>
<i component="skinSwitcher/icon" class="fa fa-fw fa-paintbrush"></i>
</span>
<span class="nav-text small visible-open fw-semibold">[[themes/harmony:skins]]</span>
</span>
</span>
</a>
<ul class="dropdown-menu p-1 text-sm overflow-auto p-1" role="menu">
<div class="d-flex">
<div>
<li class="dropdown-header">Light</li>
<div class="d-grid" style="grid-template-columns: 1fr 1fr;">
{{{ each bootswatchSkinOptions.light }}}
<li>
<a href="#" class="dropdown-item rounded-1" data-value="{./value}" role="menuitem">{./name} <i class="fa fa-fw fa-check {{{ if !./selected }}} invisible {{{ end }}}"></i></a>
</li>
{{{ end }}}
</div>
</div>
<div>
<li class="dropdown-header">Dark</li>
{{{ each bootswatchSkinOptions.dark }}}
<li>
<a href="#" class="dropdown-item rounded-1" data-value="{./value}" role="menuitem">{./name} <i class="fa fa-fw fa-check {{{ if !./selected }}} invisible {{{ end }}}"></i></a>
</li>
{{{ end }}}
</div>
</div>
<hr class="my-1"/>
<div class="d-grid" style="grid-template-columns: 1fr 1fr;">
{{{ each bootswatchSkinOptions.default }}}
<li>
<a href="#" class="dropdown-item rounded-1" data-value="{./value}" role="menuitem">{./name} <i class="fa fa-fw fa-check {{{ if !./selected }}} invisible {{{ end }}}"></i></a>
</li>
{{{ end }}}
{{{ each bootswatchSkinOptions.custom }}}
<li>
<a href="#" class="dropdown-item rounded-1" data-value="{./value}" role="menuitem">{./name} <i class="fa fa-fw fa-check {{{ if !./selected }}} invisible {{{ end }}}"></i></a>
</li>
{{{ end }}}
</div>
</ul>
</div>
{{{ end }}}
<div class="sidebar-toggle m-2 d-none d-lg-block">
<a href="#" role="button" component="sidebar/toggle" class="nav-link d-flex gap-2 align-items-center p-2 pointer w-100 text-nowrap" title="[[themes/harmony:expand]]" aria-label="[[themes/harmony:sidebar-toggle]]">
<i class="fa fa-fw fa-angles-right"></i>
<i class="fa fa-fw fa-angles-left"></i>
<span class="nav-text visible-open fw-semibold small lh-1">[[themes/harmony:collapse]]</span>
</a>
</div>
</div>
</nav>
<main id="panel" class="d-flex flex-column gap-3 flex-grow-1 mt-3" style="min-width: 0;">
{{{ if (brand:logo || config.showSiteTitle)}}}
<div class="container-lg px-md-4 brand-container">
<div class="col-12 d-flex border-bottom pb-3 {{{ if config.theme.centerHeaderElements }}}justify-content-center{{{ end }}}">
<div component="brand/wrapper" class="d-flex align-items-center gap-3 p-2 rounded-1 align-content-stretch ">
{{{ if brand:logo }}}
<a component="brand/anchor" href="{{{ if brand:logo:url }}}{brand:logo:url}{{{ else }}}{relative_path}/{{{ end }}}" title="[[global:header.brand-logo]]">
<img component="brand/logo" alt="{{{ if brand:logo:alt }}}{brand:logo:alt}{{{ else }}}[[global:header.brand-logo]]{{{ end }}}" class="{brand:logo:display}" src="{brand:logo}?{config.cache-buster}" />
</a>
{{{ end }}}
{{{ if config.showSiteTitle }}}
<a component="siteTitle" class="text-truncate align-self-stretch align-items-center d-flex" href="{{{ if title:url }}}{title:url}{{{ else }}}{relative_path}/{{{ end }}}">
<h1 class="fs-6 fw-bold text-body mb-0">{config.siteTitle}</h1>
</a>
{{{ end }}}
</div>
{{{ if widgets.brand-header.length }}}
<div data-widget-area="brand-header" class="flex-fill gap-3 p-2 align-self-center">
{{{each widgets.brand-header}}}
{{./html}}
{{{end}}}
</div>
{{{ end }}}
</div>
</div>
{{{ end }}}
<script>
const headerEl = document.getElementById('header-menu');
if (headerEl) {
const rect = headerEl.getBoundingClientRect();
const offset = Math.max(0, rect.bottom);
document.documentElement.style.setProperty('--panel-offset', offset + `px`);
} else {
document.documentElement.style.setProperty('--panel-offset', `0px`);
}
</script>
<div class="container-lg px-md-4 d-flex flex-column gap-3 h-100 mb-5 mb-lg-0" id="content">
<noscript>
<div class="alert alert-danger">
<p>
Your browser does not seem to support JavaScript. As a result, your viewing experience will be diminished, and you have been placed in <strong>read-only mode</strong>.
</p>
<p>
Please download a browser that supports JavaScript, or enable it if it's disabled (i.e. NoScript).
</p>
</div>
</noscript>
{{{ if noScriptMessage }}}
<noscript>
<div class="alert alert-info">
<p>
{noScriptMessage}
</p>
</div>
</noscript>
{{{ end }}}
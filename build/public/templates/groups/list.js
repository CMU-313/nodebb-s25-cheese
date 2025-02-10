
(function (factory) {
  if (typeof module === 'object' && module.exports) {
    module.exports = factory();
  } else if (typeof define === 'function' && define.amd) {
    define(factory);
  }
})(function () {
  function compiled(helpers, context, guard, iter, helper) {
    var __escape = helpers.__escape;
    var value = context;
    return "<div data-widget-area=\"header\">\n" + 
      compiled.blocks['widgets.header'](helpers, context, guard, iter, helper) + 
      "\n</div>\n<div class=\"groups list\">\n<h3 class=\"fw-semibold\">[[pages:groups]]</h3>\n<div class=\"d-flex flex-wrap justify-content-between\">\n<div class=\"mb-2 mb-md-0\">\n<div class=\"text-sm d-flex flex-wrap align-items-center gap-2\">\n[[topic:sort-by]]\n<div class=\"d-flex gap-2\">\n<a href=\"?sort=alpha\" class=\"btn-ghost ff-secondary fw-semibold " + 
      ((guard((context != null) ? context['sort'] : null) == "alpha") ?
        "active" :
        "") + 
      "\">[[groups:details.group-name]]</a>\n<a href=\"?sort=count\" class=\"btn-ghost ff-secondary fw-semibold " + 
      ((guard((context != null) ? context['sort'] : null) == "count") ?
        "active" :
        "") + 
      "\">[[groups:details.member-count]]</a>\n<a href=\"?sort=date\" class=\"btn-ghost ff-secondary fw-semibold " + 
      ((guard((context != null) ? context['sort'] : null) == "date") ?
        "active" :
        "") + 
      "\">[[groups:details.creation-date]]</a>\n</div>\n</div>\n</div>\n<div>\n<div class=\"d-flex justify-content-end gap-2\">\n<div>\n" + 
      (guard((context != null) ? context['allowGroupCreation'] : null) ?
        "\n<button class=\"btn btn-primary btn-sm text-nowrap\" data-action=\"new\"><i class=\"fa fa-users\"></i> [[groups:new-group]]</button>\n" :
        "") + 
      "\n<select class=\"form-select hidden\" id=\"search-sort\">\n<option value=\"alpha\">[[groups:details.group-name]]</option>\n<option value=\"count\">[[groups:details.member-count]]</option>\n<option value=\"date\">[[groups:details.creation-date]]</option>\n</select>\n</div>\n<div>\n<div class=\"input-group\">\n<input type=\"text\" class=\"form-control form-control-sm\" placeholder=\"[[global:search]]\" name=\"query\" id=\"search-text\">\n<button id=\"search-button\" class=\"btn btn-primary btn-sm\" aria-label=\"[[global:search]]\">\n<i class=\"fa fa-search\"></i>\n</button>\n</div>\n</div>\n</div>\n</div>\n</div>\n<hr />\n<div component=\"groups/container\" class=\"row\" id=\"groups-list\" data-nextstart=" + 
      __escape(guard((context != null) ? context['nextStart'] : null)) + 
      ">\n" + 
      (guard((context != null && context['groups'] != null) ? context['groups']['length'] : null) ?
        "\n" + 
          compiled.blocks['groups'](helpers, context, guard, iter, helper) + 
          "\n" :
        "\n<div class=\"col-12\">\n<div class=\"alert alert-warning\">\n[[groups:no-groups-found]]\n</div>\n</div>\n") + 
      "\n</div>\n</div>";
  }

  compiled.blocks = {
    'widgets.header': function widgetsheader(helpers, context, guard, iter, helper) {
      var __escape = helpers.__escape;
      var value = context;
      return iter(guard((context != null && context['widgets'] != null) ? context['widgets']['header'] : null), function each(key0, index, length, value) {
        var key = key0;
        return "\n" + 
          guard((context != null && context['widgets'] != null && context['widgets']['header'] != null && context['widgets']['header'][key0] != null) ? context['widgets']['header'][key0]['html'] : null) + 
          "\n";
      }, function alt() {
        return "";
      });
    },
    'groups': function groups(helpers, context, guard, iter, helper) {
      var __escape = helpers.__escape;
      var value = context;
      return iter(guard((context != null) ? context['groups'] : null), function each(key0, index, length, value) {
        var key = key0;
        return "\n<div class=\"col-xl-4 col-lg-6 col-sm-12 mb-3\" component=\"groups/summary\" data-slug=\"" + 
          __escape(guard((context != null && context['groups'] != null && context['groups'][key0] != null) ? context['groups'][key0]['slug'] : null)) + 
          "\">\n<div class=\"card h-100 group-hover-bg border-0\">\n<a href=\"" + 
          __escape(guard((context != null && context['config'] != null) ? context['config']['relative_path'] : null)) + 
          "/groups/" + 
          __escape(guard((context != null && context['groups'] != null && context['groups'][key0] != null) ? context['groups'][key0]['slug'] : null)) + 
          "\" class=\"card-header border-bottom-0 pointer d-block list-cover\" style=\"" + 
          (guard((context != null && context['groups'] != null && context['groups'][key0] != null) ? context['groups'][key0]['cover:thumb:url'] : null) ?
            "background-image: url(" + 
              __escape(guard((context != null && context['groups'] != null && context['groups'][key0] != null) ? context['groups'][key0]['cover:thumb:url'] : null)) + 
              ");background-size: cover; min-height: 125px; background-position: " + 
              __escape(guard((context != null && context['groups'] != null && context['groups'][key0] != null) ? context['groups'][key0]['cover:position'] : null)) :
            "") + 
          "\" aria-label=\"[[aria:group-page-link-for, " + 
          __escape(guard((context != null && context['groups'] != null && context['groups'][key0] != null) ? context['groups'][key0]['displayName'] : null)) + 
          "]]\"></a>\n<a href=\"" + 
          __escape(guard((context != null && context['config'] != null) ? context['config']['relative_path'] : null)) + 
          "/groups/" + 
          __escape(guard((context != null && context['groups'] != null && context['groups'][key0] != null) ? context['groups'][key0]['slug'] : null)) + 
          "\" class=\"d-block h-100 text-reset text-decoration-none\">\n<div class=\"card-body d-flex flex-column gap-1 border border-top-0 rounded-bottom h-100\">\n<div class=\"d-flex\">\n<div class=\"flex-grow-1 fs-6 fw-semibold\">" + 
          __escape(guard((context != null && context['groups'] != null && context['groups'][key0] != null) ? context['groups'][key0]['displayName'] : null)) + 
          "</div>\n<div class=\"flex-shrink-0 text-sm\"><i class=\"text-muted fa-solid fa-user\"></i> " + 
          __escape(guard((context != null && context['groups'] != null && context['groups'][key0] != null) ? context['groups'][key0]['memberCount'] : null)) + 
          "</div>\n</div>\n<div class=\"text-sm\">" + 
          __escape(guard((context != null && context['groups'] != null && context['groups'][key0] != null) ? context['groups'][key0]['description'] : null)) + 
          "</div>\n</div>\n</a>\n</div>\n</div>\n";
      }, function alt() {
        return "";
      });
    }
  };

  return compiled;
})

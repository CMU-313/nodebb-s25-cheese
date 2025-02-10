
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
    return "<div data-component=\"widget/active-users\" class=\"d-flex flex-wrap gap-1 mb-3\">\n" + 
      compiled.blocks['active_users'](helpers, context, guard, iter, helper) + 
      "\n</div>\n<script type=\"text/javascript\">\n(function() {\nfunction handleActiveUsers() {\nfunction onNewTopic(topic) {\nconst activeUsersEl = $('[data-component=\"widget/active-users\"]');\nconst activeUser = activeUsersEl.find('a[data-uid=\"' + topic.uid + '\"]');\nif (activeUser.length) {\nreturn activeUser.prependTo(activeUsersEl);\n}\napp.parseAndTranslate('widgets/activeusers', 'active_users', {\nrelative_path: config.relative_path,\nactive_users: [topic.user],\n}, function (html) {\nhtml.prependTo(activeUsersEl);\n});\n}\nfunction onAjaxifyEnd() {\nconst activeUsersEl = $('[data-component=\"widget/active-users\"]');\nsocket.removeListener('event:new_topic', onNewTopic);\nif (activeUsersEl.length) {\nsocket.on('event:new_topic', onNewTopic);\n} else {\n$(window).off('action:ajaxify.end', onAjaxifyEnd);\n}\n}\n$(window).on('action:ajaxify.end', onAjaxifyEnd);\n}\nif (document.readyState === 'loading') {\ndocument.addEventListener('DOMContentLoaded', handleActiveUsers);\n} else {\nhandleActiveUsers();\n}\n})();\n</script>";
  }

  compiled.blocks = {
    'active_users': function active_users(helpers, context, guard, iter, helper) {
      var __escape = helpers.__escape;
      var value = context;
      return iter(guard((context != null) ? context['active_users'] : null), function each(key0, index, length, value) {
        var key = key0;
        return "\n<a class=\"text-decoration-none\" data-uid=\"" + 
          __escape(guard((context != null && context['active_users'] != null && context['active_users'][key0] != null) ? context['active_users'][key0]['uid'] : null)) + 
          "\" href=\"" + 
          __escape(guard((context != null) ? context['relative_path'] : null)) + 
          "/user/" + 
          __escape(guard((context != null && context['active_users'] != null && context['active_users'][key0] != null) ? context['active_users'][key0]['userslug'] : null)) + 
          "\">" + 
          __escape(helper(context, helpers, 'buildAvatar', [guard((context != null && context['active_users'] != null) ? context['active_users'][key0] : null), "24px", guard((context != null) ? context['true'] : null), "avatar-tooltip not-responsive"])) + 
          "</a>\n";
      }, function alt() {
        return "";
      });
    }
  };

  return compiled;
})

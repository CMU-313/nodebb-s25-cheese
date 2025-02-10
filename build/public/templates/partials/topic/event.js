
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
    return "<li component=\"topic/event\" class=\"timeline-event text-muted d-flex gap-2 pt-4\" data-topic-event-id=\"" + 
      __escape(guard((context != null) ? context['id'] : null)) + 
      "\" data-topic-event-type=\"" + 
      __escape(guard((context != null) ? context['type'] : null)) + 
      "\">\n<div class=\"timeline-badge\">\n<i class=\"fa " + 
      (guard((context != null) ? context['icon'] : null) ?
        __escape(guard((context != null) ? context['icon'] : null)) :
        "fa-circle") + 
      " small\"></i>\n</div>\n<span class=\"timeline-text small d-flex align-items-center gap-1 flex-wrap\">\n" + 
      __escape(guard((context != null) ? context['text'] : null)) + 
      "\n</span>\n" + 
      ((guard((context != null && context['privileges'] != null) ? context['privileges']['isAdminOrMod'] : null) && guard((context != null) ? context['id'] : null)) ?
        "\n<span component=\"topic/event/delete\" data-topic-event-id=\"" + 
          __escape(guard((context != null) ? context['id'] : null)) + 
          "\" data-topic-event-type=\"" + 
          __escape(guard((context != null) ? context['type'] : null)) + 
          "\" class=\"timeline-text pointer\" title=\"[[topic:delete-event]]\"><i class=\"fa fa-trash\"></i></span>\n" :
        "") + 
      "\n</li>";
  }

  compiled.blocks = {
    
  };

  return compiled;
})

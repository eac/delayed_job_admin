DelayedJob = {};
DelayedJob.UI = {

  tabTo: function(element) {
    element.siblings('.active').removeClass('active');
    element.addClass('active');
  },

  filterJobs: function(tab, selector) {
    this.tabTo($(tab));
    this.bounce('.jobs', function() {
      DelayedJob.UI.filter('.job', selector);
    });
  },

  bounce: function(selector, callback) {
    var element = $(selector);
    element.slideUp(function() {
      callback();
      element.slideDown('slow'); 
    });
  },

  filter: function(selector, filter_selector) {
    if (filter_selector) {
      $(selector).hide();
      selector += filter_selector;
    }
    $(selector).show();
  }
  
};
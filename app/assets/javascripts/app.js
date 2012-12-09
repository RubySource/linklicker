var App = function() {
  this.newLink = ko.observable(new Link());
  this.allLinks = ko.observableArray();
  this.lickedLinks = ko.computed(function() {
    return this.allLinks().filter(function(link) {
      return link.isLicked(); 
    });
  }, this);

  this.newLinks = ko.computed(function() {
    return this.allLinks().filter(function(link) {
      return !link.isLicked(); 
    });
  }, this);
};

App.prototype.createNewLink = function() {

  this.newLink().save(function() {
    this.loadLinks(); 
    this.newLink(new Link());
  }.bind(this));
  return false;
};

App.prototype.loadLinks = function() {
  this.allLinks([]);
  var self = this;

  $.get('/links.json?all=true', function(data) {
    ko.utils.arrayForEach(data, function(model) {
      self.allLinks.push(new Link(model)); 
    });

  });
};

$(function(){
  App.globalApp = new App();
  ko.applyBindings(App.globalApp);

  App.globalApp.loadLinks();
});

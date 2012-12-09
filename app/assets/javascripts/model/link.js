var Link = Model.subclass(function(attrs) {
  var cachedObject = Model.call(this, "link", attrs);
  if (cachedObject) return cachedObject;

  this.url = this.url || ko.observable();
  this.description = this.description || ko.observable();
  this.lickedByCurrentUser = this.lickedByCurrentUser || ko.observable();

  this.isLicked = ko.computed(function() {
    if (this.lickedByCurrentUser() === "true") return true;
    return false;
  }, this);

});

Link.prototype.save = function() {
  var attributes = {
    link: {
      url: this.url(),
      description: this.description()
    }
  };

  $.ajax("/links.json", {
    type: "POST",
    data: attributes,
    complete: function(data){
      App.globalApp.loadLinks();
    }
  });
};

Link.prototype.destroy = function() {
  var url = "/links/" + this.id() + ".json";
  $.ajax(url, {
    type: "DELETE",
    complete: function(data){
      App.globalApp.loadLinks();
    }
  });
};

Link.prototype.lick = function() {
  var url = "/links/" + this.id() + "/lick.json";
  $.ajax(url, {
    type: "POST",
    complete: function(data){
      new Link(JSON.parse(data.responseText));
    }
  });
};

Link.prototype.unlick = function() {
  var url = "/links/" + this.id() + "/unlick.json";
  $.ajax(url, {
    type: "POST",
    complete: function(data){
       this.lickedByCurrentUser("false"); 
    }.bind(this)
  });
};



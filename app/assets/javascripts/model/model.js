var Model = function(className, attrs) {
  this.modelName = className;
  if (!attrs || !attrs.id) return;
  
  var objCache = Model.objectCache[className] || (Model.objectCache[className] = {});

  if (objCache[attrs.id]) {
    objCache[attrs.id].updateData(attrs);
    return objCache[attrs.id];
  }

  objCache[attrs.id] = this;

  this.id = ko.observable();

  ko.mapping.fromJS(attrs, {}, this);
};

Model.objectCache ={};

Model.prototype.updateData = function(data) {
  ko.mapping.fromJS(data, {}, this);
};


Function.prototype.subclass = function(child) {
  var f = function() {};
  f.prototype = this.prototype;
  child.prototype = new f();
  return child;
};

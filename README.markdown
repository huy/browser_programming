## Browser based programming

### Introduction

**Document Object Model - DOM**

Document Object Model is foundation for human - machine interaction via web browser (e.g. IE, Chrome, 
Firefox).  Web browser receives data from server over http protocol e.g. html page. 
The browser must parse data and turn it into DOM data structure, which is a tree with `window.document`
as root. 

Looking at `window.document` in Javascript console of Chrome we can see the tree based structure of an 
html document

        > window.document
         #document
               <!DOCTYPE html>
            <html>
              <head>_</head>
              <body>_</body>
            </html>  

The browser then renders screen based on that DOM data structure. By modification of DOM data 
structure we can change visual effect as well as interactive behaviour of its elements
(what happen when a button is clicked or a key is pressed) . 

The modification of DOM is obviously done by writing a piece of code in a programing language.
As Javascript is de facto standard programming language of browser, it has API to access DOM. 

The API implementation for access DOM is not part of Javascript engine itself but of layout/rendering 
engine (e.g. webkit, gecko) of the browser. Javascript engine in browser just create a thin layer that
facilitate access to DOM API implementation of the layout engine. 

**jQuery and alike**

The DOM API is not very well standard across different browsers so that why various DOM manipulation
javascript libraries (e.g. jQuery, Zepto, Prototype.js) are created to solve this problem. 

These libaries usually provide some additional features addressing to some obstacles of Javascript 
language and enhance its core lib to make programming in browser less pain (e.g. API for Ajax).

**Javascript MVC**

Separation of presentation from domain logic (http://martinfowler.com/bliki/PresentationDomainSeparation.html)
is old proven design principle for developing a serious software. 

As more logic is moved to browser to support more responsiveness and freshness of a single page style application 
(e.g. gmail, google app), in which single button click or hover mouse  would not result in sending a request to 
a server and waiting for response.

Javascript MVC frameworksi(e.g. Backbone, AngularJS, Ember.js) are born to address the chanlenge of developing 
complex browser based Javascript application.

### Backbone

Backbone is Javascript MVC framework, more precisely MV framework because View and Controler roles are combined 
into View. 

Backbone consists of 3 type of objects

* View : part of View layer
* Model : part of Model layer
* Collection : part of Model layer

**DOM vs Model Event**

There is different between DOM event (i.e. View event) and Model event. DOM event is real UI event like mouse clicked 
or key pressed while Model events are invented in order to allow Model to notify View via observer pattern.  DOM events 
are described in http://api.jquery.com/category/events/.

**View**

The View of Backbone can be a starting point of an application, which typically start in `jQuery(document).ready()`
callback

       $(function () {
         ...
         var App = new AppView;
       });

The Backbone View provides DOM event handler in declarative way using `events` attributes 

       var AppView = Backbone.View.extend({
         events: {
           ...
           "click #toggle-all": "toggleAllComplete"
         }
       }; 

The format is `eventname selector: method`, where eventname and selector are from JQuery, which means
call `toggleAllComplete` if we click on DOM element returned by the CSS selector `#toggle-all`. 

see

* http://api.jquery.com/category/selectors/ for JQuery selector

The `initialize` function being called during View construction is usually used to wire View' methods  with 
Model event, i.e.  specify which function of the view get called when the Model fire an event.

     initialize: function () {
       this.model.bind('change', this.render, this);
       this.model.bind('destroy', this.remove, this); // $(view.el).remove();
     }

In the `initialize` we also cache references of  DOM elements so we can make call DOM API easily and faster 
in the View.

     initialize: function () {
       ...
       this.main = $('#main');
     }

A View can associate with DOM element, which exists in `Window.document` e.g.

      var AppView = Backbone.View.extend({
         el : $('#todoapp'),
         ...
      });

or can be created using specified `tagName`. 

      var TodoView = Backbone.View.extend({
         tagName: 'li',
         ...
      });

In that case, DOM element can be later attached to one of existing element of `Window.document`

      var AppView = Backbone.View.extend({
        ...
        addOne: function (todo) {
           var view = new TodoView({model: todo});
           view.render();
           this.$('#todo-list').append(view.el);
        }, 
        ...
      });

**Model Object**

Refer to basic principle (http://martinfowler.com/eaaDev/SeparatedPresentation.html), The presentation (View) 
is able to call a Model but not vice-versa. In order to notify the View about change of the model, observer 
pattern is employed. 

A Model fire predefined events when certain methods get called. Following are predefined events of the Backbone
Model. 

* `set`, `unset`, `clear` fire `change` event
* `validate` fires `error` event if the `validate` return an error
* `destroy` fires `destroy` and `sync` events
* `save` fires `change` and `sync` events
* `fetch` fires `change` event

As seen these events are fairly generic meaning that the Model just represent a pure structured data, a kind of 
anemic model (see http://en.wikipedia.org/wiki/Anemic_domain_model), which may not be optimal design.

So it is important to know that if we want to notify a View about when our method is called, then we need to define 
our own event and fire this event using `trigger(event, [*args])` in the course of the method.

**Collection Object**

Backbone collection belong do Model layer. This is container for Model Object and offers generic methods mainly for
dealing with persistence. A Backbone collection fires the following predefined events 
Model. 

* `add`, `push`, `unshift` fire `add` event
* `remove`, `pop`, `shift` fire `remove` event
* `reset`, `sort` fires `reset` event


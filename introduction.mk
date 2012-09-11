# Browser based programming

**DOM**

DOM - Document Object Model is foundation for human - machine interaction via web browseri 
(e.g. IE, Chrome, Firefox).  Web browser receives data from web server over http protocol e.g. html page. 
The browser must parse data and turn it into DOM data structure. 

The browser then renders screen based on that DOM data structure. By modification of DOM data 
structure we can change visual effect of a page as well as its interaction - customize event's handling. 

The modification of DOM is obviously done by writing a piece of code in a programing language.
The Javascript is de facto standard programming language of browser, it has API to access DOM. 

The API for access DOM is not part of Javascript engine itself but of layout/rendering engine 
(e.g. webkit, gecko) of the browser. Javscript engine in browser just create a thin layer that
facilitate access to DOM API implementation of the layout engine. 

The DOM API is not very well standard across different browsers so that why various DOM manipulation
javascript libraries (e.g. jQuery) are created to solve this problem. These libaries can provide some
additional features addressing to some obstacles of Javascript language and its core lib to make 
programming in browser less painful e.g. API for Ajax.

**Javascript MVC**

Separation of presentation from domain logic (http://martinfowler.com/bliki/PresentationDomainSeparation.html)
is old proven design principle for a serious software. 

More logic are required to implement in a browser to support more responsiveness and freshness of a single 
page style application (e.g. gmail, google app), in which single button click or hover mouse  would not result 
in sending a request to a server and waiting for response.

Javascript MVC frameworksi(e.g. Backbone, AngularJS, Ember.js) are born to address the chanlenge of developing 
complex browser based Javascript application.

Refer to basic principle (http://martinfowler.com/eaaDev/SeparatedPresentation.html), The presentation (View) 
is able to call a Model but not vice-versa although observer pattern can be used so the Model can notify the View 
when it changes. 

**Backbone**

Backbone is Javascript MVC framework, more precisely MV framework because View and Controler roles are combined 
into View.

The View of Backbone is starting point of an application, which typically start in `jQuery(document).ready()`
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

the format is `eventname selector: method`, where eventname and selector are from JQuery. The sematic
is call `toggleAllComplete` if we click on DOM element returned by the selector. 

see

* http://api.jquery.com/category/events/ for JQuery event
* http://api.jquery.com/category/selectors/ for JQuery selector


There is different between DOM event and Model event. DOM event is real UI event like mouse click and key pressed 
while Model events are invented in order to allow Model to notify View via observer pattern. 

Backbone.Model events are 

* change[:attribute]
* sync
* destroy
* error

Backbone.Collection events are 

* add
* remove
* reset

The `initialize` function being called during View construction is usually used to wire View function with 
Model event, i.e.  specify which View' function get called when the Model fire an event.

     initialize: function () {
       this.model.bind('change', this.render, this);
       this.model.bind('destroy', this.remove, this); // $(view.el).remove();
     }

Also used to cache reference of DOM elements to easy call DOM API in its functions.


     initialize: function () {
       ...
       this.main = $('#main');
     }

A View can associate with a existing DOM element e.g.

      var AppView = Backbone.View.extend({
         el : $('#todoapp'),
         ...
      });

or associated DOM element can be created using specified tag. In that case, DOM element can be later attached 
to one of existing element of Window.document

      var TodoView = Backbone.View.extend({
         tagName: 'li',
         ...
      });


      var AppView = Backbone.View.extend({
        ...
        addOne: function (todo) {
           var view = new TodoView({model: todo});
           view.render();
           this.$('#todo-list').append(view.el);
        }, 
        ...
      });

A model fire an event when certain method get called 

* set,unset, clear fire change event
* validate fires event error if the validate return an error event
* destroy fires destroy and sync events
* save fires change and sync events
* fetch fires change event



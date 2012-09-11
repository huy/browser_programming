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
additional features addressing to some obstacles of Javascript language and core lib to make programming 
in browser less painful e.g. API for Ajax.

**Javascript MVC**

Separation of presentation from domain logic (http://martinfowler.com/bliki/PresentationDomainSeparation.html)
is old proven design principle for a serious software. As more logic are required to implement in a browser 
to support more responsiveness and freshness in a single page style application (e.g. gmail, google app), 
Javascript MVC frameworks are born.



# Keeping Up with Events: The Event Loop

Dart apps, like many other apps, have an _event loop_—a construct that waits for and dispatches events or messages. Like any other app, when a Dart app gets these events it must respond quickly, so that the event loop isn't delayed.

For example, a Dart web app must respond to mouse clicks quickly, so that the user doesn't notice any delays in the UI's appearance or responsiveness.

This article covers event loops in both web apps, which use the regular browser event loop, and command-line apps.

#### Contents
* First, some code
* Concepts
   * Events
   * The event queue
   * The event loop
   * Timers
   * Isolates
* Techniques
   * Returning quickly
   * Performing long-running operations in the background
     * No final update
     * Update only at the end
     * Update periodically
* Tips and examples for web apps
* Tips and examples for command-line apps
* Further reading

## First, some code

Here's an example of handling a click on an HTML element:

    void main() {
      // ...
      anElement.on.click.add(handleClick);
      // ...
    }
    
    void handleClick(Event event) {
      // Do something quickly.
    }

That's fine, but what if completely
handling the click might take a long time?
For example, the app might need to perform some significant computation
or to get some data from the web.
In such a case,
the handler must set up a separate worker
to perform the long-running operation in the background.

The Dart solution for background processing is to spawn an
[isolate](http://www.dartlang.org/docs/dart-up-and-running/contents/ch03.html#ch03-dartisolate---concurrency-with-isolates).

    import 'dart:isolate';
    
    void main() {
      // ...
      anElement.on.click.add(handleClick);
      // ...
    }
    
    void handleClick(Event event) {
      // Create an isolate. XXX: Here or in main? Maybe it depends?
      var sendPort = spawnFunction(doWork);
    
      // Send it any data it needs to start working.
      sendPort.call('data').then((results) {
        displayResults(results);
      });
    
      // ...Update the UI to tell the user that the work has started...
    }
    
    void doWork() {
      port.receive(msg, replyTo) {
        // Do some possibly lengthy work here.
        if (replyTo != null) {
          replyTo.send('done!');
      }
    }
    void displayResults(String results) {
      // ...The work is done, so now update the UI to reflect the results.
    }

Note: When a Dart web app is compiled to JavaScript,
the isolate becomes a web worker.
As dartbug.com/4689 says, that didn't used to be true.
{{PENDING: check. remove reference to bug.}}
{{PENDING: I couldn't get an isolate to work in Dartium.
It got created OK, but it never received a message.}}

Another tool you can use is the
[Timer](http://api.dartlang.org/dart_isolate/Timer.html) class.
With a timer, you specify a function
to be called (either once or many times) in the future.


## Concepts

http://ydn.zenfs.com/blogs/*3.jpg

* blocking the event loop is bad
* callbacks, events all go onto event loop
* a single isolate processes the events one by one

### Events

Events: Timers, I/O, sockets, anything in dart:io, isolates you've spawned.

Example: a network server

### The event queue

Picture:

    |click|key|key|click|isolate msg|click|...

### The event loop

### Timers

You specify: Fire, interval, repeating or not, closure to call back.
E.g. 1/second timer.
If one closure takes too long, all other timers are affected;
a repeating Timer doesn't adjust for this, since it can't know
what you want to do if the timer handler takes too long
(process every event as quickly as possible until back on schedule?
coalesce events? ...?)

### Isolates

How many isolates should you have?
That depends on whether your task is compute-intensive or functional.

For compute-intensive tasks, you should generally use as many isolates as you have CPUs available. {PENDING: say how to find out, either here or in the webapp/command-line sections below} Any additional isolates would just be wasted. {PENDING: give example of compute-intensive tasks}

For functional tasks {PENDING: best name?} or cases where you need to ensure that data isn't shared, you can use more isolates. {PENDING: give example}

Isolates have a memory cost, but that's going down. Our goal is to have under 1 MB of overhead per isolate.

[background info: they currently have ~40MB overhead (2MB + heap).]

## Tips and examples for web apps

The DOM/UI/main isolate (what *do* we call it?) is what main() executes on.

Although a web app could use a web worker
([Worker](http://api.dartlang.org/dart_html/Worker.html)), ...

If you're using isolates in a web app, you use the isolate notification mechanism, in addition to DOM events. Isolate msgs go into the same event loop as DOM events, so everything's nicely single-threaded (or whatever we call it).

## Tips and examples for command-line apps

Each command-line app has its own event loop,
which is implemented by the standalone Dart VM.

## Further reading

* [Event loops](http://www.w3.org/TR/20*/WD-html5-20*0329/webappapis.html#event-loops) in the HTML5 specification.

## DON'T INCLUDE

* [Threads](https://developer.mozilla.org/en-US/docs/Code_snippets/Threads) -  moz-specific; discusses window.setTimeout(), mozilla's thread manager, ...

* Info for people who embed Dart into C (e.g. Apache server handler). They need more knowledge, and they so far are low in numbers (2?) and have been able to figure it out for themselves.

nv-ios-html-converter
=====================


Overview
--------

This project contains HTMLConverter class that converts a plain text
into an HTML text.

  * Convert some characters into entity references.
  * Convert newlines to `<br/>` tags.
  * Convert HTTP(S) URLS to `<a>` tags.
  * Convert #hash to `<a href='https://twitter.com/search?q=%23hash'>#hash</a>`.
  * Convert @mention to `<a href='https://twitter.com/mention'>@mention</a>`

HTMLConverter has properties to control conversions above. For example,
Twitter-related conversions are performed only when twitterFlag property
is YES.


License
-------

Apache License, Version 2.0


Download
--------

    git clone https://github.com/TakahikoKawasaki/nv-ios-html-converter.git


Example
-------

    // Create an instance of HTMLConverter.
    HTMLConverter *converter = [[HTMLConverter alloc] init];

    // Turn on the Twitter flag that converts #hash and @mention to
    // <a href='https://twitter.com/search?q=%23hash/'>#hash</a> and
    // <a href='https://twitter.com/mention>@mention</a>, respectively.
    converter.twitterFlag = YES;

    // Prepare an input text.
    NSString *input = @"Hello, I'm @abc and interested in #xyz.\nSee https://example.com/";

    // Convert the plain text into an HTML text using the converter.
    NSString *output = [converter toHTML:input];

    // Now 'output' contains a string below (no newline in the string):
    //
    //   @"Hello, I&apos;m <a href='https://twitter.com/abc'>@abc</a>
    //   and interested in <a href='https://twitter.com/search?q=%23xyz'>#xyz</a>.
    //   <br/>See <a href='https://example.com/'>https://example.com/</a>"


Author
------

Takahiko Kawasaki, Neo Visionaries Inc.

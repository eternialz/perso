# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Article.create(title: "Markdown Example", content: "
        An h1 header
    ============

    Paragraphs are separated by a blank line.

    2nd paragraph. *Italic*, **bold**, and `monospace`. Itemized lists
    look like:

      * this one
      * that one
      * the other one

    Note that --- not considering the asterisk --- the actual text
    content starts at 4-columns in.

    > Block quotes are
    > written like so.
    >
    > They can span multiple paragraphs,
    > if you like.

    Use 3 dashes for an em-dash. Use 2 dashes for ranges (ex., 'it's all
    in chapters 12--14'). Three dots ... will be converted to an ellipsis.
    Unicode is supported. ☺



    An h2 header
    ------------

    Here's a numbered list:

     1. first item
     2. second item
     3. third item

    Note again how the actual text starts at 4 columns in (4 characters
    from the left side). Here's a code sample:

        # Let me re-iterate ...
        for i in 1 .. 10 { do-something(i) }

    As you probably guessed, indented 4 spaces. By the way, instead of
    indenting the block, you can use delimited blocks, if you like:

    ~~~
    define foobar() {
        print 'Welcome to flavor country!';
    }
    ~~~

    (which makes copying & pasting easier). You can optionally mark the
    delimited block for Pandoc to syntax highlight it:

    ~~~python
    import time
    # Quick, count to ten!
    for i in range(10):
        # (but not *too* quick)
        time.sleep(0.5)
        print i
    ~~~



    ### An h3 header ###

    Now a nested list:

     1. First, get these ingredients:

          * carrots
          * celery
          * lentils

     2. Boil some water.

     3. Dump everything in the pot and follow
        this algorithm:

            find wooden spoon
            uncover pot
            stir
            cover pot
            balance wooden spoon precariously on pot handle
            wait 10 minutes
            goto first step (or shut off burner when done)

        Do not bump wooden spoon or it will fall.

    Notice again how text always lines up on 4-space indents (including
    that last line which continues item 3 above).

    Here's a link to [a website](http://foo.bar), to a [local
    doc](local-doc.html), and to a [section heading in the current
    doc](#an-h2-header). Here's a footnote [^1].

    [^1]: Footnote text goes here.

    Tables can look like this:

    size  material      color
    ----  ------------  ------------
    9     leather       brown
    10    hemp canvas   natural
    11    glass         transparent

    Table: Shoes, their sizes, and what they're made of

    (The above is the caption for the table.) Pandoc also supports
    multi-line tables:

    --------  -----------------------
    keyword   text
    --------  -----------------------
    red       Sunsets, apples, and
              other red or reddish
              things.

    green     Leaves, grass, frogs
              and other things it's
              not easy being.
    --------  -----------------------

    A horizontal rule follows.

    ***

    Here's a definition list:

    apples
      : Good for making applesauce.
    oranges
      : Citrus!
    tomatoes
      : There's no 'e' in tomatoe.

    Again, text is indented 4 spaces. (Put a blank line between each
    term/definition pair to spread things out more.)

    Here's a 'line block':

    | Line one
    |   Line too
    | Line tree

    and images can be specified like so:

    ![example image](example-image.jpg 'An exemplary image')

    Inline math equations go in like so: $\omega = d\phi / dt$. Display
    math should get its own line and be put in in double-dollarsigns:

    $$I = \int \rho R^{2} dV$$

    And note that you can backslash-escape any punctuation characters
    which you wish to be displayed literally, ex.: \`foo\`, \*bar\*, etc."
)

Article.create(title: "Markdown Example 2", content: "
    simple-markdown
===============

simple-markdown is a markdown-like parser designed for simplicity
and extensibility.

[Change log](https://github.com/Khan/simple-markdown/releases)

Philosophy
----------

Most markdown-like parsers aim for [speed][marked] or
[edge case handling][CommonMark].
simple-markdown aims for extensibility and simplicity.

[marked]: https://github.com/chjj/marked
[CommonMark]: https://github.com/jgm/CommonMark

What does this mean?
Many websites using markdown-like languages have custom extensions,
such as `@`mentions or issue number linking. Unfortunately, most
markdown-like parsers don't allow extension without
forking, and can be difficult to modify even when forked.
simple-markdown is designed to allow simple addition of
custom extensions without needing to be forked.

At Khan Academy, we use simple-markdown to format
over half of our math exercises, because we need
[markdown extensions][PerseusMarkdown] for math text and
interactive widgets.

[PerseusMarkdown]: https://github.com/Khan/perseus/blob/master/src/perseus-markdown.jsx

simple-markdown is [MIT licensed][LICENSE].

[LICENSE]: https://github.com/Khan/simple-markdown/blob/master/LICENSE

Getting started
---------------

First, let's parse and output some generic markdown using
simple-markdown.

If you want to run these examples in
node, you should run `npm install` in the simple-markdown
folder or `npm install simple-markdown` in your project's
folder. Then you can acquire the `SimpleMarkdown` variable
with:

```javascript
    var SimpleMarkdown = require('simple-markdown');
```

Then let's get a basic markdown parser and outputter.
`SimpleMarkdown` provides default parsers/outputters for
generic markdown:

```javascript
    var mdParse = SimpleMarkdown.defaultBlockParse;
    var mdOutput = SimpleMarkdown.defaultOutput;
```

`mdParse` can give us a syntax tree:

```javascript
    var syntaxTree = mdParse('Here is a paragraph and an *em tag*.');
```

Let's inspect our syntax tree:

```javascript
    // pretty-print this with 4-space indentation:
    console.log(JSON.stringify(syntaxTree, null, 4));
    => [
        {
            'content': [
                {
                    'content': 'Here is a paragraph and an ',
                    'type': 'text'
                },
                {
                    'content': [
                        {
                            'content': 'em tag',
                            'type': 'text'
                        }
                    ],
                    'type': 'em'
                },
                {
                    'content': '.',
                    'type': 'text'
                }
            ],
            'type': 'paragraph'
        }
    ]
```

Then to turn that into an array of React elements, we can
call `mdOutput`:

```javascript
    mdOutput(syntaxTree)
    => [ { type: 'div',
        key: null,
        ref: null,
        _owner: null,
        _context: {},
        _store: { validated: false, props: [Object] } } ]
```


Adding a simple extension
-------------------------

Let's add an underline extension! To do this, we'll need to create
a new rule and then make a new parser/outputter. The next section
will explain how all of these steps work in greater detail. (To
follow along with these examples, you'll also need
[underscore][underscore].)

[underscore]: http://underscorejs.org/

First, we create a new rule. We'll look for double underscores
surrounding text.

We'll put underlines right
before `em`s, so that `__` will be parsed before `_`
for emphasis/italics.

A regex to capture this would look something
like `/^__([\s\S]+?)__(?!_)/`. This matches `__`, followed by
any content until it finds another `__` not followed by a
third `_`.

```javascript
    var underlineRule = {
        // Specify the order in which this rule is to be run
        order: SimpleMarkdown.defaultRules.em.order - 0.5,

        // First we check whether a string matches
        match: function(source) {
            return /^__([\s\S]+?)__(?!_)/.exec(source);
        },

        // Then parse this string into a syntax node
        parse: function(capture, parse, state) {
            return {
                content: parse(capture[1], state)
            };
        },

        // Finally transform this syntax node into a
        // React element
        react: function(node, output) {
            return React.DOM.u(null, output(node.content));
        },

        // Or an html element:
        // (Note: you may only need to make one of `react:` or
        // `html:`, as long as you never ask for an outputter
        // for the other type.)
        html: function(node, output) {
            return '<u>' + output(node.content) + '</u>';
        },
    };
```

Then, we need to add this rule to the other rules:

```javascript
    var rules = _.extend({}, SimpleMarkdown.defaultRules, {
        underline: underlineRule
    });
```

Finally, we need to build our parser and outputters:

```javascript
    var rawBuiltParser = SimpleMarkdown.parserFor(rules);
    var parse = function(source) {
        var blockSource = source + '\n\n';
        return rawBuiltParser(blockSource, {inline: false});
    };
    // You probably only need one of these: choose depending on
    // whether you want react nodes or an html string:
    var reactOutput = SimpleMarkdown.reactFor(SimpleMarkdown.ruleOutput(rules, 'react'));
    var htmlOutput = SimpleMarkdown.htmlFor(SimpleMarkdown.ruleOutput(rules, 'html'));
```

Now we can use our custom `parse` and `output` functions to parse
markdown with underlines!

```javascript
    var syntaxTree = parse('__hello underlines__');
    console.log(JSON.stringify(syntaxTree, null, 4));
    => [
        {
            'content': [
                {
                    'content': [
                        {
                            'content': 'hello underlines',
                            'type': 'text'
                        }
                    ],
                    'type': 'underline'
                }
            ],
            'type': 'paragraph'
        }
    ]

    reactOutput(syntaxTree)
    => [ { type: 'div',
        key: null,
        ref: null,
        _owner: null,
        _context: {},
        _store: { validated: false, props: [Object] } } ]

    htmlOutput(syntaxTree)

    => '<div class='paragraph'><u>hello underlines</u></div>'
```


Basic parsing/output API
------------------------

#### `SimpleMarkdown.defaultBlockParse(source)`

Returns a syntax tree of the result of parsing `source` with the
default markdown rules. Assumes a block scope.

#### `SimpleMarkdown.defaultInlineParse(source)`

Returns a syntax tree of the result of parsing `source` with the
default markdown rules, where `source` is assumed to be inline text.
Does not emit `<p>` elements. Useful for allowing inline markdown
formatting in one-line fields where paragraphs, lists, etc. are
disallowed.

#### `SimpleMarkdown.defaultImplicitParse(source)`

Parses `source` as block if it ends with `\n\n`, or inline if not.

#### `SimpleMarkdown.defaultOutput(syntaxTree)`

Returns React-renderable output for `syntaxTree`.

*Note: raw html output will be coming soon*


Extension Overview
------------------

Elements in simple-markdown are generally created from rules.
For parsing, rules must specify `match` and `parse` methods.
For output, rules must specify a `react` or `html` method
(or both), depending on which outputter you create afterwards.

Here is an example rule, a slightly modified version of what
simple-markdown uses for parsing **strong** (**bold**) text:

```javascript
    strong: {
        match: function(source, state, lookbehind) {
            return /^\*\*([\s\S]+?)\*\*(?!\*)/.exec(source);
        },
        parse: function(capture, recurseParse, state) {
            return {
                content: recurseParse(capture[1], state)
            };
        },
        react: function(node, recurseOutput) {
            return React.DOM.strong(null, recurseOutput(node.content));
        },
        html: function(node, recurseOutput) {
            return '<strong>' + recurseOutput(node.content) + '</strong>';
        },
    },
```

Let's look at those three methods in more detail.

#### `match(source, state, lookbehind)`

simple-markdown calls your `match` function to determine whether the
upcoming markdown source matches this rule or not.

`source` is the upcoming source, beginning at the current position of
parsing (source[0] is the next character).

`state` is a mutable state object to allow for more complicated matching
and parsing. The most common field on `state` is `inline`, which all of
the default rules set to true when we are in an inline scope, and false
or undefined when we are in a block scope.

`lookbehind` is the string previously captured at this parsing level, to
allow for lookbehind. For example, lists check that lookbehind ends with
`/^$|\n *$/` to ensure that lists only match at the beginning of a new
line.

If this rule matches, `match` should return an object, array, or
array-like object, which we'll call `capture`, where `capture[0]`
is the full matched source, and any other fields can be used in the
rule's `parse` function. The return value from `Regexp.prototype.exec`
fits this requirement, and the common use case is to return the result
of `someRegex.exec(source)`.

If this rule does not match, `match` should return null.

NOTE: If you are using regexes in your match function, your regex
should always begin with `^`. Regexes without leading `^`s can
cause unexpected output or infinite loops.

#### `parse(capture, recurseParse, state)`

`parse` takes the output of `match` and transforms it into a syntax
tree node object, which we'll call `node` here.

`capture` is the non-null result returned from match.

`recurseParse` is a function that can be called on sub-content and
state to recursively parse the sub-content. This returns an array.

`state` is the mutable state threading object, which can be examined
or modified, and should be passed as the third argument to any
`recurseParse` calls.

For example, to parse inline sub-content, you can add `inline: true`
to state, or `inline: false` to force block parsing (to leave the
parsing scope alone, you can just pass `state` with no modifications).
For example:

```javascript
    var innerText = capture[1];
    recurseParse(innerText, _.defaults({
        inline: true
    }, state));
```

`parse` should return a `node` object, which can have custom fields
that will be passed to `output`, below. The one reserved field is
`type`, which designates the type of the node, which will be used
for output. If no type is specified, simple-markdown will use the
current rule's type (the common case). If you have multiple ways
to parse a single element, it can be useful to have multiple rules
that all return nodes of the same type.

#### `react(node, recurseOutput, state)`

`react` takes a syntax tree `node` and transforms it into
React-renderable output.

`node` is the return value from `parse`, which has a type
field of the same type as the current rule, as well as any
custom fields created by `parse`.

`recurseOutput` is a function to recursively output sub-tree
nodes created by using `recurseParse` in `parse`.

`state` is the mutable state threading object, which can be
examined or modified, and should be passed as the second
argument to any recurseOutput calls.

The simple-markdown API contains several helper methods for
creating rules, as well as methods for creating parsers and
outputters from rules.

Extension API
-------------

simple-markdown includes access to the default list of rules,
as well as several functions to allow you to create parsers and
outputters from modifications of those default rules, or even
from a totally custom rule list.

These functions are separated so that you can customize
intermediate steps in the parsing/output process, if necessary.

#### `SimpleMarkdown.defaultRules`

The default rules, specified as an object, where the keys are
the rule types, and the values are objects containing `order`,
`match`, `parse`, `react`, and `html` fields (these rules can
be used for both parsing and outputting).

#### `SimpleMarkdown.parserFor(rules)`

Takes a `rules` object and returns a parser for the rule types
in the rules object, in order of increasing `order` fields,
which must be present and a finite number for each rule.
In the case of order field ties, rules are ordered
lexicographically by rule name. Each of the rules in the `rules`
object must contain a `match` and a `parse` function.

#### `SimpleMarkdown.ruleOutput(rules, key)`

Takes a `rules` object, containing an `output` function for
each rule, and a `key` into individual elements in that rules
rules argument (either `'react''` or `'html'`, unless you are
defining a custom output type), and returns a function that can
output a single syntax tree node of any type that is in the
`rules` object, given a node and a recursive output function.
This is not the final output function because it doesn't handle
arrays of nodes or recursion (see `reactFor` and `htmlFor`).

#### `SimpleMarkdown.reactFor(singleNodeOutputFunction)`

Takes a function that can output react-renderable output for
any single syntax tree node and returns a function that maps
over syntax tree arrays correctly.

The most common use case is to pass the output of
`ruleOutput` as the parameter to `reactFor`:

```javascript
    var output = SimpleMarkdown.reactFor(SimpleMarkdown.ruleOutput(rules, 'react'));
```

#### `SimpleMarkdown.htmlFor(singleNodeOutputFunction)`

Takes a function that can output an html string for
any single syntax tree node and returns a function that maps
over syntax tree arrays correctly.

The most common use case is to pass the output of
`ruleOutput` as the parameter to `htmlFor`:

```javascript
    var output = SimpleMarkdown.htmlFor(SimpleMarkdown.ruleOutput(rules, 'html'));
```

#### Putting it all together

Given a set of rules, one can create a single function
that takes an input content string and outputs a
React-renderable as follows. Note that since many rules
expect blocks to end in `'\n\n'`, we append that to source
input manually, in addition to specifying `inline: false`
(`inline: false` is technically optional for all of the
default rules, which assume `inline` is false if it is
undefined).

```javascript
    var rules = SimpleMarkdown.defaultRules; // for example

    var parser = SimpleMarkdown.parserFor(rules);
    var reactOutput = SimpleMarkdown.reactFor(SimpleMarkdown.ruleOutput(rules, 'react'));
    var htmlOutput = SimpleMarkdown.reactFor(SimpleMarkdown.ruleOutput(rules, 'html'));

    var blockParseAndOutput = function(source) {
        // Many rules require content to end in \n\n to be interpreted
        // as a block.
        var blockSource = source + '\n\n';
        var parseTree = parser(blockSource, {inline: false});
        var outputResult = htmlOutput(parseTree);
        // Or for react output, use:
        // var outputResult = reactOutput(parseTree);
        return outputResult;
    };
```

Extension rules helper functions
--------------------------------

*Coming soon*

LICENSE
-------
MIT. See the LICENSE file for text.
"
)

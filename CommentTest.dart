/**
 * Library comments work only for the old library syntax (#library),
 * not the new one.
 */
//#library('comment_test');
library comment_test;

/**
 * An example that exercises doc comments.
 * 
 * This page shows Dartdoc markup,
 * along with conventions for documenting Dart.
 * Dartdoc markup is defined in section 15.1.2 of the
 * [Dart Language Specification](http://www.dartlang.org/docs/spec/).
 * 
 * **Note:**
 * Dartdoc ignores HTML markup such as <p>.
 * 
 * 
 * ## Doc formatting 
 * 
 * To indicate a paragraph break, use a blank line.
 * 
 * **Terminology note:**
 * Even "blank" lines usually have characters on them.
 * For block doc comments
 * each line conventionally begins with a `*` surrounded by spaces.
 * In a block of `///` comments,
 * even "blank" lines start with `///`.
 *
 * Headers start with `##`.
 * (`###` for subheads appears to be implemented but isn't in the spec.)
 *
 * To add a code block, use a blank line and then
 * one or more lines of 5-space indented code.
 * 
 *     // A code sample
 *     doSomething();
 *    
 * ### Inline formatting
 *  
 * You can put *asterisks* (`*`) or _underscores_ (`_`) around
 * a section of text to italicize it.
 * To get `code font`, use backquotes (```).
 * **Bold font** is unofficially supported using double asterisks
 * or double underscores.
 * 
 * **Guideline:** Use inline formatting sparingly—only to avoid
 * confusion or to emphasize what's important.
 * 
 * Use braces (`[...]`) to link to identifiers (classes, methods, ...).
 * Examples:
 * [comment_test],
 * [CommentTester], [CommentTester.withNumber],
 * [SubTester], [aNumber], and
 * [doSomething] but not [doSomething()].
 * To link to a constructor, add a `new` inside the braces:
 * [new CommentTester], [new CommentTester.withNumber],
 * [new SubTester].
 * 
 * For other links, specify the absolute URI and (optionally)
 * the link text.
 * To specify the link text, use
 * `[s](uri)`—for example, [Dart homepage](http://dartlang.org).
 * To just show the URL, use `<...>`—for example, <http://dartlang.org>.
 * 
 * ### Lists
 * 
 * Here's a bulleted list:
 * 
 * * A list item
 * * Another list item
 * 
 * Specify sublists using 4-space indentation.
 * Put a blank line before the sublist.
 *
 *   * A list item (2-space indentation)
 * * A list item (0-space indentation)
 * * Another list item
 *
 *     * A sublist (4-space indentation)
 *     * Another sublist item:
 *       Indented text becomes part of the item,
 *       and converts the item into a paragraph.
 *     * And another sublist item:
 *       
 *         Use a blank line before indented text to get a
 *         separate paragraph in a list item.
 *
 * Here's a numbered list.
 * 
 * 1. First item
 * 2. Second item
 * 1. Third item
 * 
 * 
 * ## Conventions
 * 
 * See also:
 *
 * * [Documentation: The dart:io section of the Library Tour](http://www.dartlang.org/docs/dart-up-and-running/ch03.html#ch03-dartio---file-and-socket-io-for-command-line-apps)
 * * [Article: An Introduction to the dart:io Library](http://www.dartlang.org/articles/io/)
 * 
 * ## Questions
 * 
 * * How do you escape special characters such as a backquote,
 * especially when followed by a character such as a question mark ``` ?
 * If you use triple backquotes,
 * the ``` is outside the <code> element.
 * 
 * * How do you escape comment-start characters (in or outside of a code block)?
 *   
 * 
 * ## To dos
 * 
 * * Update this doc to reflect `///`.
 * * File bugs for formatting issues.
 *   
 * ## Bugs
 *   
 * ### Spec
 * 
 * * How are you supposed to get *bold font*? I expected either asterisks (`*`)
 * or doubled asterisks (`**`) and doubled underlines (`__`).
 * The spec says single `*` and `_` are for emphasis, which means
 * <em> to me.
 * 
 * * The spec says the number is exactly what you enter in the comment,
 * but the third ordered list item has "1." in the markup
 * yet "3." in the output. (I like the implementation better than
 * the spec.)
 *      
 * * The spec doesn't say anything about indents working
 * (either for code blocks or for indented text)
 * but they do (yay).
 * 
 * * The spec doesn't say anything about ###,
 * but it works (yay).
 * 
 * * It'd be nice to be able to define anchors
 * so I could point to them from method descriptions.
 * (e.g., there's a concept or code that relates to multiple methods.
 * I'd like to put it in a section of the class description
 * and link to it from the relevant methods.)
 * 
 * * Could we some markup for notes and warnings?
 * 
 * 
 * ### Parser
 * 
 * * Treats `**` or `__` as bold, which isn't in the spec.
 * 
 * * According to the spec [CommentTester] should link to the class,
 * not the constructor.
 * 
 * * Code samples shouldn't need a leading `*` to work.
 * (I got one to work without the leading `*`, but usually they don't work.)
 * 
 * * It'd be nice not to need a blank line before a bulleted list—to
 * have a bulleted list automatically end the previous paragraph.
 * It seems like you need a blank line before an indented bulleted list,
 * as well.
 * 
 * * List items on multiple lines are autoconverted to paragraphs,
 * which is a shame. Example:
 * 
 *     * list item on one line
 *     * list item on
 * [multiple lines](http://www.dartlang.org/docs/dart-up-and-running/)
 *     * list item on one line
 * 
 * *  When putting a paragraph under a sublist item,
 *    6 spaces is not enough, although it should be (visually);
 *    8 is required for a second-level bullet.
 * 
 * 
 * ### HTML
 * 
 * * `<pre>` blocks are `<pre><code>`, which seems redundant.
 * 
 * * [new CommentTester] correctly links to the constructor,
 * but it shouldn't have "new " in the output.
 *
 * * Adjacent `///` lines are missing spaces between the lines in
 *   generated output. (See [new CommentTester].)
 * 
 * 
 * ### CSS/formatting
 * 
 * * Paragraphs don't have enough space above them
 * when following a non-paragraph such as a heading or list.
 * 
 * * The first line of a <pre> section has extra space at the beginning.
 * 
 * ### Dart Editor
 * 
 * * Dart Editor doesn't always add a * when you
 * press Return/Enter while in the midst of a comment line.
 * 
 * 
 * ## Testing
 *
 *     // Code comment with leading `*` 
       // Code comment without leading `*`
 */
class CommentTester {
  /// This doc comment for aNumber does NOT show up.
  ///
  /// See: [http://dartbug.com/8222](bug #8222)
  int aNumber;
  
  int _a;
  int _b;

  /// This doc comment on a's getter shows up fine,
  /// and can cover both the getter and the setter.
  /// Compare this to the getter-less [aNumber]
  /// (any visible doc comment there?) and to [b],
  /// which has comments on both the getter and the setter.
  int get a => _a;
      set a(int value) => _a = value;

  
  /**
   * This is a comment on b's getter.
   */
  int get b => _b;
  
  /**
   * This, unfortunately, is a comment on b's setter.
   * Don't do this!
   *
   * **Note:** It's better to comment only on the getter,
   * so the docs for the property will be all in one place.
   */
  set b(int value) => _b = value;

  /// Creates a new CommentTester with aNumber set to 0.
  ///
  /// This method's doc uses the `///` form of doc comment.
  /// Adjacent `///` lines become
  /// a single doc comment block. 
  /// Adding a space at the end of the line
  ///  (or 2 spaces after the `///`)
  ///  is a workaround for a bug in the HTML generation.
  CommentTester() {
    aNumber = 0;
  }
  
  /// This is the doc comment for CommentTester.withNumber.
  CommentTester.withNumber(this.aNumber);
  
  /// This is the doc comment for doSomething().
  void doSomething() {
    print('The number is $aNumber.');
  }
  
}

/// This is the doc comment for the SubTester class.
class SubTester extends CommentTester {
  SubTester();
}

void main() {
  new CommentTester.withNumber(11).doSomething();
}

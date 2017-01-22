# What ?

An ASCII art piece, symbolizing themes/values of [Founders & Coders](http://www.foundersandcoders.com/)

# Why ?

- to make a shrine for me ol' coding school innit
- to practice CSS centering and animations

# How ?

1. A global array of keywords is created, then a collection random words are strung together to form a long string.
2. A global object holds 'stroke styles' i.e. rules which should apply to certain lines of text
3. A style function takes strings, and a stroke style, then converts the string into a HTML span element (stringified)
4. The string is split, each line is mapped via the style function and its corresponding stroke style.
5. The string is joined together then inserted as inner html to the ouput element in the DOM.
6. CSS styles are applied to the populated span elements and their color classes.

# Next Steps

- Make an API request to Github to retrieve issue data from the founders and coders repository.
- Extract *common* keywords and store in an array, instead of a static array, to load the application with.
- ~~Build project in Elm, a purely functional front-end programming language to compile to HTML and JavaScript.~~

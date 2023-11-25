; From https://github.com/uben0/tree-sitter-typst
; MIT License
; 
; Copyright (c) 2023 Gerbais-Nief Eddie
; 
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
; 
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
; 
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.



(field "." @punctuation)
"assign" @punctuation
["," ";" ".." ":" "sep"] @punctuation.delimiter
["(" ")" "{" "}"] @punctuation.bracket
(escape) @constant.character.escape

"end" @operator
"#" @operator
(math "$" @operator)

; MARKUP
(linebreak) @constant.builtin
(letter) @constant.character
(align) @operator
(quote) @markup.quote
(symbol) @constant.character
(strong) @markup.bold
(emph) @markup.italic
(url) @tag
(heading ["=" "==" "===" "====" "====="] @markup.heading.marker) @markup.heading
(term ["/" ":"] @markup.list)
(item "-" @markup.list)

; VALUE
(ident) @variable
(auto) @constant.builtin
(none) @constant.builtin
(builtin) @constant.builtin
(bool) @constant.builtin.boolean
(content ["[" "]"] @operator)
(string) @string
(number) @constant.numeric
(ref) @tag
(label) @tag
(raw_blck lang: (ident) @tag)
(raw_span "`" @operator) @markup.raw.block
(raw_blck "```" @operator) @markup.raw.block
(call item: (builtin) @function.builtin)

; OPERATOR
(wildcard) @operator
(attach ["^" "_"] @operator)
(fac "!" @operator)
(fraction "/" @operator)
(cmp ["==" "<=" ">=" "!=" "<" ">"] @operator)
(div "/" @operator)
(mul "*" @operator)
(sub "-" @operator)
(add "+" @operator)
(sign ["+" "-"] @operator)
(not "not" @keyword.operator)
(or "or" @keyword.operator)
(and "and" @keyword.operator)
(in ["in" "not"] @keyword.operator)

; CONTROL
(flow ["break" "continue"] @keyword.control)
(return "return" @keyword.control)
(set "set" @keyword.control)
(show "show" @keyword.control)
(include "include" @keyword.control.import)
(as "as" @keyword.operator)
(import "import" @keyword.control.import)
(for ["for" "in"] @keyword.control.repeat)
(while "while" @keyword.control.repeat)
(branch ["if" "else"] @keyword.control.conditional)
(let "let" @keyword.storage.type)

(comment) @comment
(field field: (ident) @tag)
(tagged field: (builtin) @text)
(tagged field: (ident) @text)
(call item: (field field: (ident) @function.method))
(call item: (ident) @function)

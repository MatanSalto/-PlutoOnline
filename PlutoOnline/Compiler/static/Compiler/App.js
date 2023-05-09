import {DFA} from './DFA.js';

function highlightCode(code) {
    // Replace this function with your own tokenizer
    // background: url(http://i.imgur.com/HlfA2is.gif) bottom repeat-x;
    const dfa = new DFA();
    const tokens = dfa.tokenize(code);
    let highlightedCode = [];
    tokens.forEach(token => {
        let style = ""
        switch (token.value) {
            case -1:
                style += "color: white;"
                break;
            case 0:
                style += "color: #2596be;"
                break;
            case 1:
                style += "color: white;"
                break;
            case 2:
                style += "color: white;"
                break;
            case 3:
                style += "color: #96aa8b;"
                break;
            case 4:
                style += "color: #c39366;"
                break;
            case 5:
                style += "color: #45A9F9;"
                break;
            case 6:
                style += "color: #c39366;"
                break;
            case 7:
                style += "color: #BBBBBB;"
                break;
            case 8:
                style += "color: #628b4e;"
                break;
        }
      highlightedCode.push({style:style, word: token.word});
    });
    console.log(tokens)
    return highlightedCode;
}
  

const codeTextarea = document.getElementById("code");
const codeDisplay = document.getElementById("highlighted");


document.getElementById('code').addEventListener('keydown', function(e) {
    if (e.key == 'Tab') {
      e.preventDefault();
      var start = this.selectionStart;
      var end = this.selectionEnd;
  
      // set textarea value to: text before caret + tab + text after caret
      this.value = this.value.substring(0, start) +
        "\t" + this.value.substring(end);
  
      // put caret at right position again
      this.selectionStart =
        this.selectionEnd = start + 1;
    }
  });


codeTextarea.addEventListener("input", () => {
    const rows = codeTextarea.value.split('\n').length;
    const lineHeight = parseInt(getComputedStyle(codeTextarea).lineHeight);
    codeTextarea.style.height = `${rows * lineHeight}px`;
    const code = codeTextarea.value;
    const highlightedCode = highlightCode(code);
    codeDisplay.innerHTML = ''
    highlightedCode.forEach(element => {
        var newDiv = document.createElement("span");
        newDiv.setAttribute("style", element.style)
        newDiv.innerHTML = element.word;   
        codeDisplay.appendChild(newDiv)
    });
});

codeTextarea.addEventListener('scroll', function() {
    codeDisplay.style.top = -codeTextarea.scrollTop + 'px';
    codeDisplay.scrollTop = codeTextarea.scrollTop;

  });

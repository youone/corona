const jsdom = require("jsdom");
const fs = require("fs");
const {JSDOM} = jsdom;


let newHtml = `
<html>
<header>
    <style>
        blockquote {
            background-color: lightgrey;
            padding: 5px;
        }
    </style>
</header>
<body>
`


for (i=0; i<290; i++) {
    const html = fs.readFileSync(`viewtopic.php?f=10&t=32806&start=${i*15}`, 'utf8');

    const dom = new JSDOM(html);
    const $ = (require('jquery'))(dom.window);

    $(".author").each((a,b) => {
    
        console.log('..........');
        console.log($(b).find('.username').html());
        if ($(b).find('.username').html() === 'pwm') {
            newHtml += `
            <div style="border: 1px solid black; margin: 5px; padding: 5px">
            <div>${i*15} ${'USER'}</div>
            ${$(b).next().html()}
            </div>
            `;
        }
        
    })
    
}

newHtml += '</body></html>'


fs.writeFileSync(`out.html`, newHtml, 'utf8');

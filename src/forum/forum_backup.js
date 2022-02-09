const path = require('path');
const wget = require('node-wget');
const {execSync} = require("child_process");

function wait(ms)
{
    var d = new Date();
    var d2 = null;
    do { d2 = new Date(); }
    while(d2-d < ms);
}

for (let i=336*15; i<=336*15; i+=15) {
    console.log(`https://forum.vof.se/viewtopic.php?f=10&t=32806&start=${i}`);
    wget({url: `https://forum.vof.se/viewtopic.php?f=10&t=32806&start=${i}`, dest: `./start_${i}.html`})
    wait(2000)
}
// for (let i=4395; i<=336*15; i+=15) {
//     console.log(`https://forum.vof.se/viewtopic.php?f=10&t=32806&start=${i}`);
//     // execSync(`wget --no-check-certificate 'https://forum.vof.se/viewtopic.php?f=10&t=32806&start=${i}'`);
//     // wget(`https://forum.vof.se/viewtopic.php?f=10&t=32806&start=${i}`);
//     wget({url: `https://forum.vof.se/viewtopic.php?f=10&t=32806&start=${i}`, dest: `./start_${i}.html`});
//     wait(2000)
// }

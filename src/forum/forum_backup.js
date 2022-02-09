const path = require('path');
const {execSync} = require("child_process");

function wait(ms)
{
    var d = new Date();
    var d2 = null;
    do { d2 = new Date(); }
    while(d2-d < ms);
}

// for (let i=0; i<=3885; i+=15) {
for (let i=3765; i<=292*15; i+=15) {
    console.log(i);
    execSync(`wget --no-check-certificate 'https://forum.vof.se/viewtopic.php?f=10&t=32806&start=${i}'`);
    wait(2000)
}

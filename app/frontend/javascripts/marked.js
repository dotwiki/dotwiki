import Marked from 'marked'
// import Insane from 'insane'

let md = document.getElementById('markdown').innerHTML
document.getElementById('markdown').innerHTML = Marked(md)

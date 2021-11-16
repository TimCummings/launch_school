let nav = document.querySelector('nav');
let main = document.querySelector('main');

main.insertAdjacentElement('beforebegin', nav.parentElement);

nav.insertAdjacentElement('beforebegin', main.querySelector('h1'));

let [ babyMopFigure, chinStickFigure ] = main.querySelectorAll('figure');
let chinStickCaption = babyMopFigure.lastElementChild;
let babyMopCaption = chinStickFigure.lastElementChild;

chinStickFigure.replaceChild(chinStickCaption, babyMopCaption);
babyMopFigure.appendChild(babyMopCaption);

document.querySelector('article').appendChild(chinStickFigure);
document.querySelector('article').appendChild(babyMopFigure);

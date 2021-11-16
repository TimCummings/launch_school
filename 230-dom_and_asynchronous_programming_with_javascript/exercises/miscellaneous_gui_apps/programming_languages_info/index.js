const languages = [
  {
    name: 'Ruby',
    description: 'Ruby is a dynamic, reflective, object-oriented, ' +
    'general-purpose programming language. It was designed and developed in the mid-1990s ' +
    'by Yukihiro Matsumoto in Japan. According to its creator, Ruby was influenced by Perl, ' +
    'Smalltalk, Eiffel, Ada, and Lisp. It supports multiple programming paradigms, ' +
    'including functional, object-oriented, and imperative. It also has a dynamic type ' +
    'system and automatic memory management.'
  },

  {
    name: 'JavaScript',
    description: 'JavaScript is a high-level, dynamic, untyped, and interpreted ' +
    'programming language. It has been standardized in the ECMAScript language ' +
    'specification. Alongside HTML and CSS, JavaScript is one of the three core ' +
    'technologies of World Wide Web content production; the majority of websites employ ' +
    'it, and all modern Web browsers support it without the need for plug-ins. JavaScript ' +
    'is prototype-based with first-class functions, making it a multi-paradigm language, ' +
    'supporting object-oriented, imperative, and functional programming styles.'
  },

  {
    name: 'Lisp',
    description: 'Lisp (historically, LISP) is a family of computer programming languages ' +
    'with a long history and a distinctive, fully parenthesized prefix notation. ' +
    'Originally specified in 1958, Lisp is the second-oldest high-level programming ' +
    'language in widespread use today. Only Fortran is older, by one year. Lisp has changed ' +
    'since its early days, and many dialects have existed over its history. Today, the best ' +
    'known general-purpose Lisp dialects are Common Lisp and Scheme.'
  }
];

function articleTemplate(data) {
  const article = document.createElement('article');
  article.append(
    headingTemplate(data.name),
    paragraphTemplate(data.description),
    buttonTemplate(),
  );

  return article;
}

function headingTemplate(content) {
  const heading = document.createElement('h2');
  heading.textContent = content;
  return heading;
}

function paragraphTemplate(content) {
  const paragraph = document.createElement('p');
  paragraph.textContent = content.slice(0, 120);

  const remaining = document.createElement('span');
  remaining.textContent = content.slice(120, -1);
  remaining.classList.add('hidden');
  paragraph.append(remaining);

  const placeholder = document.createElement('span');
  placeholder.textContent = '...';
  paragraph.append(placeholder);

  return paragraph;
}

function buttonTemplate() {
  const button = document.createElement('button');
  button.type = 'button';
  button.textContent = 'Show More';
  return button;
}

function toggleFullArticle(article) {
  const remaining = article.querySelector('span');
  const placeholder = article.querySelector('span + span');
  const button = article.querySelector('button');

  const hidden = remaining.classList.toggle('hidden');
  placeholder.classList.toggle('hidden');

  if (hidden) {
    button.textContent = 'Show More';
  } else {
    button.textContent = 'Show Less';
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const main = document.querySelector('main');

  main.addEventListener('click', event => {
    if (!event.target.matches('article button')) return;

    toggleFullArticle(event.target.parentElement);
  });

  languages.forEach(language => {
    main.append(articleTemplate(language));
  });
});

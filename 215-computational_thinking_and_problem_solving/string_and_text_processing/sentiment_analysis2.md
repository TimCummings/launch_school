
# Sentiment Analysis 2 - 11/19/2020

Re-implement the sentiment analysis with regex-based positive and negative word lists. The use of regex to process *text-based* data is extremely powerful. In the previous practice problem, we did not count words that were just different forms of the words in the positive and negative word lists. For instance, we didn't count "scorns" since it isn't an *exact* match for "scorn".

We could add the variations of each word; for example: fortune --> fortunes, respect --> respected, oppress --> oppressed, or death --> deaths. This works, but we can use regex to make the relationship between variants more evident:

Example

```javascript
let positiveRegex = /\bfortunes?\b|\bdream(s|t|ed)?\b|love(s|d)?\b|respect(s|ed)?\b|\bpatien(ce|t)?\b|\bdevout(ly)?\b|\bnobler?\b|\bresolut(e|ion)?\b/gi;
let negativeRegex = /\bdie(s|d)?\b|\bheartached?\b|death|despise(s|d)?\b|\bscorn(s|ed)?\b|\bweary\b|\btroubles?\b|\boppress(es|ed|or('s)?)?\b/gi;

function sentiment(text) {
  // ...
}

sentiment(textExcerpt);

// console output

There are 9 positive type words in the text.
Positive sentiments: nobler, fortune, devoutly, dream, dreams, respect, love, patient, resolution

There are 10 negative type words in the text.
Negative sentiments: troubles, die, heartache, die, death, scorns, oppressor's, despised, weary, death

The sentiment of the text is Negative.
```

### Solution

```javascript
let sentiment = function sentiment(text) {
  let positives = text.match(positiveRegex);
  let negatives = text.match(negativeRegex);

  logSentiment(positives, 'positive');
  logSentiment(negatives, 'negative');

  console.log(`The sentiment of the text is ${overallSentiment(positives.length, negatives.length)}.`);
};
```

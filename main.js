var fs = require('fs');
var PEG = require('pegjs');

var parser, grammar;

grammar = fs.readFileSync('language.pegjs', 'utf8');
parser = PEG.buildParser(grammar);

console.log(parser.parse('@f(test)'));
prettyPrint(parser.parse('@f(ClassName.method, @i(stuff), things, @f(morethings, @f(deep, nesting), otherstuff))'));

function prettyPrint(obj) {

	console.log(JSON.stringify(obj, null, 4));

}
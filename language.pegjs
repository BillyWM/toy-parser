//Helper code to clean up the tree as it's built
// (ES6. Go install Node 4 or transpile with Babel)
//Grammar begins after functions block

{
	function collapseStrings() {
		var cur;
		var args = Array.prototype.slice.call(arguments);
		for (var i=0; i < args.length; i++) {
			cur = args[i];
			if (Array.isArray(cur)) {
				args[i] = cur.join("");
			}
		}
		
		return args.join("");
	}
	
	function removeCommas(arr) {
		if (!Array.isArray(arr)) return arr;
		return arr.filter(x => x !== ",")
	}
	
	function collapseArray(first, second) {
		first = removeCommas(first);
		second = removeCommas(second);		
		
		return first.concat(second);
	}
	
	// Determine whether the array contains another array
	function containsArray(v) {
		if (!Array.isArray(v)) return v;
		return v.find(x => Array.isArray(x));
	}
}

//================== GRAMMAR BEGINS HERE ===================
start
	= expr
	
expr
	= function / identifier
	
function
	= "@" char "(" arguments ")"
	
//A complete list of arguments to a function call
arguments
	= first:argList* second:arg 				{ return collapseArray(first, second) }
	
argList
	= first:arg ws "," ws 						{ return first }
	
//A single argument to a function call
arg
	= methodName / expr
	
methodName
	= first:word  second:("." word)? 			{ return collapseStrings(first, second) }
	
identifier
	= word

char
	= [a-z]i

word
	= chars:[a-zA-Z]+ 							{ return chars.join('') }
	
ws
	= " "*
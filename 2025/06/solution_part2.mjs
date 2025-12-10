import fs from "node:fs/promises";

/** @type {string} */
const input = await fs.readFile("./input.txt", "utf-8");
const mathHomework = input.split("\n").map((line) => line.split(""));

/** @type {(string|number)[]} */
const mathHomeworkProblems = [];
const mathOperatorRowIndex = mathHomework.length - 1;
let columnnIndex = mathHomework[mathOperatorRowIndex].length - 1;
while (columnnIndex >= 0) {
	/** @type {string|null} */
	let operator = null;
	/** @type {string[]} */
	const operand = [];

	mathHomework.forEach((row, index) => {
		const char = row[columnnIndex];
		if (index === mathOperatorRowIndex && (char === "+" || char === "*")) {
			operator = char;
		} else if (char !== " ") {
			operand.push(char);
		}
	});

	mathHomeworkProblems.push(Number(operand.join("")));
	if (operator === null) {
		columnnIndex -= 1;
	} else {
		mathHomeworkProblems.push(operator);
		// next column will probably be empty so skip it by subtracting 2
		columnnIndex -= 2;
	}
}

let grandTotal = 0;
/** @type {number[]} */
const operands = [];
while (mathHomeworkProblems.length > 0) {
	const item = mathHomeworkProblems.shift();
	if (item === "+") {
		grandTotal += operands.reduce((acc, curr) => acc + curr, 0);
		operands.length = 0;
	} else if (item === "*") {
		grandTotal += operands.reduce((acc, curr) => acc * curr, 1);
		operands.length = 0;
	} else {
		operands.push(item);
	}
}
console.log("Grand total:", grandTotal);

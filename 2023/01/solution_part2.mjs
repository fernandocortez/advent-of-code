import fs from "node:fs/promises";

/** @type {string} */
const input = await fs.readFile("./input.txt", "utf-8");
/** @type {string[]} */
const lines = input.split("\n");

const digits = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];
const digitsAsWords = [
	"one",
	"two",
	"three",
	"four",
	"five",
	"six",
	"seven",
	"eight",
	"nine",
];

let sum = 0;
lines.forEach((line) => {
	let tens = 0;
	let ones = 0;
	let tensIndex = line.length - 1;
	let onesIndex = 0;

	digits.forEach((value, index) => {
		let idx;
		idx = line.indexOf(value);
		if (idx >= 0 && idx <= tensIndex) {
			tensIndex = idx;
			tens = index + 1;
		}
		idx = line.lastIndexOf(value);
		if (idx >= 0 && idx >= onesIndex) {
			onesIndex = idx;
			ones = index + 1;
		}
	});

	digitsAsWords.forEach((value, index) => {
		let idx;
		idx = line.indexOf(value);
		if (idx >= 0 && idx <= tensIndex) {
			tensIndex = idx;
			tens = index + 1;
		}
		idx = line.lastIndexOf(value);
		if (idx >= 0 && idx >= onesIndex) {
			onesIndex = idx;
			ones = index + 1;
		}
	});

	sum += tens * 10 + ones;
});
console.log("Sum:", sum);

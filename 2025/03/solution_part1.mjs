import fs from "node:fs/promises";

/** @type {string} */
const input = await fs.readFile("./input.txt", "utf-8");
/** @type {number[][]} */
const data = input.split("\n").map((range) => range.split("").map(Number));

let sum = 0;

data.forEach((digits) => {
	const first = Math.max(...digits.slice(0, digits.length - 1));
	const indexOfFirst = digits.indexOf(first);
	const second = Math.max(...digits.slice(indexOfFirst + 1));
	sum += first * 10 + second;
});

console.log("Sum:", sum);

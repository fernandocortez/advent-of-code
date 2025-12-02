import { open } from "node:fs/promises";

const file = await open("input.txt");

/** @type {number[]} */
const instructions = [];

for await (const line of file.readLines()) {
	if (line.startsWith("L")) {
		const digits = parseInt(line.substring(1), 10);
		instructions.push(-1 * digits);
	} else if (line.startsWith("R")) {
		const digits = parseInt(line.substring(1), 10);
		instructions.push(digits);
	}
}

let dial = 50;
let password = 0;
instructions.forEach((instruction) => {
	dial = (dial + instruction + 100) % 100;
	if (dial === 0) {
		password++;
	}
});

console.log("Password:", password);

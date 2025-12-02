import { open } from "node:fs/promises";

const file = await open("./input.txt");

let dial = 50;
let password = 0;

for await (const line of file.readLines()) {
	let instruction = Number(line.substring(1));
	if (line.startsWith("L")) {
		instruction *= -1;
	}

	while (instruction !== 0) {
		if (dial === 0) {
			password++;
		}
		if (instruction < 0) {
			instruction += 1;
			dial -= 1;
		} else {
			instruction -= 1;
			dial += 1;
		}
		if (dial < 0) {
			dial = 99;
		} else if (dial > 99) {
			dial = 0;
		}
	}
}

console.log("Password:", password);

import fs from "node:fs/promises";

/** @type {string} */
const input = await fs.readFile("./input.txt", "utf-8");
const diagram = input.split("\n").map((line) => line.split(""));
const diagramHeight = diagram.length;
const diagramWidth = diagram[0].length;

/** @type {number[]} */
const beamLocations = Array(diagramWidth).fill(0);
const startingIndex = diagram[0].indexOf("S");
beamLocations[startingIndex] = 1;

for (let rowIdx = 1; rowIdx < diagramHeight; rowIdx++) {
	for (let colIdx = 0; colIdx < diagramWidth; colIdx++) {
		const char = diagram[rowIdx][colIdx];
		if (char === ".") {
			continue;
		}

		const beamLocation = beamLocations[colIdx];
		if (beamLocation > 0) {
			beamLocations[colIdx - 1] += beamLocation;
			beamLocations[colIdx + 1] += beamLocation;
			beamLocations[colIdx] = 0;
		}
	}
}

const timeslinesCreatedCount = beamLocations.reduce(
	(acc, curr) => acc + curr,
	0,
);
console.log("Timelines count:", timeslinesCreatedCount);

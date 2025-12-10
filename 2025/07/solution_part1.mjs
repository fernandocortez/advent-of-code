import fs from "node:fs/promises";

/** @type {string} */
const input = await fs.readFile("./input.txt", "utf-8");
const diagram = input.split("\n").map((line) => line.split(""));

let beamSplitCount = 0;
/** @type {Set<number>} */
const activeTachyonBeamIndexes = new Set();
diagram.forEach((row, rowIdx) => {
	/** @type {Set<number>} */
	const newTachyonBeams = new Set();
	if (rowIdx === 0) {
		const startingIndex = row.findIndex((char) => char === "S");
		newTachyonBeams.add(startingIndex);
	} else {
		row.forEach((char, colIdx) => {
			if (char === "^" && activeTachyonBeamIndexes.has(colIdx)) {
				beamSplitCount++;
				activeTachyonBeamIndexes.delete(colIdx);
				newTachyonBeams.add(colIdx - 1);
				newTachyonBeams.add(colIdx + 1);
			}
		});
	}

	newTachyonBeams.forEach((index) => {
		activeTachyonBeamIndexes.add(index);
	});
});
console.log("Beam split count:", beamSplitCount);

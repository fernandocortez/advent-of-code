package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

func main() {
	// f, err := os.Open("test_input_1.txt")
	f, err := os.Open("puzzle_input.txt")
	if err != nil {
		fmt.Println(err)
		return
	}
	defer f.Close()

	sum := 0
	s := bufio.NewScanner(f)
	for s.Scan() {
		sum += process_line(s.Text())
	}
	fmt.Println(sum)
}

func process_line(line string) int {
	// remove all non-digits from string
	re := regexp.MustCompile(`\D`)
	digits_from_line := re.ReplaceAllString(line, "")

	length := len(digits_from_line)
	if length == 0 {
		return 0
	}

	tens := digits_from_line[0]
	ones := digits_from_line[length-1]
	result := string([]byte{tens, ones})
	parsed, err := strconv.Atoi(result)
	if err != nil {
		panic(err)
	}
	return parsed
}

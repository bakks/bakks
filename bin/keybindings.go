package main

// Simple script for reading my README.md file, parsing out the
// shortcut keys listed there, and displaying them nicely in the
// console.

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"regexp"
)

func readFile(filename string) []string {
	f, err := os.OpenFile(filename, os.O_RDONLY, 0)
	if err != nil {
		log.Fatal(err)
	}
	defer func() {
		if err = f.Close(); err != nil {
			log.Fatal(err)
		}
	}()

	lines := []string{}
	s := bufio.NewScanner(f)

	for s.Scan() {
		err = s.Err()
		if err != nil {
			log.Fatal(err)
		}

		lines = append(lines, s.Text())
	}

	return lines
}

const SEARCH_LINE = "## Keyboard Cheat Sheet"
const FILENAME = "../README.md"
const BOLD = "\033[1m"
const NORMAL = "\033[0m"
const CYAN = "\u001B[36m"
const WHITE = "\u001B[37m"
const RED = "\u001B[31m"

var TITLE_LINE = *regexp.MustCompile(`(#+) (.+)`)
var KEY_COMBO = *regexp.MustCompile(`\*\*(.+)\*\*`)
var DEFINITION = *regexp.MustCompile(`: (.+)`)

func printIndent(n int) {
	s := ""
	for i := 0; i < n; i++ {
		s += "  "
	}
	fmt.Printf(s)
}

func printTitle(title string) {
	fmt.Printf("%s%s%s\n", BOLD, title, NORMAL)
}

func printKeyBinding(keyCombo, definition string) {
	fmt.Printf("%s%-6s   %s%s%s\n", CYAN, keyCombo, RED, definition, WHITE)
}

func reformatKeys(lines []string) {
	i := 0

	// find starting line
	for ; i < len(lines) && lines[i] != SEARCH_LINE; i++ {
	}

	if i == len(lines) {
		panic(fmt.Sprintf("Could not find starting line \"%s\" in %s\n", SEARCH_LINE, FILENAME))
	}

	indent := -1
	var lastKeyCombo string

	for ; i < len(lines); i++ {
		line := lines[i]

		if line == "" {
			continue

			// If we match TITLE_LINE (e.g. ## Foo)
		} else if res := TITLE_LINE.FindStringSubmatch(line); res != nil {
			indent = len(res[1]) - 2
			printIndent(indent - 1)
			printTitle(res[2])

			// If we match KEY_COMBO (e.g. **<c-r>**)
		} else if res := KEY_COMBO.FindStringSubmatch(line); res != nil {
			lastKeyCombo = res[1]

			// If we match DEFINITION (e.g. : Foo)
		} else if res := DEFINITION.FindStringSubmatch(line); res != nil {
			definition := res[1]
			printIndent(indent)
			printKeyBinding(lastKeyCombo, definition)
		} else {
			//fmt.Printf("Could not match line \"%s\"\n", line)
		}
	}

}

func main() {
	lines := readFile("../README.md")
	reformatKeys(lines)
}

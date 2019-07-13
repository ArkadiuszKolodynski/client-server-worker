package main

import (
	"errors"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

type worker struct {
	expression string
}

func new(expression string) worker {
	w := worker{expression}
	return w
}

func (w worker) calculate() (float64, error) {
	var stack []float64
	for _, token := range strings.Fields(w.expression) {
		switch token {
		case "+":
			stack[len(stack)-2] += stack[len(stack)-1]
			stack = stack[:len(stack)-1]
		case "-":
			stack[len(stack)-2] -= stack[len(stack)-1]
			stack = stack[:len(stack)-1]
		case "*":
			stack[len(stack)-2] *= stack[len(stack)-1]
			stack = stack[:len(stack)-1]
		case "/":
			stack[len(stack)-2] /= stack[len(stack)-1]
			stack = stack[:len(stack)-1]
		case "^":
			stack[len(stack)-2] =
				math.Pow(stack[len(stack)-2], stack[len(stack)-1])
			stack = stack[:len(stack)-1]
		default:
			f, _ := strconv.ParseFloat(token, 64)
			stack = append(stack, f)
		}
	}
	if len(stack) != 1 {
		return float64(math.NaN()), errors.New("Error: invalid expression")
	}
	return stack[0], nil
}

func main() {
	if os.Args[1] == "" {
		fmt.Print("Error: no expression specified")
	} else {
		var expression = os.Args[1]
		var w = new(expression)

		var result, err = w.calculate()

		if err != nil {
			fmt.Print(err)
		} else {
			fmt.Print(result)
		}
	}
}

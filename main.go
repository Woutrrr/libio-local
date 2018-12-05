package main

import "fmt"

func main() {
	fmt.Println("Libraries.io-like api")

	a := App{}

	a.Initialize("root", "pwd", "libio")

	a.Run(":8088")
}

package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

// Some helper function
func transpose(slice [][]string) [][]string {
	xl := len(slice[0])
	yl := len(slice)
	result := make([][]string, xl)
	for i := range result {
		result[i] = make([]string, yl)
	}
	for i := 0; i < xl; i++ {
		for j := 0; j < yl; j++ {
			result[i][j] = slice[j][i]
		}
	}
	return result
}

func WritetoCSV(data [][]string, filename string) {
	curPath, err := filepath.Abs(filename)
	if err != nil {
		fmt.Println(err)
	}
	csvFile, err := os.Create(curPath)
	if err != nil {
		fmt.Println(err)
	}
	csvWriter := csv.NewWriter(csvFile)
	err = csvWriter.WriteAll(data)
	if err != nil {
		fmt.Println(err)
	}
	csvWriter.Flush()
	csvFile.Close()
}

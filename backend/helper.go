package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
	"reflect"
	"sort"

	"gonum.org/v1/gonum/floats"
	"gonum.org/v1/gonum/stat/distuv"
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

// RouletteDrawN draws n numbers randomly from a probability mass function (PMF) defined by weights in p.
// RouletteDrawN implements the Roulette Wheel Draw a.k.a. Fitness Proportionate Selection:
// - https://en.wikipedia.org/wiki/Fitness_proportionate_selection
// - http://www.keithschwarz.com/darts-dice-coins/
// It returns a slice of n indices into the vector p.
// It fails with error if p is empty or nil.
func RouletteDrawN(p []float64, n int) ([]int, error) {
	if p == nil || len(p) == 0 {
		return nil, fmt.Errorf("Invalid probability weights: %v", p)
	}
	// Initialization: create the discrete CDF
	// We know that cdf is sorted in ascending order
	cdf := make([]float64, len(p))
	floats.CumSum(cdf, p)
	// Generation:
	// 1. Generate a uniformly-random value x in the range [0,1)
	// 2. Using a binary search, find the index of the smallest element in cdf larger than x
	var val float64
	indices := make([]int, n)
	for i := range indices {
		// multiply the sample with the largest CDF value; easier than normalizing to [0,1)
		val = distuv.UnitUniform.Rand() * cdf[len(cdf)-1]
		// Search returns the smallest index i such that cdf[i] > val
		indices[i] = sort.Search(len(cdf), func(i int) bool { return cdf[i] > val })
	}

	return indices, nil
}

func stringifyData(TransactionDataList []Transaction) string {
	var record string
	for i := 0; i < len(TransactionDataList); i++ {
		v := reflect.ValueOf(TransactionDataList[i])
		// v.Type() gives the field name
		for j := 0; j < v.NumField(); j++ {
			record = record + fmt.Sprintf("%v", v.Field(j).Interface())
		}
	}
	fmt.Println("Can stringify data here")
	return record
}

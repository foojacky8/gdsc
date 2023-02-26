package main

import (
	"context"
	"encoding/csv"
	"fmt"
	"math/rand"
	"net/http"
	"os"
	"strconv"
)

// This module contains function related to user account

func verifyJWT(_ http.ResponseWriter, request *http.Request) (string, error) {
	if request.Header["Token"] != nil {
		tokenString := request.Header["Token"][0]
		uid, err := Auth.VerifyIDToken(context.Background(), tokenString)
		if err != nil {
			fmt.Println("Error verifying token: ", err)
		}
		fmt.Println("The uid encoded is ", uid.UID)
	}
	return "", nil
}

func ObtainEnergyData() ([]float64, []float64) {
	var GenData []float64
	var gen float64
	var UseData []float64
	var use float64

	file, err := os.Open("GenInHours.csv")
	if err != nil {
		fmt.Println(err)
	}
	records, err := csv.NewReader(file).ReadAll()
	if err != nil {
		fmt.Println(err)
	}
	// generate a random number that is multiple of 24
	RandomInt := rand.Intn(349)
	Start := RandomInt * 24
	for i := 0; i < 24; i++ {
		gen, _ = strconv.ParseFloat(records[Start+i][0], 32)
		GenData = append(GenData, gen)
		use, _ = strconv.ParseFloat(records[Start+i][1], 32)
		UseData = append(UseData, use)
	}
	fmt.Println("Gen Data: ", GenData)
	fmt.Println("Use Data: ", UseData)

	return GenData, UseData
}

func handleGetEnergyData(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var newEnergyData UserEnergyData
	newEnergyData.GenData, newEnergyData.UseData = ObtainEnergyData()
	respondWithJSON(w, r, http.StatusAccepted, newEnergyData)
}

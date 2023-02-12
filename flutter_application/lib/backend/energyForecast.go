package main

import (
	"encoding/csv"
	"fmt"
	"net/http"
	"os"
	"os/exec"
	"strconv"
	"time"
)

func handleEnergyForecast(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	// verify jwt token and obtain user id
	userID, err := verifyJWT(w, r)
	if err != nil {
		fmt.Println(err)
	}

	// use the user id to obtain user's energy data
	UserData, err := GetEnergyDataById(userID)

	// write the energy data into csv file
	timeslot := time.Now().Hour()
	var empData [][]string
	var PreviousGenData []string
	var PreviousUseData []string
	PreviousGenData = append(PreviousGenData, "gen [kWh]")
	PreviousUseData = append(PreviousUseData, "use [kWh]")
	for i := timeslot; i < 24; i++ {
		PreviousGenData = append(PreviousGenData, fmt.Sprintf("%v", UserData.GenData[i]))
		PreviousUseData = append(PreviousUseData, fmt.Sprintf("%v", UserData.UseData[i]))
	}
	for i := 0; i < timeslot; i++ {
		PreviousGenData = append(PreviousGenData, fmt.Sprintf("%v", UserData.GenData[i]))
		PreviousUseData = append(PreviousUseData, fmt.Sprintf("%v", UserData.UseData[i]))
	}
	empData = append(empData, PreviousGenData)
	empData = append(empData, PreviousUseData)
	empData = transpose(empData)
	WritetoCSV(empData, "EnergyData.csv")

	//call energyForecast.py script
	cmd := exec.Command("python", "energyForecast.py")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err = cmd.Run()
	if err != nil {
		fmt.Println(err)
	}

	// retrieve the result
	newPredResult := ObtainPredictionResult()

	// respond with json
	respondWithJSON(w, r, http.StatusAccepted, newPredResult)

}

func ObtainPredictionResult() PredResult {
	var newPredResult PredResult

	file, err := os.Open("PredictionResult.csv")
	if err != nil {
		fmt.Println(err)
	}
	records, err := csv.NewReader(file).ReadAll()
	if err != nil {
		fmt.Println(err)
	}
	newPredResult.GenData, _ = strconv.ParseFloat(records[1][0], 32)
	newPredResult.UseData, _ = strconv.ParseFloat(records[1][1], 32)

	return newPredResult
}

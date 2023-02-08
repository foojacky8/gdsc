package main

import (
	"encoding/json"
	"net/http"

	"github.com/gorilla/mux"
)

func makeMuxRouter() http.Handler {
	r := mux.NewRouter()

	// return genData and useData to frontend to be stored in database
	r.HandleFunc("/getEnergyData", handleGetEnergyData).Methods("GET")

	// all request below will verify the jwtToken in HTTP request header

	// takes in bid information and append to an array contain all bids
	r.HandleFunc("/energyRequest", handleEnergyRequest).Methods("POST")

	// not yet done
	// this function will forecast the user's energy production and usage
	r.HandleFunc("/energyForecast", handleEnergyForecast).Methods("GET")

	// this function will send the blockchain to frontend
	//r.HandleFunc("/getBlockchain", handleGetBlockchain).Methods("GET")

	// Some dummy handle function to start auction and create request
	r.HandleFunc("/initAuction", handleInitAuction).Methods("GET")
	r.HandleFunc("/createRequest", createSomeRequest).Methods("GET")
	return r
}

// Obtain from mycoralhealth website, simply return the HTTP status and data to the front end
func respondWithJSON(w http.ResponseWriter, r *http.Request, code int, payload interface{}) {
	response, err := json.MarshalIndent(payload, "", "  ")
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte("HTTP 500: Internal Server Error"))
		return
	}
	w.WriteHeader(code)
	w.Write(response)
}

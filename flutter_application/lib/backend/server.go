package main

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/gorilla/mux"
)

func makeMuxRouter() http.Handler {
	r := mux.NewRouter()

	// takes in email and password as input, return jwtToken if success, else will return a HTTP bad request
	r.HandleFunc("/login", handleUserLogin).Methods("POST")

	// takes in user information and return jwtToken if success
	r.HandleFunc("/signUp", handleSignUp).Methods("POST")

	// all request below will verify the jwtToken in HTTP request header

	// takes in bid information and append to an array contain all bids
	r.HandleFunc("/energyRequest", handleEnergyRequest).Methods("POST")

	// not yet done
	// this function will forecast the user's energy production and usage
	r.HandleFunc("/energyForecast", handleEnergyForecast).Methods("GET")

	// this function will send the blockchain to frontend
	r.HandleFunc("/getBlockchain", handleGetBlockchain).Methods("GET")

	// Some dummy handle function to start auction and create request
	r.HandleFunc("/initAuction", handleInitAuction).Methods("GET")
	r.HandleFunc("/createRequest", createSomeRequest).Methods("GET")
	return r
}

func handleGetBlockchain(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var newBlock Block
	newBlock.Index = 1
	newBlock.Data.Energy = 10
	newBlock.Data.Money = 10
	newBlock.Data.UserID = "A001"
	newBlock.Hash = "asdf"
	newBlock.PrevHash = "qwer"
	Blockchain = append(Blockchain, newBlock)
	respondWithJSON(w, r, http.StatusAccepted, Blockchain)
	fmt.Println(Blockchain)
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

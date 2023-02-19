package main

import (
	"encoding/json"
	"io/ioutil"
	"net/http"

	"github.com/gorilla/mux"
)

func makeMuxRouter() http.Handler {
	r := mux.NewRouter()
	r.HandleFunc("/", showData).Methods("GET")
	r.HandleFunc("/login", handleUserLogin).Methods("POST")
	r.HandleFunc("/signUp", handleSignUp).Methods("POST")
	r.HandleFunc("/energyRequest", handleEnergyRequest).Methods("POST")
	r.HandleFunc("/energyForecast", handleEnergyForecast).Methods("GET")
	//r.HandleFunc("/biddingRange", handleBiddingRange).Methods("POST")
	//r.HandleFunc("/getBlockchain", handleGetBlockchain).Methods("GET")
	r.HandleFunc("/initAuction", handleInitAuction).Methods("GET")
	r.HandleFunc("/clearBlockchain", handleClearBlockchain).Methods("GET")
	r.HandleFunc("/createRequest", createSomeRequest).Methods("GET")
	r.HandleFunc("/initPoS", handleInitPoS).Methods("GET")
	r.HandleFunc("/verifyTransaction", handleVerifyTransaction).Methods("POST")
	r.HandleFunc("/readyToAppend", handleReadyToAppend).Methods("GET")
	return r
}

// Obtain from mycoralhealth website
func showData(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	respondWithJSON(w, r, http.StatusAccepted, SomeData)
}

func handleClearBlockchain(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	jsonFile, _ := json.MarshalIndent(nil, "", " ")

	ioutil.WriteFile("./node_1/Blockchain.json", jsonFile, 0644)
	ioutil.WriteFile("./node_2/Blockchain.json", jsonFile, 0644)
	ioutil.WriteFile("./node_3/Blockchain.json", jsonFile, 0644)
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
